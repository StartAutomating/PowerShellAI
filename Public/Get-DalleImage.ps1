function Get-DalleImage { 
    <#
        .SYNOPSIS
        Get a DALL-E image from the OpenAI API
        
        .DESCRIPTION
        Given a description, the model will return an image

        .PARAMETER Description
        The description to generate an image for

        .PARAMETER Size
        The size of the image to generate. Defaults to 256

        .PARAMETER Raw
        If set, the raw response will be returned. Otherwise, the image will be saved to a temporary file and the path to that file will be returned

        .EXAMPLE
        Get-DalleImage -Description "A cat sitting on a table"
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        $Description,
        [ValidateSet('256', '512', '1024')]
        $Size = 256,
        [Switch]$Raw
    )

    if (!(Test-OpenAIKey)) {
        throw 'You must set the $env:OpenAIKey environment variable to your OpenAI API key. https://beta.openai.com/account/api-keys'
    }

    $targetSize = switch ($Size) {
        256 { '256x256' }
        512 { '512x512' }
        1024 { '1024x1024' }     
    }
  
    $body = [ordered]@{
        prompt = $Description
        size   = $targetSize
    }
  
    $params = @{
        Uri         = "https://api.openai.com/v1/images/generations" 
        Method      = 'Post' 
        Headers     = @{Authorization = "Bearer $($env:OpenAIKey)" } 
        ContentType = 'application/json'
        body        = $body | ConvertTo-Json -Depth 5
    }    
  
    $result = Invoke-RestMethod @params
  
    if ($Raw) {
        return $result
    }
    else {
        $DestinationPath = [IO.Path]::GetTempFileName() -replace ".tmp", ".png"
        Invoke-RestMethod $result.data.url -OutFile $DestinationPath
        $DestinationPath
    }
}