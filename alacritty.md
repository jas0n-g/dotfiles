# Alacritty Config

The config for the [Alacritty](https://alacritty.org/) terminal emulator.

[alacritty.toml](alacritty.toml):
```toml
# link to ~/.config/alacritty/alacritty.toml

<<<Colors>>>
<<<Fonts>>>
```

## Fonts

`Fonts`:
```toml
[font]
size = 11.0

[font.normal]
family = "Uiua386Color Nerd Font"
style = "Regular"

[font.bold]
family = "Uiua386Color Nerd Font"
style = "Bold"

[font.bold_italic]
family = "Uiua386Color Nerd Font"
style = "Bold Italic"

[font.italic]
family = "Uiua386Color Nerd Font"
style = "Italic"
```

## Colors

Pulled from [this repo](https://github.com/aarowill/base16-alacritty/blob/master/colors/base16-default-dark-256.toml).

`Colors`:
```toml
[colors.primary]
background = '0x181818'
foreground = '0xd8d8d8'

[colors.cursor]
text = '0x181818'
cursor = '0xd8d8d8'

[colors.normal]
black = '0x181818'
red = '0xab4642'
green = '0xa1b56c'
yellow = '0xf7ca88'
blue = '0x7cafc2'
magenta = '0xba8baf'
cyan = '0x86c1b9'
white = '0xd8d8d8'

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
