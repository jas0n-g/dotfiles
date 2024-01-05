[< Back](../README.md#dotfiles)

# Helix Config

The configurations for [Helix](https://helix-editor.com/), which is my text
editor of choice.

---

## `<<<setup-helix>>>`

```sh macro:setup-helix
setup_helix() {
    rm -rf $HOME/.config/helix
    mkdir -p $HOME/.config/helix
    ln -sf $(realpath $dot_dir/helix/config.toml) $HOME/.config/helix/config.toml
    ln -sf $(realpath $dot_dir/helix/languages.toml) $HOME/.config/helix/languages.toml
}
```

---

## [config.toml](config.toml)

```toml file:config.toml
theme = "base16_transparent"

[editor]
line-number = "relative"
bufferline = "multiple"
cursor-shape.insert = "bar"

<<<keybinds>>>
```

### `<<<keybinds>>>`

```toml macro:keybinds
[keys.normal]
esc = ["collapse_selection", "keep_primary_selection"]
C-c = ["collapse_selection", "keep_primary_selection"]
0 = "goto_line_start"
"$" = "goto_line_end"
G = "goto_file_end"
V = ["select_mode", "extend_to_line_bounds"]
C = [
  "extend_to_line_end",
  "yank_main_selection_to_clipboard",
  "delete_selection",
  "insert_mode",
]
D = [
  "extend_to_line_end",
  "yank_main_selection_to_clipboard",
  "delete_selection",
]
x = "delete_selection"
m = "select_mode"
w = ["move_next_word_start", "collapse_selection"]
b = ["move_prev_word_start", "collapse_selection"]
e = ["move_next_word_end", "collapse_selection"]
W = ["move_next_long_word_start", "collapse_selection"]
B = ["move_prev_long_word_start", "collapse_selection"]
E = ["move_next_long_word_end", "collapse_selection"]

[keys.normal.v]
v = "select_mode"
a = ["select_textobject_around", "select_mode"]
i = ["select_textobject_inner", "select_mode"]
0 = ["select_mode", "goto_line_start"]
"$" = ["select_mode", "goto_line_end"]

[keys.select]
esc = ["normal_mode", "collapse_selection", "keep_primary_selection"]
C-c = ["normal_mode", "collapse_selection", "keep_primary_selection"]
0 = "goto_line_start"
"$" = "goto_line_end"
G = "goto_file_end"
V = "extend_to_line_bounds"
x = "delete_selection"

[keys.insert]
C-c = "normal_mode"
```

---

## [languages.toml](languages.toml)

```toml file:languages.toml
[[language]]
name = "markdown"
formatter = { command = "dprint", args = ["fmt", "--stdin", "md"] }
auto-format = true
```
