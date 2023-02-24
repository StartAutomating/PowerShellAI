function Get-OpenAIKey {
    <#
        .SYNOPSIS
        Gets the OpenAIKey module scope variable or environment variable.

        .EXAMPLE
        Get-OpenAIKey
    #>
    if ($null -ne $Script:OpenAIKey) {
        if ($PSVersionTable.PSVersion.Major -gt 6) {
            #On PowerShell 7 and higher use AsPlainText parameter
            ConvertFrom-SecureString -SecureString $Script:OpenAIKey -AsPlainText
        } else {
            #On PowerShell 6 and lower use .NET marshaling
            [Runtime.InteropServices.Marshal]::PtrToStringAuto(
                [Runtime.InteropServices.Marshal]::SecureStringToBSTR($Script:OpenAIKey)
            )
        }
    } else {
        $env:OpenAIKey
    }
}
