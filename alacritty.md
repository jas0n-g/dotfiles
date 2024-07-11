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

`Colors`:
```toml
[colors.primary]
background = "#000000"
foreground = "#FFFFFF"

[colors.cursor]
text   = "#000000"
cursor = "#FFFFFF"

[colors.normal]
black   = "#000000"
red     = "#B22222"
green   = "#2E8B57"
yellow  = "#DAA520"
blue    = "#4169E1"
magenta = "#8B008B"
cyan    = "#008B8B"
white   = "#BEBEBE"

[colors.bright]
black   = "#696969"
red     = "#FF0000"
green   = "#00FF00"
yellow  = "#FFFF00"
blue    = "#6495ED"
magenta = "#9932CC"
cyan    = "#00BFFF"
white   = "#FFFFFF"
```
