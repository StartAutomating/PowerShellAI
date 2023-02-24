function Test-OpenAIKey {
    <#
        .SYNOPSIS
        Tests if the OpenAIKey module scope variable or environment variable is set.

        .EXAMPLE
        Test-OpenAIKey
    #>
    $null -ne $Script:OpenAIKey -or -not [string]::IsNullOrEmpty($env:OpenAIKey)
}
