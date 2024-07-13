# link to ~/.config/fish/config.fish

function fish_user_key_bindings
  fish_default_key_bindings -M insert
  fish_vi_key_bindings --no-erase insert
end

if test -f ~/.nix-profile/etc/profile.d/nix.fish
  source ~/.nix-profile/etc/profile.d/nix.fish
end

if test -d ~/.local/bin
  fish_add_path -m ~/.local/bin
end

if type -q nvim
  set -Ux EDITOR nvim
  alias nv="nvim"
else if type -q hx
  set -Ux EDITOR hx
else if type -q helix
  set -Ux EDITOR helix
end

if type -q moar
  set -Ux PAGER moar
else if type -q less
  set -Ux PAGER less
end
alias e="$EDITOR"

alias ls='ls -AF --color=auto'
alias la='ls -AF --color=auto'
alias ll='ls -lAF --color=auto'
alias md='mkdir -pv'
alias cp='cp -ri'
alias rm='rm -ri'
alias rmff='rm -rf'

alias g='git'
alias gs='git status -sb'
alias gss='git status'
alias gc='git commit'
alias gacm='git add -A; git commit -m'
alias gcm='git commit -m'
alias gp='git push'
function fish_prompt
  set -l last_status $status
  set -l stat (set_color green) ' ) ' (set_color normal)
  if test $last_status -ne 0  
    set stat (set_color red) ' ' $last_status ' ) ' (set_color normal)
  end

  string join '' -- (set_color blue) (prompt_pwd --full-length-dirs=2) $stat
end
if type -q zoxide
  zoxide init fish | source
end

if type -q direnv
  direnv hook fish | source
  set -g direnv_fish_mode disable_arrow
end

if type -q fzf
  fzf --fish | source
  set -l color00 '#181818'
  set -l color01 '#282828'
  set -l color02 '#383838'
  set -l color03 '#585858'
  set -l color04 '#b8b8b8'
  set -l color05 '#d8d8d8'
  set -l color06 '#e8e8e8'
  set -l color07 '#f8f8f8'
  set -l color08 '#ab4642'
  set -l color09 '#dc9656'
  set -l color0A '#f7ca88'
  set -l color0B '#a1b56c'
  set -l color0C '#86c1b9'
  set -l color0D '#7cafc2'
  set -l color0E '#ba8baf'
  set -l color0F '#a16946'
  
  set -l FZF_NON_COLOR_OPTS
  
  for arg in (echo $FZF_DEFAULT_OPTS | tr " " "\n")
      if not string match -q -- "--color*" $arg
          set -a FZF_NON_COLOR_OPTS $arg
      end
  end
  
  set -Ux FZF_DEFAULT_OPTS "$FZF_NON_COLOR_OPTS"\
  " --color=bg+:$color01,bg:$color00,spinner:$color0C,hl:$color0D"\
  " --color=fg:$color04,header:$color0D,info:$color0A,pointer:$color0C"\
  " --color=marker:$color0C,fg+:$color06,prompt:$color0A,hl+:$color0D"
end
