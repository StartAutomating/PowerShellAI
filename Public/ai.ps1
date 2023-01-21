function ai {
    <#
        .SYNOPSIS
        This is **Experimental** AI function
        .DESCRIPTION
        Experimental AI function that you can pipe all sorts of things into and get back a completion

        .EXAMPLE
        ai "list of planets only names as json" |
        .EXAMPLE
        ai "list of planets only names as json" | ai 'convert to  xml' 
        .EXAMPLE
        ai "list of planets only names as json" | ai 'convert to  xml' | ai 'convert to  powershell'
        .EXAMPLE
        git status | ai "create a detailed git message"
    #>
    param(
        $inputPrompt,
        [Parameter(ValueFromPipeline = $true)]
        $target
    )

    Begin {
        [System.Collections.ArrayList]$lines = @()
    }

    Process {
        $lines += $target
    }

    End {
        $fullPrompt = @"
$($inputPrompt)
$(($lines | Out-String).Trim())

"@
        
        Get-GPT3Completion $fullPrompt.Trim()
    }
}
