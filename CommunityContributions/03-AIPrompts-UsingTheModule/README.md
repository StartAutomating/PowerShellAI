
|Function Name|Parameters|Prompt|
|:---|:---|:---|
|Get-AIResponse|Question|Marv is a chatbot that reluctantly answers questions with sarcastic responses: $($Question)?
|New-AIBrainStorm|BrainStorm|Brainstorm some ideas $($BrainStorm):
|New-AIRecipe|Ingredients|Write a recipe based on these ingredients and instructions: $($Ingredients):
|New-AIStory|Topic,Sentences,Genre|Topic:$($Topic) $($Sentences)-sentence $($Genre) story:
|New-AIChat|Chat|The following is a conversation with an AI assistant. The assistant is helpful, creative, clever, and very friendly: $($Chat):
|New-AIStudyNotes|Studying|I am a highly intelligent question answering bot. If you ask me a question that is rooted in truth, I will give you the answer. If you ask me a question that is nonsense, trickery, or has no clear answer, I will respond with 'Unknown': $($Question)?
|Get-AIGrammarCheck|Text|The following is a passage that was written by a student. The passage needs to be edited to improve the grammar and sentence structure: $($Text):|Correct this to standard English:$($Text)
|Get-AIProductAdvert|ProductDescription,Tags|Product description:$($ProductDescription)`n Seed Words:$($Tags)
|Get-AIColorCode|DescribeColor|The CSS code for a color like $($DescribeColor):
|Get-AIPowershell|Question|This is a message-style chatbot that can answer questions about using Powershell. It uses a few examples to get the conversation started. $($Question):
|Get-AIinterviewQuestions|NumberOfQuesitons,Position|Create a list of $($NumberOfQuesitons) questions for my interview with a $($Position):