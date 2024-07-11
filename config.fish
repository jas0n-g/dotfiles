# link to ~/.config/fish/config.fish

function fish_user_key_bindings
  fish_default_key_bindings -M insert
  fish_vi_key_bindings --no-erase insert
end

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
alias ls='ls -AF --color=auto'
alias la='ls -AF --color=auto'
alias ll='ls -lAF --color=auto'
alias md='mkdir -pv'
alias cp='cp -ri'
alias rm='rm -ri'
alias rmff='rm -rf'
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
  set -Ux FZF_DEFAULT_OPTS '--color=fg:#ffffff,bg:#000000,hl:#4169e1 --color=fg+:#ffffff,bg+:#000000,hl+:#6495ed --color=info:#f0e68c,prompt:#b22222,pointer:#9932cc --color=marker:#2e8b57,spinner:#9932cc,header:#20B2AA'
end
