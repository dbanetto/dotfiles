source $HOME/.zgen/zgen.zsh
[[ "$TERM" == "xterm" ]] && export TERM=xterm-256color

export WORKON_HOME=$HOME/.config/virtualenvs

# Bullet train config
BULLETTRAIN_TIME_SHOW=false
BULLETTRAIN_NVM_SHOW=false
BULLETTRAIN_RUBY_SHOW=false

BULLETTRAIN_MULTIRUST_SHOW=true
BULLETTRAIN_MULTIRUST_PREFIX="⚙"
BULLETTRAIN_MULTIRUST_BG=130

BULLETTRAIN_VIRTUALENV_SHOW=true
BULLETTRAIN_VIRTUALENV_PREFIX=""
BULLETTRAIN_VIRTUALENV_BG=214
BULLETTRAIN_VIRTUALENV_FG=black

BULLETTRAIN_DIR_BG=004
BULLETTRAIN_DIR_FG=white

BULLETTRAIN_PROMPT_CHAR=">"

BULLETTRAIN_GIT_BG=007
BULLETTRAIN_GIT_FG=black
BULLETTRAIN_GIT_EXTENDED=true
BULLETTRAIN_GIT_SHOW_STASH=true
BULLETTRAIN_GIT_MODIFIED=" "
BULLETTRAIN_GIT_DIRTY=" Δ"
BULLETTRAIN_GIT_CLEAN=" "
BULLETTRAIN_GIT_UNTRACKED=" "
BULLETTRAIN_GIT_AHEAD=" %F{black}⬆%F{black}"
BULLETTRAIN_GIT_BEHIND=" %F{black}⬇%F{black}"
BULLETTRAIN_GIT_DIVERGED=" %F{black}⬍%F{black}"

if ! zgen saved; then
  # Load the oh-my-zshs library.
  zgen oh-my-zsh

  # Bundles
  zgen oh-my-zsh plugins/pip
  zgen oh-my-zsh plugins/npm
  zgen oh-my-zsh plugins/virtualenvwrapper
  zgen oh-my-zsh plugins/web-search
  zgen load zsh-users/zsh-completions src
  zgen load Tarrasch/zsh-bd

  # completions
  zgen load zsh-users/zsh-completions src
  zgen load zyphrus/zsh-scripts

  # Load the theme.
  zgen load zyphrus/bullet-train-oh-my-zsh-theme bullet-train

  zgen save
fi

# Hack to fix BULLETTRAIN_GIT_* not being set
ZSH_THEME_GIT_PROMPT_MODIFIED=$BULLETTRAIN_GIT_MODIFIED
ZSH_THEME_GIT_PROMPT_DIRTY=$BULLETTRAIN_GIT_DIRTY
ZSH_THEME_GIT_PROMPT_CLEAN=$BULLETTRAIN_GIT_CLEAN
ZSH_THEME_GIT_PROMPT_UNTRACKED=$BULLETTRAIN_GIT_UNTRACKED
ZSH_THEME_GIT_PROMPT_AHEAD=$BULLETTRAIN_GIT_AHEAD
ZSH_THEME_GIT_PROMPT_BEHIND=$BULLETTRAIN_GIT_BEHIND
ZSH_THEME_GIT_PROMPT_DIVERGED=$BULLETTRAIN_GIT_DIVERGED

export GEM_HOME=$(ruby -e 'print Gem.user_dir')

export PATH="$PATH:/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/bin/core_perl:$GEM_HOME/bin:$HOME/.local/bin"

export LANG=en_GB.UTF-8
export EDITOR='vim'

# ssh connections
if [[ -n $SSH_CONNECTION ]]; then
  BULLETTRAIN_IS_SSH_CLIENT=true
  BULLETTRAIN_CONTEXT_SHOW=true
  BULLETTRAIN_DIR_BG=red
  BULLETTRAIN_DIR_FG=black
  BULLETTRAIN_GIT_EXTENDED=false
fi
export SSH_KEY_PATH="~/.ssh/rsa_id"

if [ "$COLORTERM" = "gnome-terminal" ] ; then
  source /etc/profile.d/vte.sh
fi

if [ "$TERM" = "rxvt-unicode-256color" ] ; then
  if type tmux >/dev/null 2>&1; then
    test -z "$TMUX" && tmx $USER@$HOST
  fi
fi

alias grep="grep --color=auto --exclude-dir=.cvs --exclude-dir=.git --exclude-dir=.hg --exclude-dir=.svn"
export GREP_OPTIONS=

# git alias
alias gc="git commit"
alias go="git checkout"
alias gb="git branch"
alias ga="git add"
alias gf="git fetch"
alias gp="git push"
alias gl="git pull"
alias gt="git stash"
alias gta="git stash apply"
alias gtp="git stash pop"
alias gts="git stash save"
alias gs="git status -sb"
alias gh="git status -sb ."
alias gd="git diff"
alias gds="git diff --staged"

# bundle alias
alias be="bundle exec"

# vim: set ts=2 sw=2 expandtab:
