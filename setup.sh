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

for input in $@; do
    case "$input" in
        "zsh") setup_zsh ;;
        "tmux") setup_tmux ;;
    esac
done
