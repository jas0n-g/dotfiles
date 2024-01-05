#!/bin/sh

dot_dir=$(realpath $(dirname $0))
echo "dotfiles directory: $dot_dir"
cd $dot_dir

if (command -v find >/dev/null); then
    if (command -v nail >/dev/null); then
        for md_file in $(find $dot_dir -name "*.md"); do
            echo "tangling $md_file..."
            nail -y $md_file
        done
    fi

    for sh_file in $(find $dot_dir -name "*.sh"); do
        echo "making $sh_file executable..."
        chmod +x $sh_file
    done
fi

setup_zsh() {
    rm -rf $HOME/.zshenv $HOME/.zshrc
    ln -sf $(realpath $dot_dir/zsh/zshenv) $HOME/.zshenv
    ln -sf $(realpath $dot_dir/zsh/zshrc) $HOME/.zshrc
}
setup_tmux() {
    rm -rf $HOME/.tmux.conf $HOME/.config/tmux
    mkdir -p $HOME/.config/tmux
    ln -sf $(realpath $dot_dir/tmux/tmux.conf) $HOME/.config/tmux/tmux.conf
}
setup_neovim() {
    rm -rf $HOME/.config/nvim
    mkdir -p $HOME/.config/nvim
    ln -sf $(realpath $dot_dir/neovim/init.lua) $HOME/.config/nvim/init.lua
}
setup_helix() {
    rm -rf $HOME/.config/helix
    mkdir -p $HOME/.config/helix/themes
    ln -sf $(realpath $dot_dir/helix/config.toml) $HOME/.config/helix/config.toml
    ln -sf $(realpath $dot_dir/helix/languages.toml) $HOME/.config/helix/languages.toml
    ln -sf $(realpath $dot_dir/helix/dark_plus_transparent.toml) $HOME/.config/helix/themes/dark_plus_transparent.toml
}
setup_wezterm() {
    rm -rf $HOME/.config/wezterm
    mkdir -p $HOME/.config/wezterm
    ln -sf $(realpath $dot_dir/wezterm/wezterm.lua) $HOME/.config/wezterm/wezterm.lua
}

for input in $@; do
    case "$input" in
        "zsh") setup_zsh ;;
        "tmux") setup_tmux ;;
        "nvim"|"neovim") setup_neovim ;;
        "hx"|"helix") setup_helix ;;
        "wezterm") setup_wezterm ;;
    esac
done
