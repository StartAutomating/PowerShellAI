>![](./media/AIReplace.png)

# Unleash the Power of Artificial Intelligence with PowerShell
Welcome to the PowerShell Artificial Intelligence repository! Here, you will find a collection of powerful PowerShell scripts that will enable you to easily integrate AI into your projects and take them to the next level. Imagine being able to interact directly with OpenAI's GPT AI with just a few simple commands. With this module, it's now possible.

## Get Ahead of the Game
By using this module, you'll have the ability to add cutting-edge AI functionality to your projects without needing to have a deep understanding of the underlying technology. This means you can stay focused on what you do best while still being able to work with the latest and greatest.

## Start Your AI Journey Today

### Installation

In the PowerShell console:

```powershell
Install-Module -Name PowerShellAI
```

Get/Create your OpenAI API key from [https://beta.openai.com/account/api-keys](https://beta.openai.com/account/api-keys) and then set `$env:OpenAIKey`.

## Examples
Check out these PowerShell scripts to see how easy it is to get started with AI in PowerShell:

|PS Script | Description | Location
|--|--|--|
| Disable-AIShortCutKey | Disable the <kbd>ctrl+g</kbd> shortcut key go getting completions | [Disable-AIShortCutKey.ps1](./Public/Disable-AIShortCutKey.ps1) |
| Enable-AIShortCutKey | Enable the <kbd>ctrl+g</kbd> | [Enable-AIShortCutKey.ps1](./Public/Enable-AIShortCutKey.ps1) |
| Get-GPT3Completion | Get a completion from the OpenAI GPT-3 API | [Get-GPT3Completion.ps1](./Public/Get-GPT3Completion.ps1)

## In Action

Here is `Get-GPT3Completion` posting your request to the OpenAI GPT-3 API and returning the completion:

![](./media/GPT3Completion.gif)
