function Test-OpenAIKey {
    -not [string]::IsNullOrEmpty($env:OpenAIKey)
}