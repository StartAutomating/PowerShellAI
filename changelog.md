# v?.?.?

- Added `ai` function:
    - Experimental function enables piping

        ```powershell
        ai "list of planets only names as json"
        ```
    
        ```json
        [
            "Mercury",
            "Venus",
            "Earth",
            "Mars",
            "Jupiter",
            "Saturn",
            "Uranus",
            "Neptune"
        ]
        ```
    
        ```powershell
        ai "list of planets only names as json" |
        ai 'convert to  xml'
        ```

        ```xml
        <?xml version="1.0" encoding="UTF-8"?>
        <Planets>
            <Planet>Mercury</Planet>
            <Planet>Venus</Planet>
            <Planet>Earth</Planet>
            <Planet>Mars</Planet>
            <Planet>Jupiter</Planet>
            <Planet>Saturn</Planet>
            <Planet>Uranus</Planet>
            <Planet>Neptune</Planet>
        </Planets>
        ```        
        
# v0.2.0

- Thank you [Martyn Keigher](https://github.com/MartynKeigher) for your contributions!
    - Added `gpt` as an alias:
    
        ```powershell
        # Get-GPT3Completion "list of planets only names as json"
        gpt "list of planets only names as json"
        ``

    - Added validation for: `temperature`, `max_tokens`, `top_p`, `frequency_penalty`, `presence_penalty`
