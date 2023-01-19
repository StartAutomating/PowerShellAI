# The default formatter just prints the answer
Write-FormatView -TypeName GPT-3.Result -Action {
    Write-FormatViewExpression -Property Answer
}

# The view QuestionAnswer prints both the question and the answer
Write-FormatView -TypeName GPT-3.Result -Action {
    Write-FormatViewExpression -Text "You Asked:" -ForegroundColor Warning
    Write-FormatViewExpression -Newline 
    Write-FormatViewExpression -Newline    
    Write-FormatViewExpression -Property Question
    Write-FormatViewExpression -Newline
    Write-FormatViewExpression -Newline
    Write-FormatViewExpression -Text "It Answered:" -ForegroundColor Verbose
    Write-FormatViewExpression -Newline
    Write-FormatViewExpression -Newline
    Write-FormatViewExpression -Property Answer
    Write-FormatViewExpression -Newline
    Write-FormatViewExpression -Newline
} -Name 'QuestionAnswer'

# The view 'QuestionAnswerTime' shows the question, answer, and times.
Write-FormatView -TypeName GPT-3.Result -Action {
    Write-FormatViewExpression -ScriptBlock { "@ $($_.QuestionTimeStamp), You Asked:" }  -ForegroundColor Warning    
    Write-FormatViewExpression -Newline 
    Write-FormatViewExpression -Newline    
    Write-FormatViewExpression -Property Question
    Write-FormatViewExpression -Newline
    Write-FormatViewExpression -Newline
    Write-FormatViewExpression -ScriptBlock { "@ $($_.AnswerTimeStamp), It Answered:" } -ForegroundColor Verbose
    Write-FormatViewExpression -Newline
    Write-FormatViewExpression -Newline
    Write-FormatViewExpression -Property Answer
    Write-FormatViewExpression -Newline
    Write-FormatViewExpression -Newline
} -Name 'QuestionAnswerTime'

# Make a table view that shows question and answer
Write-FormatView -TypeName 'GPT-3.Result' -Property Question, Answer -Width 20 -Wrap

# And make a list view for good measure.
Write-FormatView -TypeName 'GPT-3.Result' -Property Question, QuestionTime, Answer, AnswerTime, AnswerTook -AsList
