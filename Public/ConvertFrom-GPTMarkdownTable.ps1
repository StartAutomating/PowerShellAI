function ConvertFrom-GPTMarkdownTable {
    param(
        $markdown
    )
 
    $lines = $markdown.Trim() -split "`n"

    $(
        foreach ($line in $lines) {
            if ($line -match '[A-Za-z0-9]') {
                $line.Trim() -replace "^\|", ""
            }
        }
    ) | ConvertFrom-Csv -Delimiter '|'
}