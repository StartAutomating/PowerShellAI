Import-Module "$PSScriptRoot\..\PowerShellAI.psd1" -Force

Describe "Set-OpenAIKey" -Tag 'SetOpenAIKey' {
    It "Should throw when Key is null" {
		{Set-OpenAIKey -Key $null} | Should -Throw
    }

	It "Should throw when Key is empty" {
        {Set-OpenAIKey -Key ([System.Security.SecureString]::new())} | Should -Throw
    }

	It "Should throw when Key is not SecureString type" {
        {Set-OpenAIKey -Key 'NotSecureStringType'} | Should -Throw
    }

	It "Should accept valid secure string as Key" {
        {Set-OpenAIKey -Key (ConvertTo-SecureString -String 'FakeOpenAIKey' -AsPlainText -Force)} | Should -Not -Throw
    }
}
