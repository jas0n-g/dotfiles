[< Back](../README.md#dotfiles)

# Wezterm Config

The configurations for [Wezterm](https://wezfurlong.org/wezterm/), which is
my terminal / multiplexer of choice.

---

## `<<<setup-wezterm>>>`

```sh macro:setup-wezterm
setup_wezterm() {
    rm -rf $HOME/.config/wezterm
    mkdir -p $HOME/.config/wezterm
    ln -sf $(realpath $dot_dir/wezterm/wezterm.lua) $HOME/.config/wezterm/wezterm.lua
}
```

---

## [wezterm.lua](wezterm.lua)

```lua file:wezterm.lua
local wezterm = require("wezterm")

local config = {}

<<<appearance>>>
<<<keybinds>>>

return config
```

### `<<<appearance>>>`

```lua macro:appearance
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true

config.color_scheme = "Dark+"
config.colors = {
  tab_bar = {
    background = "#1e1e1e",
    active_tab = {
      bg_color = "#1e1e1e",
      fg_color = "#d4d4d4",
    },
    inactive_tab = {
      bg_color = "#282828",
      fg_color = "#d4d4d4",
    },
    inactive_tab_hover = {
      bg_color = "#264f78",
      fg_color = "#d4d4d4",
    },
    new_tab = {
      bg_color = "#282828",
      fg_color = "#d4d4d4",
    },
    new_tab_hover = {
      bg_color = "#264f78",
      fg_color = "#d4d4d4",
    },
  }
}


```

### `<<<keybinds>>>`

```lua macro:keybinds
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 500 }
config.keys = {
  {
    key = "a",
    mods = "LEADER|CTRL",
    action = wezterm.action.SendKey { key = "a", mods = "CTRL" },
  },
  {
    key = ":",
    mods = "LEADER|SHIFT",
    action = wezterm.action.ActivateCommandPalette,
  },
  {
    key = "F",
    mods = "LEADER|SHIFT",
    action = wezterm.action.ToggleFullScreen,
  },

  {
    key = "\\",
    mods = "LEADER",
    action = wezterm.action.SplitHorizontal,
  },
  {
    key = "-",
    mods = "LEADER",
    action = wezterm.action.SplitVertical,
  },
  {
    key = "c",
    mods = "LEADER",
    action = wezterm.action.SpawnTab "CurrentPaneDomain",
  },
  {
    key = "|",
    mods = "LEADER|SHIFT",
    action = wezterm.action.SplitHorizontal { cwd = wezterm.home_dir },
  },
  {
    key = "_",
    mods = "LEADER|SHIFT",
    action = wezterm.action.SplitVertical { cwd = wezterm.home_dir },
  },
  {
    key = "C",
    mods = "LEADER|SHIFT",
    action = wezterm.action.SpawnCommandInNewTab { cwd = wezterm.home_dir },
  },

  {
    key = "n",
    mods = "LEADER",
    action = wezterm.action.ActivateTabRelative(1),
  },
  {
    key = "p",
    mods = "LEADER",
    action = wezterm.action.ActivateTabRelative(-1),
  },
  {
    key = "N",
    mods = "LEADER|SHIFT",
    action = wezterm.action.MoveTabRelative(1),
  },
  {
    key = "P",
    mods = "LEADER|SHIFT",
    action = wezterm.action.MoveTabRelative(-1),
  },

  {
    key = "h",
    mods = "LEADER",
    action = wezterm.action.ActivatePaneDirection "Left",
  },
  {
    key = "j",
    mods = "LEADER",
    action = wezterm.action.ActivatePaneDirection "Down",
  },
  {
    key = "k",
    mods = "LEADER",
    action = wezterm.action.ActivatePaneDirection "Up",
  },
  {
    key = "l",
    mods = "LEADER",
    action = wezterm.action.ActivatePaneDirection "Right",
  },

  {
    key = "h",
    mods = "LEADER|ALT",
    action = wezterm.action.AdjustPaneSize { "Left", 2 },
  },
  {
    key = "j",
    mods = "LEADER|ALT",
    action = wezterm.action.AdjustPaneSize { "Down", 2 },
  },
  {
    key = "k",
    mods = "LEADER|ALT",
    action = wezterm.action.AdjustPaneSize { "Up", 2 },
  },
  {
    key = "l",
    mods = "LEADER|ALT",
    action = wezterm.action.AdjustPaneSize { "Right", 2 },
  },

  {
    key = "s",
    mods = "LEADER",
    action = wezterm.action.PaneSelect,
  },
  {
    key = "S",
    mods = "LEADER|SHIFT",
    action = wezterm.action.PaneSelect { mode = "SwapWithActive" },
  },

  {
    key = "q",
    mods = "LEADER",
    action = wezterm.action.CloseCurrentPane { confirm = true },
  },
  {
    key = "Q",
    mods = "LEADER|SHIFT",
    action = wezterm.action.CloseCurrentTab { confirm = true },
  },
}
```
