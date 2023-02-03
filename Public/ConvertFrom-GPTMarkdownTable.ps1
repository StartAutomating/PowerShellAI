function ConvertFrom-GPTMarkdownTable {
    param(
        $markdown
    )
 
    $lines = $markdown -split "`n"

    $(
        foreach ($line in $lines) {
            if ($line -match '[A-Za-z0-9]') {
                $line -replace "^\|", ""
            }
        }
    ) | ConvertFrom-Csv -Delimiter '|'
}