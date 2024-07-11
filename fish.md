# Fish Config

The config for the [Fish](https://fishshell.com/) shell.

[config.fish](config.fish):
```fish
# link to ~/.config/fish/config.fish

function fish_user_key_bindings
  fish_default_key_bindings -M insert
  fish_vi_key_bindings --no-erase insert
end

<<<Env Vars>>>
<<<Aliases>>>
<<<Prompt>>>
<<<Plugins>>>
```

## Environment Variables

I need Nix.

`Env Vars`:
```fish
if test -f ~/.nix-profile/etc/profile.d/nix.fish
  source ~/.nix-profile/etc/profile.d/nix.fish
end

if type -q hx
  set -Ux EDITOR hx
else if type -q helix
  set -Ux EDITOR helix
end

if type -q moar
  set -Ux PAGER moar
else if type -q less
  set -Ux PAGER less
end
```

## Aliases

Make me sane.

`Aliases`:
```fish
alias ls='ls -AF --color=auto'
alias la='ls -AF --color=auto'
alias ll='ls -lAF --color=auto'
alias md='mkdir -pv'
alias cp='cp -ri'
alias rm='rm -ri'
alias rmff='rm -rf'
```

## Prompt

I want something stupid simple.

`Prompt`:
```fish
function fish_prompt
  set -l last_status $status
  set -l stat (set_color green) ' ) ' (set_color normal)
  if test $last_status -ne 0  
    set stat (set_color red) ' ' $last_status ' ) ' (set_color normal)
  end

  string join '' -- (set_color blue) (prompt_pwd --full-length-dirs 2) $stat
end
```

## Plugins

Sets up:
- [Zoxide](https://github.com/ajeetdsouza/zoxide)
- [Direnv](https://direnv.net/)

`Plugins`:
```fish
if type -q zoxide
  zoxide init fish | source
end

if type -q direnv
  direnv hook fish | source
  set -g direnv_fish_mode disable_arrow
end
```