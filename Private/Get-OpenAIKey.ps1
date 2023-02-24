function Get-OpenAIKey {
	if ($null -ne $Script:OpenAIKey) {
        ConvertFrom-SecureString -SecureString $Script:OpenAIKey -AsPlainText
    } else {
        $env:OpenAIKey
    }
}
