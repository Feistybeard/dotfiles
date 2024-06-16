PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# folder to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# if zinit don't exist, download it!
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

# exports
export LANG=en_US.UTF-8
export TERM=xterm-256color
export "MICRO_TRUECOLOR=1"
export EDITOR="nvim"
export NVIM_TUI_ENABLE_TRUE_COLOR=1
export VISUAL="code"
export DOTFILES="$HOME/.dotfiles"
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

autoload -U compinit && compinit

zinit cdreplay -q

# prompt
eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/config.toml)"

# keybinds
bindkey -e
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
zstyle ":fzf-tab:complete:cd:*" fzf-preview "ls --color $realpath"
zstyle ":fzf-tab:complete:__zoxide_z:*" fzf-preview "ls --color $realpath"

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

# alias
alias l="eza -l -g --icons"
alias ll="eza -l -g --icons -a"
alias lg="eza -G --icons"
alias llg="eza -G --icons -a"
alias ls="ls --color"
alias vim="nvim"
alias m="micro"
alias c="clear"
alias cat="bat"
alias g="lazygit"
alias gcb="git_clone_bare $1"
alias f="fd --type f --hidden --exclude .git | fzf | xargs nvim"
alias ..="cd .."
alias alias ..="cd .."
alias alias ...="cd ../.."


# shell integration
eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(mise activate zsh)"
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
