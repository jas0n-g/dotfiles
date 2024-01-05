[< Back](../README.md#dotfiles)

# Zsh Config

My configuration for [Zsh](https://zsh.org), which is my interactive shell of
choice.

---

## `<<<setup-zsh>>>`

```sh macro:setup-zsh
setup_zsh() {
    rm -rf $HOME/.zshenv $HOME/.zshrc
    ln -sf $(realpath $dot_dir/zsh/zshenv) $HOME/.zshenv
    ln -sf $(realpath $dot_dir/zsh/zshrc) $HOME/.zshrc
}
```

---

## [zshenv](zshenv)

Link/copy this file to `~/.zshenv`.

```sh file:zshenv
# .zshenv - sets environment variables for Zsh

[ -f $HOME/.nix-profile/etc/profile.d/nix.sh ] && \
    source $HOME/.nix-profile/etc/profile.d/nix.sh

[ -f $HOME/.cargo/env ] && source $HOME/.cargo/env

[ -d $HOME/.local/bin ] && export PATH=$PATH:$HOME/.local/bin

(command -v nvim >/dev/null) && export EDITOR="$(command -v nvim)"
(command -v hx >/dev/null) && export EDITOR="$(command -v hx)"
```

---

## [zshrc](zshrc)

Link/copy this file to `~/.zshrc`.

```sh file:zshrc
# .zshrc - sets configurations for interactive Zsh

autoload -U colors && colors
PROMPT="%(?.%F{green}%?.%F{red}%?) %F{cyan}%(4~|%-1~/.../%2~|%3~) $reset_color%(!.#.)) "

HISTSIZE=5000
SAVEHIST=5000
HISTFILE=$HOME/.zsh_history

autoload -U compinit
zstyle ":completion:*" menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

<<<aliases>>>

<<<plugins>>>
```

### `<<<aliases>>>`

```sh macro:aliases
# environment variable aliases
alias e="$EDITOR"

# coreutil aliases
alias ls="ls -AXF --color=auto"
alias la="ls -AXF --color=auto"
alias ll="ls -lAXF --color=auto"
alias cp="cp -ri"
alias mv="mv -i"
alias rm="rm -ri"
alias mkdir="mkdir -pv"

# git aliases
alias g="git"
alias gs="git status -sb"
alias gss="git status"
alias ga="git add"
alias gaa="git add -A"
alias gc="git commit"
alias gcm="git commit -m"
alias gacm="git add -A && git commit -m"
alias gp="git push"
```

### `<<<plugins>>>`

```sh macro:plugins
source $HOME/.config/zsh-autosuggestions/zsh-autosuggestions.zsh || \
    echo "zsh-autosuggestions not found, please run \`install_zsh_plugins\` and restart your terminal"
source $HOME/.config/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh || \
    echo "zsh-syntax-highlighting not found, please run \`install_zsh_plugins\` and restart your terminal"
source $HOME/.config/zsh-vi-mode/zsh-vi-mode.plugin.zsh || \
    echo "zsh-vi-mode not found, please run \`install_zsh_plugins\` and restart your terminal"

<<<install-plugins>>>
```

#### `<<<install-plugins>>>`

```sh macro:install-plugins
install_zsh_plugins() {
    if ! (command -v git) >/dev/null; then
        echo "git not found, please install it..."
        return
    fi

    mkdir -p $HOME/.config
    rm -rf $HOME/.config/zsh-autosuggestions
    rm -rf $HOME/.config/zsh-syntax-highlighting
    rm -rf $HOME/.config/zsh-vi-mode

    git clone https://github.com/zsh-users/zsh-autosuggestions.git \
        $HOME/.config/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
        $HOME/.config/zsh-syntax-highlighting
    git clone https://github.com/jeffreytse/zsh-vi-mode.git \
        $HOME/.config/zsh-vi-mode
}
```
