function Get-OpenAIBaseRestURI {
    <#
        .Synopsis
        Base url for OpenAIBase API
        
        .Example
        Invoke-RestMethod ((Get-GHBaseRestURI)+'/repos/powershell/powershell')
    #>
    
    'https://api.openai.com/v1'
}