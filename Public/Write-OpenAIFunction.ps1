function Write-OpenAIFunction {
    <#
    .SYNOPSIS
        Writes an OpenAI function
    .DESCRIPTION
        Writes a function that prompts an AI using several variables
    .EXAMPLE
        Write-AIFunction -Prompt {
            "Write a recipe based on these ingredients and instructions: $Ingredients"
        }
    .EXAMPLE
        . (
            Write-OpenAIFunction -Prompt "Get Planets Name, Mass, Diameter, Distance (in AU) as JSON numbers" -AIParameter @{
                max_tokens=2kb
            } -ForeachObject {
                $_ | ConvertFrom-JSON
            }
        )

        Get-Planets
    .EXAMPLE
        Write-AIFunction -Prompt {
            "Write a recipe based on these ingredients and instructions: $Ingredients"
        } -ForeachObject {
            $recipe = $_
            Write-Verbose $recipe
            $recipeName, $ingredients, $instructions = $recipe -split "(?>Instructions|Ingredients):"
            $ingredients = @($ingredients -split '[\r\n]' -ne '' -replace '^-\s+')
            $instructions = @($instructions -split '\d+\.' -notmatch '^\s{0,}$')
            [PSCustomObject][Ordered]@{
                PSTypeName = 'AI.Recipe'
                Name = $RecipeName
                Ingredients = $ingredients
                Instructions = $instructions                
            }
        } -Example {
            Write-Recipe 'Maccaroni', 'Cheese'
        }
    #>
    [Alias('Write-AIFunction')]
    [CmdletBinding(PositionalBinding=$false)]
    [OutputType([Scriptblock])]
    param(
    # The prompt you would like to turn into a function.
    # Any PowerShell variables within the prompt will become parameters.
    # If a PowerShell variable is followed by `?`, it will be an optional parameter.
    [Parameter(Mandatory,Position=0)]
    [string]
    $Prompt,

    # The verb of the function.
    # If this is not provided, the first valid PowerShell verb will be used.
    [string]
    $Verb,

    # The noun of the function.
    # If this is not provided, the first non-verb and non-article word will be used as the noun.
    # For example:  Write a Novel would have the verb Write and the noun Novel.
    [string]
    $Noun,

    # The name of the command that this function will use as a base (by default 'ai')
    # The prompt will be passed as the first positional parameter to this command.
    [string]
    $AICommand = 'ai',

    # Any parameters to pass to the -AICommand.
    [Collections.IDictionary]
    [Alias('AIParameters')]
    $AIParameter,

    # A synopsis for the function.
    # If not provided, the first 3 words will be used.
    [string]
    $Synopsis,

    # A description for the function.
    # If not provided, one will be generated from the -BaseCommand and -Prompt
    [string]
    $Description,

    # A dictionary of help for any parameters.
    # If no help is found, the help will be "The $ParameterName"
    [Collections.IDictionary]
    $ParameterHelp = @{},
    
    # Any examples you would like to include.
    [string[]]
    $Example,

    # Any code to be run before asking AI.
    [ScriptBlock]
    $Begin,

    # If provided, will run this script whenever a result is returned from AI.
    [Parameter(Position=1)]
    [Alias('Process','ForeachResult')]
    [ScriptBlock]    
    $ForeachObject,

    # Any code to run after asking AI.
    [ScriptBlock]
    $End
    )

    process {
        # Before we get to far, let's make sure the -Prompt is in a form we can work with.

        # While the -Prompt is a [string], 
        # it may have been provided as a [ScriptBlock] with a doubly-quoted expression or heredoc

        # If it was,
        if ($prompt -match '^\s{0,}\@{0,1}"' -or $prompt -match '"\s{0,}$') {
            $prompt = $prompt -replace '^\s{0,}"' -replace '"\@{0,1}\s{0,}$' # strip those quotes
        }
        
        # Now, split the prompt into individual words.
        $promptWords = @($prompt -split '\s+')

        # If we don't have a verb or a noun
        if (-not $verb -or -not $Noun) {
            # we can try to infer them from the official verb list.
            $possibleVerbs = Get-Verb | Select-Object -ExpandProperty Verb

            # If there was no verb,
            if (-not $verb) {                          
                # check each word      
                foreach ($promptWord in $promptWords) {
                    # to see if it's in the verb list.
                    if ($promptWord -in $possibleVerbs) {
                        # If it is, that's our verb!
                        $verb = $promptWord; break
                    }
                }

                # If we still have no clue, make it a good old fashioned Get.
                if (-not $verb) {
                    $verb = 'Get'
                }
            }
            
            # If there was no noun,
            if (-not $noun) {
                # check each word.
                foreach ($promptWord in $promptWords) {
                    # If it was in the verbs list or it's an indefinite article or blank
                    if ($promptWord -in $possibleVerbs -or 
                        $promptWord -in 'a','the', '') {
                        # keep moving
                        continue
                    }

                    # until we've found a noun.
                    $noun = $promptWord
                    break
                }
            }
        }

        # If there was no synopsis
        if (-not $Synopsis) {
            # use the first three words for the synopsis
            $Synopsis  = $promptWords[0..2] -join ' '
        }

        # If there was no description
        if (-not $Description) {
            # use the -BaseCommand and -Prompt to make one.
            $Description = "Prompts $BaseCommand : `"$Prompt`""
        }

        # Next we need to make the parameter block.
        # To do that, we pick out the variables from the prompt (any word starting with $).
        $promptVariables = $promptWords -like '$*'
        
        $paramBlock =
            # For every variable we found:
            @(foreach ($promptVariable in $promptVariables) {
                $promptVariableName = $promptVariable -replace '^\$'
                # * determine if it's optional (ends with `?`)
                $IsOptional = $promptVariableName -notlike '*?'
                if ($IsOptional) {
                    $promptVariableName = $promptVariableName -replace '\?$'
                }
                # * Output a single string containing all parts of the parameter:
                @(
                    #   * Help comes first
                    if ($ParameterHelp[$promptVariableName]) {
                        '# ' + $ParameterHelp[$promptVariableName] -split '(?>\r\n|\n)' -join (
                            [Environment]::NewLine + '# '
                        )
                    } else {
                        "# The $PromptVariableName"
                    }
                    #   * All parameters should be ValueFromPipelineByPropertyName
                    "[Parameter($(if (-not $IsOptional) {"Mandatory,"})ValueFromPipelineByPropertyName)]"
                    "`$$promptVariableName"
                ) -join [Environment]::NewLine
            }) -join (
                # To finish making the parameter block,
                # we join all of our params together with a comma and newline
                ',' + [Environment]::NewLine
            )

        # Now we can generate the ai function.
        # Many things can be embedded as is:        
        # ( `$Verb, `$Noun, `$Synopsis, `$Description, `$ParamBlock, `$Begin, `$End )        
        $aiFunction = @"
