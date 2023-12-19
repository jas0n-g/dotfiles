[< Back](../README.md#dotfiles)

# tmux Config

My configs for [tmux](https://github.com/tmux/tmux), which is my terminal
multiplexer of choice.

---

## `<<<setup-tmux>>>`

```sh macro:setup-tmux
setup_tmux() {
    rm -rf $HOME/.tmux.conf $HOME/.config/tmux
    mkdir -p $HOME/.config/tmux
    ln -sf $(realpath $dot_dir/tmux/tmux.conf) $HOME/.config/tmux/tmux.conf
}
```

---

## [tmux.conf](tmux.conf)

Link/copy this file to `$HOME/.config/tmux/tmux.conf`.

```tmux file:tmux.conf
set -g default-terminal "tmux-256color"
set -g mouse on
set -g escape-time 0
set -g mode-keys vi

<<<binds>>>

<<<appearance>>>
```

### `<<<binds>>>`

Some more sane keybinds.

```tmux macro:binds
unbind c
unbind S-c
bind c new-window -c "#{pane_current_path}"
bind S-c new-window

bind \\ split-window -h -c "#{pane_current_path}"
bind | split-window -h
bind - split-window -v -c "#{pane_current_path}"
bind _ split-window -v

bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R

bind > swap-pane -D
bind < swap-pane -U
```

### `<<<appearance>>>`

Make tmux pretty.

```tmux macro:appearance
set -g base-index 1
set -g pane-base-index 1

set -g automatic-rename on
set -g renumber-windows on

set -g status on
set -g status-position top

set -g status-style bg=black,fg=white

set -g window-status-format "#[bg=black,fg=white] #I "
set -g window-status-current-format "#[bg=white,fg=black] #I "
set -g status-left ""
set -g status-right "#[bg=white,fg=black] Session: #S "

set -g pane-border-style fg=black
set -g pane-active-border-style fg=white
```
