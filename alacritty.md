# Alacritty Config

The config for the [Alacritty](https://alacritty.org/) terminal emulator.

[alacritty.toml](alacritty.toml):
```toml
# link / copy and edit to ~/.config/alacritty/alacritty.toml

shell = "/usr/local/bin/fish" # change to your shell's path
live_config_reload = true

[window]
opacity = 0.75
blur = true

<<<Font>>>
<<<Colors>>>
```

## Font

`Font`:
```toml
[font]
size = 16.0

[font.bold]
family = "Uiua386Color Nerd Font"
style = "Bold"

[font.bold_italic]
family = "Uiua386Color Nerd Font"
style = "Bold Italic"

[font.italic]
family = "Uiua386Color Nerd Font"
style = "Italic"

[font.normal]
family = "Uiua386Color Nerd Font"
style = "Regular"
```

## Colors

Taken from [here](https://github.com/aarowill/base16-alacritty/blob/master/colors/base16-default-dark-256.toml).

`Colors`:
```toml
# Base16 Default Dark 256 - alacritty color config
# Chris Kempson (http://chriskempson.com)

# Default colors
[colors.primary]
background = '0x181818'
foreground = '0xd8d8d8'

# Colors the cursor will use if `custom_cursor_colors` is true
[colors.cursor]
text = '0x181818'
cursor = '0xd8d8d8'

# Normal colors
[colors.normal]
black = '0x181818'
red = '0xab4642'
green = '0xa1b56c'
yellow = '0xf7ca88'
blue = '0x7cafc2'
magenta = '0xba8baf'
cyan = '0x86c1b9'
white = '0xd8d8d8'

# Bright colors
[colors.bright]
black = '0x585858'
red = '0xab4642'
green = '0xa1b56c'
yellow = '0xf7ca88'
blue = '0x7cafc2'
magenta = '0xba8baf'
cyan = '0x86c1b9'
white = '0xf8f8f8'

[[colors.indexed_colors]]
index = 16
color = "0xdc9656"

[[colors.indexed_colors]]
index = 17
color = "0xa16946"

[[colors.indexed_colors]]
index = 18
color = "0x282828"

[[colors.indexed_colors]]
index = 19
color = "0x383838"

[[colors.indexed_colors]]
index = 20
color = "0xb8b8b8"

[[colors.indexed_colors]]
index = 21
color = "0xe8e8e8"
```
