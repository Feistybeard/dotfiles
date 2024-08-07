# path exports
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
additional_paths=(
  "$HOME/.cargo/bin"
)
for dir in "${additional_paths[@]}"; do
  if [[ -d $dir ]]; then
    export PATH="$PATH:$dir"
  fi
done
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_PICTURES_DIR="$HOME/Pictures"
export XDG_STATE_HOME="$HOME/.local/state"

# folder to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# if zinit don't exist, download it!
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

eval "$(mise activate zsh)"
eval "$(atuin init zsh)"
eval "$(zoxide init --cmd cd zsh)"

# exports
export MANPAGER='nvim +Man!'
export OBSIDIAN_NOTES="$HOME/Documents/Notes"
export LANG=en_US.UTF-8
export TERM=xterm-256color
export "MICRO_TRUECOLOR=1"
export EDITOR="nvim"
export NVIM_TUI_ENABLE_TRUE_COLOR=1
export VISUAL="zeditor"
export DOTFILES="$HOME/.dotfiles"
export ZELLIJ_RUNNER_ROOT_DIR="Dev"
export ZELLIJ_RUNNER_IGNORE_DIRS="node_modules,target"
export ZELLIJ_RUNNER_MAX_DIRS_DEPTH="3"
export ZELLIJ_RUNNER_LAYOUTS_DIR=".config/zellij/layouts"
export ZELLIJ_RUNNER_BANNERS_DIR=".config/zellij/banners"
export HOMEBREW_NO_ANALYTICS=1
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --color=fg:-1,fg+:#33c31f,bg:-1,bg+:#070707
  --color=hl:#63995a,hl+:#33c31f,info:#424242,marker:#af5fff
  --color=prompt:#ffffff,spinner:#af5fff,pointer:#5eff6c,header:#87afaf
  --color=border:#262626,label:#aeaeae,query:#d9d9d9
  --border="rounded" --border-label="" --preview-window="border-rounded" --prompt="> "
  --marker=">" --pointer="◆" --separator="─" --scrollbar="│"
  --height=60% '
if [[ $FIND_IT_FASTER_ACTIVE -eq 1 ]]; then
  FZF_DEFAULT_OPTS='--height=100%'
fi
FREETYPE_PROPERTIES="cff:no-stem-darkening=0 autofitter:no-stem-darkening=0"

# plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found
zinit snippet OMZP::docker-compose
zinit snippet OMZP::alias-finder

autoload -U compinit && compinit

zinit cdreplay -q

eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/config.toml)"

# keybinds
bindkey -e #set to emacs mode
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# history
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# completion styling
zstyle ":completion:*" matcher-list "m:{a-z}={A-Za-z}"
zstyle ":completion:*" list-colors "${(s.:.)LS_COLORS}"
zstyle ":completion:*" menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
zstyle ':omz:plugins:alias-finder' autoload yes # disabled by default

# functions
fdir() {
  local dir
  cd $HOME
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}
update_git_origin() {
  git config remote.origin.fetch '+refs/heads/*:refs/remotes/origin/*'
  git fetch
  git for-each-ref --format='%(refname:short)' refs/heads | xargs -n1 -I{} git branch --set-upstream-to=origin/{}
}
git_clone_bare() {
  git clone --bare $1 .bare
  echo "gitdir: ./.bare" > .git
  update_git_origin
}
zellij_attach_or_create() {
    local session_name=${1:-default}
    zellij attach --create $session_name
}
# tm [SESSION_NAME | FUZZY PATTERN] - create new tmux session, or switch to existing one.
# Running `tm` will let you fuzzy-find a session mame
# Passing an argument to `ftm` will switch to that session if it exists or create it otherwise
ftm() {
  [[ -n "$TMUX" ]] && change="switch-client" || change="attach-session"
  if [ $1 ]; then
    tmux $change -t "$1" 2>/dev/null || (tmux new-session -d -s $1 && tmux $change -t "$1"); return
  fi
  session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --exit-0) &&  tmux $change -t "$session" || echo "No sessions found."
}
# tmk [SESSION_NAME | FUZZY PATTERN] - delete tmux session
# Running `tmk` will let you fuzzy-find a session mame to delete
# Passing an argument to `ftmk` will delete that session if it exists
ftmk() {
  if [ $1 ]; then
    tmux kill-session -t "$1"; return
  fi
  session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --height 40% --reverse --border-label ' Kill Tmux Session ' --border --prompt '⚡  ') &&  tmux kill-session -t "$session" || echo "No session found to delete."
}
sesh-sessions() {
  {
    exec </dev/tty
    exec <&1
    local session
    session=$(sesh list | fzf --height 40% --reverse --border-label ' Attach/Create Tmux Session ' --border --prompt '⚡  ')
    [[ -z "$session" ]] && return
    sesh connect $session
  }
}

# alias
alias l="eza -l -g --icons"
alias ll="eza -l -g --icons -a"
alias lg="eza -G --icons"
alias llg="eza -G --icons -a"
alias ls="ls --color"
alias vim="nvim"
alias v="vim"
alias m="micro"
alias c="clear"
alias cat="bat"
alias g="lazygit"
alias gcb="git_clone_bare $1"
alias f="fd --type f --hidden --exclude .git | fzf | xargs nvim"
alias ..="cd .."
alias ...="cd ../.."
alias rmf="rm -rf"
alias z="zellij_attach_or_create"
alias zz="zellij-runner"
alias :q="exit"
alias oo='cd $OBSIDIAN_NOTES'
alias of='fuz -p $OBSIDIAN_NOTES'
alias or='vim $OBSIDIAN_NOTES/inbox/*.md'
alias zed='zeditor'
alias t="sesh-sessions"
alias tk="ftmk"
alias td="tmux detach"
alias du="du -h"
alias dus="du -hs *"
alias tl="tail -f"

# shell integration
# eval correct Homebrew path
[[ "$OSTYPE" == "darwin"* ]] && eval "$(/opt/homebrew/bin/brew shellenv)"
[[ "$OSTYPE" == "linux-gnu"* ]] && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# bun completions
[ -s "/home/marvan/.bun/_bun" ] && source "/home/marvan/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# keychain
eval $(keychain --eval --quiet id_ed25519 id_rsa)
