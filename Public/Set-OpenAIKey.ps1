function Set-OpenAIKey {
    <#
        .SYNOPSIS
        Set the OpenAI API Key.

        .DESCRIPTION
        Sets the OpenAI API Key using secure string.

        .PARAMETER Key
        Specifies OpenAI API Key secure string.
        .EXAMPLE
        Set-OpenAIKey -Key (Get-Secret -Name MyOpenAIKey)
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ValidateScript({if ($_.Length) {$true} else {throw 'OpenAIKey cannot be empty.'}})]
        [ValidateNotNullOrEmpty()]
        [System.Security.SecureString]
        $Key
    )

    $Script:OpenAIKey = $Key
}
