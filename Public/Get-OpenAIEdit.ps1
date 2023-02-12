function Get-OpenAIEdit {
	[CmdletBinding()]
	<#
		.SYNOPSIS
		Given a prompt and an instruction, the model will return an edited version of the prompt

		.DESCRIPTION
		Creates a new edit for the provided input, instruction, and parameters.

		.PARAMETER InputText
		Prompt text to evaluate

		.PARAMETER Instruction
		The instruction that tells the model how to edit the prompt

		.PARAMETER model
		ID of the model to use. You can use the text-davinci-edit-001 or code-davinci-edit-001 model with this endpoint. Default is text-davinci-edit-001

		.PARAMETER edits
		How many edits to generate for the input and instruction
		.EXAMPLE
		Get-OpenAIEdit -InputText "What day of the wek is it?" -Instruction "Fix the spelling mistakes"

		.NOTES
		This function requires the 'OpenAIKey' environment variable to be defined before being invoked
		Reference: https://platform.openai.com/docs/guides/edits/quickstart
		Reference: https://platform.openai.com/docs/api-reference/edits
	#>

	param(
		[Parameter(Mandatory)]
		$InputText,
		[Parameter(Mandatory)]
		$Instruction,
		[Parameter()][string][ValidateSet('text-davinci-edit-001','code-davinci-edit-001')]$model = 'text-davinci-edit-001',
		[Parameter()]$edits = 1,
		[Switch]$Raw
	)

	$body = @{
		"model" = $model
		"input" = $InputText
		"instruction" = $Instruction
		"n" = $edits
	} | ConvertTo-Json

	$response = Invoke-OpenAIAPI -Uri (Get-OpenAIEditsURI) -Method Post -Body $body

	if ($Raw) {
		$response
	}
	else {
		$response.choices | Select-Object -ExpandProperty text
	}
}