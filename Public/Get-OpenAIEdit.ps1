function Get-OpenAIEdit {
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
	[CmdletBinding()]
	param(
		[Parameter(Mandatory)]
		$InputText,
		[Parameter(Mandatory)]
		$Instruction,
		[Parameter()]
		[ValidateSet('text-davinci-edit-001', 'code-davinci-edit-001')]
		$model = 'text-davinci-edit-001',
		[Parameter()]
		$numberOfEdits = 1,
		[ValidateRange(0, 2)]
		[decimal]$temperature = 0.0,
		[ValidateRange(0, 1)]
		[decimal]$top_p = 1.0,
		[Switch]$Raw
	)

	$body = @{
		"model"       = $model
		"temperature" = $temperature
		"top_p"       = $top_p
		"input"       = $InputText
		"instruction" = $Instruction
		"n"           = $numberOfEdits
	} | ConvertTo-Json

	$response = Invoke-OpenAIAPI -Uri (Get-OpenAIEditsURI) -Method Post -Body $body

	if ($Raw) {
		$response
	}
	else {
		$response.choices[0].text
	}
}