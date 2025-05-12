# ╭──────────────────────────────────────────────────────────╮
# │ Enable Powerlevel10k instant prompt. Should stay close   │
# │ to the top of ~/.zshrc.                                  │
# │ Initialization code that may require console input       │
# │ (password prompts, [y/n]                                 │
# │ confirmations, etc.) must go above this block;           │
# │ everything else may go below.                            │
# ╰──────────────────────────────────────────────────────────╯
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ── Path exports ──────────────────────────────────────────────────────
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_PICTURES_DIR="$HOME/Pictures"
export XDG_STATE_HOME="$HOME/.local/state"
export DOTFILES="$HOME/.dotfiles"
export OBSIDIAN_NOTES="$HOME/Documents/Notes"
export MANPAGER='nvim +Man!'
export NVIM_TUI_ENABLE_TRUE_COLOR=1
export MICRO_TRUECOLOR=1
export HOMEBREW_NO_ANALYTICS=1
export LANG=en_US.UTF-8
export TERM=xterm-256color
export EDITOR="nvim"
export VISUAL="zeditor"
paths=(
  "$HOME/.cargo/bin"
  "$HOME/.local/bin"
  "/usr/local/bin"
  "$HOME/bin"
)
for dir in "${paths[@]}"; do
  if [[ -d $dir ]]; then
    export PATH="$PATH:$dir"
  fi
done

# ── Fzf settings ──────────────────────────────────────────────────────
export FZF_DEFAULT_COMMAND='find . -type f ! -path "*git*"'
export FZF_DEFAULT_COMMAND='fd . --hidden --exclude ".git"'
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --color=fg:-1,fg+:#33c31f,bg:-1,bg+:#070707
  --color=hl:#63995a,hl+:#33c31f,info:#424242,marker:#af5fff
  --color=prompt:#ffffff,spinner:#af5fff,pointer:#5eff6c,header:#87afaf
  --color=border:#262626,label:#aeaeae,query:#d9d9d9
  --border="rounded" --border-label="" --preview-window="border-rounded" --prompt="> "
  --marker=">" --pointer="◆" --separator="─" --scrollbar="│"
  --height=60% --reverse '

# Homebrew on mac
if [[ "$(uname)" == "Darwin" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
    export DOTNET_ROOT="/opt/homebrew/opt/dotnet/libexec"
fi

# ── Plugins ───────────────────────────────────────────────────────────
# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::node
zinit snippet OMZP::command-not-found

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q # replay all cached completions (recommended by docs)

# Completion styling
zstyle ":completion:*" matcher-list "m:{a-z}={A-Za-z}" # non case sensitive matching
zstyle ":completion:*" list-colors "${(s.:.)LS_COLORS}"
zstyle ":completion:*" menu no
zstyle ":fzf-tab:complete:cd:*" fzf-preview "ls --color $realpath"
zstyle ":fzf-tab:complete:__zoxide_z:*" fzf-preview "ls --color $realpath"

# ── Keybinds ──────────────────────────────────────────────────────────
bindkey -e # enable emacs mode
bindkey '^p' history-search-backward
bindkey '^n' zistory-search-forward

# ── History ───────────────────────────────────────────────────────────
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# ── Alias ─────────────────────────────────────────────────────────────
alias ls="ls --color"
alias l="ls -l"
alias ll="ls -la"
alias vim="nvim"
alias v="vim"
alias c="clear"
alias q="exit"
alias cat="bat"
alias g="lazygit"
alias gcb="git_clone_bare $1"
alias ff="find-file" # fuzzy find file and edit in editor
alias fo="fzf_listoldfiles" # fuzzy find recent files
alias cdd="fdir" # fuzzy find and change into dir
alias ..="cd .."
alias ...="cd ../.."
alias rmf="rm -rf"
unalias zi
alias zz="zi"
alias oo='cd $OBSIDIAN_NOTES' # cd into notes folder
alias of='fuz -p $OBSIDIAN_NOTES' # fuzzy find notes
alias or='nvim $OBSIDIAN_NOTES/inbox/*.md' # open all unsorted notes
alias on="note-new"
alias od="note-daily"
alias ow="note-weekly"
alias og="note-organize"
alias t="sesh-sessions"
alias tk="ftmk"
alias td="tmux detach"
alias du="du -h"
alias dus="du -hs *"
alias tl="tail -f"

# ── Functions ─────────────────────────────────────────────────────────
fdir() {
  local dir
  cd $HOME
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}
fkill() {
    local pid
    if [ "$UID" != "0" ]; then
        pid=$(ps -f -u $UID | sed 1d | fzf -m | awk '{print $2}')
    else
        pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
    fi

    if [ "x$pid" != "x" ]
    then
        echo $pid | xargs kill -${1:-9}
    fi
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
# ╭──────────────────────────────────────────────────────────╮
# │ tm [SESSION_NAME | FUZZY PATTERN] - create new tmux      │
# │ session, or switch to existing one.                      │
# │ Running `tm` will let you fuzzy-find a session name      │
# │ Passing an argument to `ftm` will switch to that         │
# │ session if it exists or create it otherwise              │
# ╰──────────────────────────────────────────────────────────╯
ftm() {
  [[ -n "$TMUX" ]] && change="switch-client" || change="attach-session"
  if [ $1 ]; then
    tmux $change -t "$1" 2>/dev/null || (tmux new-session -d -s $1 && tmux $change -t "$1"); return
  fi
  session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --exit-0) &&  tmux $change -t "$session" || echo "No sessions found."
}
# ╭──────────────────────────────────────────────────────────╮
# │ tmk [SESSION_NAME | FUZZY PATTERN] - delete tmux session │
# │ Running `tmk` will let you fuzzy-find a session name to  │
# │ delete                                                   │
# │ Passing an argument to `ftmk` will delete that session   │
# │ if it exists                                             │
# ╰──────────────────────────────────────────────────────────╯
ftmk() {
  if [ $1 ]; then
    tmux kill-session -t "$1"; return
  fi
  session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --height 40% --reverse --border-label ' Kill Tmux Session ' --border --prompt '⚡  ') &&  tmux kill-session -t "$session" || echo "No session found to delete."
}
vv() {
  # Assumes all configs exist in directories named ~/.config/nvim-*
  local config=$(fd --max-depth 1 --glob 'nvim-*' ~/.config | fzf --prompt="Neovim Configs > " --height=~50% --layout=reverse --border --exit-0)

  # If I exit fzf without selecting a config, don't open Neovim
  [[ -z $config ]] && echo "No config selected" && return

  # Open Neovim with the selected config
  NVIM_APPNAME=$(basename $config) nvim $@
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

# ── Shell integrations ───────────────────────────────────────────────
eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"
eval "$(fnm env --use-on-cd --shell zsh)"
eval $(keychain --eval --quiet id_ed25519 id_rsa)
source ~/.local/bin/fzf-git.sh
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
