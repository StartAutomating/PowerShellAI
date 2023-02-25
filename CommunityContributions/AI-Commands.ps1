#Requires -Modules PowerShellAI
Function Get-AIResponse {
param(
    [Parameter(Mandatory)]
    $Question
)
$result = ai "Marv is a chatbot that reluctantly answers questions with sarcastic responses: $($Question)?" 
return $result
}

Function New-AIBrainStorm {
param(
    [Parameter(Mandatory)]
    $BrainStorm
)
$result = ai "Brainstorm some ideas $($BrainStorm):" 
return $result
}

Function New-AIRecipe {
param(
    [Parameter(Mandatory)]
    $Ingredients
)
$result = ai "Write a recipe based on these ingredients and instructions: $($Ingredients):" 
return $result
}

Function New-AIStory {
param(
    [Parameter(Mandatory)]
    [string[]]$Topic,
    [Parameter(Mandatory)]
    [int]$Sentences,
    [Parameter(Mandatory)]
    [string]$Genre
)
if ($Sentences -lt 10)
{
$result = ai "Topic:$($Topic) $($Sentences)-sentence $($Genre) story:" 
return $result    
}
else {
$result = ai "Topic:$($Topic) $($Sentences)-sentences $($Genre) story:" 
return $result
    }
}

Function New-AIChat {
param(
    [Parameter(Mandatory)]
    $Chat
)
$result = ai "The following is a conversation with an AI assistant. The assistant is helpful, creative, clever, and very friendly: $($Chat):" 
return $result
}

Function New-AIStudyNotes {
param(
    [Parameter(Mandatory)]
    [int]$NumberOfPoints,
    [Parameter(Mandatory)]
    $Studying
)
$result = ai "What are $($NumberOfPoints) key points I should know when studying $($Studying)?" 
return $result
}

Function Get-AIanswer {
param(
    [Parameter(Mandatory)]
    $Question
)
$result = ai "I am a highly intelligent question answering bot. If you ask me a question that is rooted in truth, I will give you the answer.`
 If you ask me a question that is nonsense, trickery, or has no clear answer, I will respond with 'Unknown': $($Question)?" 
return $result
}

Function Get-AIGrammarCheck {
param(
    [Parameter(Mandatory)]
    $Text
)
$result = ai "Correct this to standard English:$($Text)" 
return $result
}

Function Get-AIProductAdvert {
param(
    [Parameter(Mandatory)]
    [string]$ProductDescription,
    [Parameter(Mandatory)]
    [string]$Tags
)
$result = ai "Product description:$($ProductDescription)`n Seed Words:$($Tags)" 
return $result
}

Function Get-AIColorCode {
param(
    [Parameter(Mandatory)]
    $DescribeColor
)
$result = ai "The CSS code for a color like $($DescribeColor):" 
return $result
}

Function Get-AIPowershell {
param(
    [Parameter(Mandatory)]
    $Question
)
$result = ai "This is a message-style chatbot that can answer questions about using Powershell. It uses a few examples to get the conversation started. $($Question):" 
return $result
}

Function Get-AIinterviewQuestions {
param(
    [Parameter(Mandatory)]
    [int]$NumberOfQuesitons,
    [Parameter(Mandatory)]
    $Position
)
$result = ai "Create a list of $($NumberOfQuesitons) questions for my interview with a $($Position):" 
return $result
}
