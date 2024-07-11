# Helix Config

The config for the [Helix](https://helix-editor.com/) editor. The emacs keybinds are pulled from [this Reddit post](https://www.reddit.com/r/HelixEditor/comments/13799mv/comment/jitw5uy/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button).

[helix.toml](helix.toml):
```toml
# link to ~/.config/helix/config.toml

theme = "rockesheller-dark"

[editor.soft-wrap]
enable = true

[editor.statusline]
left = ["mode", "spinner", "diagnostics", "version-control"]
center = ["file-name"]
right = ["position", "position-percentage", "file-type"]

# emacs keybinds
[keys.insert]
C-p = "move_line_up"
C-n = "move_line_down"
C-e = "goto_line_end_newline"
C-a = "goto_line_start"
C-f = "move_char_right"
C-b = "move_char_left"
```

## Colors

[rockesheller-dark.toml](rockesheller-dark.toml):
```toml
"attribute" = { fg = "#F0E68C" }
"comment" = { fg = "#808080 ", modifiers = ["italic"] }
"constant" = { fg = "#DAA520" }
"constant.numeric" = { fg = "#DAA520" }
"constant.builtin" = { fg = "#DAA520" }
"constant.character.escape" = { fg = "#DAA520" }
"constructor" = { fg = "#6495ED" }
"function" = { fg = "#FFFFFF" }
"function.builtin" = { fg = "#6495ED" }
"function.macro" = { fg = "#8A2BE2" }
"keyword" = { fg = "#8A2BE2" }
"keyword.control" = { fg = "#8A2BE2" }
"keyword.control.import" = { fg = "#8A2BE2" }
"keyword.directive" = { fg = "#8A2BE2" }
"label" = { fg = "#8A2BE2" }
"namespace" = { fg = "#8A2BE2" }
"operator" = { fg = "#FFFFFF" }
"keyword.operator" = { fg = "#FFFFFF" }
"special" = { fg = "#6495ED" }
"string" = { fg = "#2E8B57" }
"type" = { fg = "#DAA520" }
"variable" = { fg = "#FFFFFF" }
"variable.builtin" = { fg = "#B22222" }
"variable.parameter" = { fg = "#B22222" }
"variable.other.member" = { fg = "#6495ED" }
"markup.heading.1" = { fg = "#9932CC" }
"markup.heading.2" = { fg = "#4169E1" }
"markup.heading.3" = { fg = "#2E8B57" }
"markup.heading.4" = { fg = "#FFD700" }
"markup.heading.5" = { fg = "#B8860B" }
"markup.heading.6" = { fg = "#B22222" }
"markup.raw.inline" = { fg = "#2E8B57" }
"markup.raw.block" = { fg = "#FFFFFF" }
"markup.bold" = { fg = "#DAA520", modifiers = ["bold"] }
"markup.italic" = { fg = "#8A2BE2", modifiers = ["italic"] }
"markup.strikethrough" = { modifiers = ["crossed_out"] }
"markup.list" = { fg = "#B22222" }
"markup.quote" = { fg = "#DAA520" }
"markup.link.url" = { fg = "#6495ED", modifiers = ["underlined"]}
"markup.link.text" = { fg = "#FFFFFF" }
"markup.link.label" = { fg = "#FFFFFF" }
"diff.plus" = "#2E8B57"
"diff.delta" = "#DAA520"
"diff.minus" = "#B22222"
"diagnostic.info".underline = { color = "#6495ED", style = "curl" } 
"diagnostic.hint".underline = { color = "#2E8B57", style = "curl" } 
"diagnostic.warning".underline = { color = "#DAA520", style = "curl" } 
"diagnostic.error".underline = { color = "#B22222", style = "curl" } 
"diagnostic.unnecessary" = { modifiers = ["dim"] }
"diagnostic.deprecated" = { modifiers = ["crossed_out"] }
"info" = { fg = "#6495ED", modifiers = ["bold"] }
"hint" = { fg = "#2E8B57", modifiers = ["bold"] }
"warning" = { fg = "#DAA520", modifiers = ["bold"] }
"error" = { fg = "#B22222", modifiers = ["bold"] }
"ui.background" = { bg = "#000000" }
"ui.virtual" = { fg = "#A9A9A9" }
"ui.virtual.indent-guide" = { fg = "#A9A9A9" }
"ui.virtual.whitespace" = { fg = "#A9A9A9" }
"ui.virtual.ruler" = { bg = "#A9A9A9" }
"ui.virtual.inlay-hint" = { fg = "#A9A9A9" }
"ui.cursor" = { fg = "#FFFFFF", modifiers = ["reversed"] }
"ui.cursor.primary" = { fg = "#FFFFFF", modifiers = ["reversed"] }
"ui.cursor.match" = { fg = "#6495ED", modifiers = ["underlined"]}
"ui.selection" = { fg = "#000000", bg = "#6495ED" }
"ui.selection.primary" = { fg = "#000000", bg = "#6495ED" }
"ui.cursorline.primary" = { bg = "#A9A9A9 " }
"ui.linenr" = { fg = "#F0E68C" }
"ui.linenr.selected" = { fg = "#F0E68C" }
"ui.statusline" = { fg = "#000000", bg = "#6495ED" }
"ui.statusline.inactive" = { fg = "#FFFFFF", bg = "#FFFFFF" }
"ui.statusline.normal" = { fg = "#000000", bg = "#6495ED" }
"ui.statusline.insert" = { fg = "#000000", bg = "#6495ED" }
"ui.statusline.select" = { fg = "#000000", bg = "#6495ED" }
"ui.bufferline" = { fg = "#FFFFFF", bg = "#000000" }
"ui.bufferline.active" = { fg = "#000000", bg = "#6495ED", underline = { color = "#000000", style = "line" } }
"ui.bufferline.background" = { bg = "#000000" }
"ui.text" = { fg = "#FFFFFF" }
"ui.text.focus" = { fg = "#000000", bg = "#6495ED", modifiers = ["bold"] }
"ui.help" = { fg = "#FFFFFF", bg = "#000000" }
"ui.debug" = { fg = "#B22222" }
"ui.highlight.frameline" = { bg = "#97202a" }
"ui.popup" = { bg = "#000000" }
"ui.window" = { fg = "#FFFFFF" }
"ui.menu" = { fg = "#FFFFFF", bg = "#000000" }
"ui.menu.selected" = { fg = "#000000", bg = "#6495ED" }
"ui.menu.scroll" = { fg = "#FFFFFF", bg = "#000000" }
```