[< Back](README.md#dotfiles)

# [setup.sh](setup.sh)

Tangles all `.md` files, makes all `.sh` files executable, then links all of
my config files.

```sh file:setup.sh
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

<<<zsh/README.md:setup-zsh>>>
<<<tmux/README.md:setup-tmux>>>

for input in $@; do
    case "$input" in
        "zsh") setup_zsh ;;
        "tmux") setup_tmux ;;
    esac
done
```
