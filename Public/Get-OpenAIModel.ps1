function Get-OpenAIModel {
    [CmdletBinding()]
    <#
        .SYNOPSIS
        Get a list of current OpenAI GPT-3 API models

        .DESCRIPTION
        Returns full model properties, or just the names (id values)

        .PARAMETER Raw
        Returns the raw JSON response from the API

        .EXAMPLE
        Get-OpenAIModel

        .EXAMPLE
        Get-OpenAIModel -Raw

        .NOTES
        This function requires the 'OpenAIKey' environment variable to be defined before being invoked
        Reference: https://platform.openai.com/docs/models/overview
        Reference: https://platform.openai.com/docs/api-reference/models
	#>
    param(
        [Switch]$Raw
    )

    $response = Invoke-OpenAIAPI -Uri (Get-OpenAIModelsURI)

    if ($Raw) {
        $response
    }
    else {
        $response.data.id
    }
}