function $Verb-$Noun {
    <#
    .SYNOPSIS
        $Synopsis
    .DESCRIPTION
        $Description
$(
    # Examples are slightly trickier, as we have to match indentation.
    if ($Example) {
        foreach ($ex in $Example) {
            # Each example is:
            @(
                (" " * 4) + # four spaces, followed by
                    '.EXAMPLE' + # '.example', 
                    [Environment]::NewLine + # a newline,
                    (" " * 8 ) + # eight spaces,
                    $(
                        # and each line of the example
                        $ex -split '(?>\r\n|\n)' -join (
                            # (joined by an indented newline)
                            [Environment]::NewLine + (" " * 8)
                        )
                    )
            ) -join [Environment]::NewLine
        }
    }
)
    #>
    param(    
        $(
# Parameter blocks also need to be properly indented (to 8 spaces)
    $ParamBlock -split '(?>\r\n|\n)' -join (
        [Environment]::NewLine + (' ' * 8)
    )
)
    )

    begin {
        `$MyPromptExpression = '$($prompt -replace "'","''")'
        `$aiDefaultParameters = '$(($AIParameter | ConvertTo-Json -Depth 10) -replace "'","''")' | ConvertFrom-JSON
        `$aiParameters = [Ordered]@{}
        foreach (`$property in `$aiDefaultParameters.psobject.properties) {
            `$aiParameters[`$property.Name] = `$property.Value
        }        
        $Begin
    }

    process {
        `$myPrompt = `$executionContext.InvokeCommand.ExpandString(`$MyPromptExpression)        
        $aiCommand `$MyPrompt @aiParameters $(
            # If ForeachObject was passed, we pipe to it
            if ($ForeachObject) {
                # If it contained a process block
                if ($ForeachObject.Ast.ProcessBlock) {
                    # run that script directly
                    "| . {
$ForeachObject
        }"
                } else {
                    # otherwise, make it the -Process parameter for Foreach-Object.
                    "| Foreach-Object {
$ForeachObject
        }"
                }
            }
        )
    }

    end {
        $End
    }
}
"@
        [scriptblock]::Create($aiFunction)
    }
}
