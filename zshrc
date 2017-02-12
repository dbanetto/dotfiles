[[ "$TERM" == "xterm" ]] && export TERM=xterm-256color
export PATH="$HOME/.rbenv/bin:$PATH"

if type rbenv >/dev/null 2>&1; then
  eval "$(rbenv init -)"
fi

if type ruby >/dev/null 2>&1; then
  export GEM_HOME=$(ruby -e 'print Gem.user_dir')
fi

export npm_config_prefix=$HOME/.node_modules

export PATH="$PATH:/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/bin/core_perl:$GEM_HOME/bin:$npm_config_prefix/bin:$HOME/.local/bin"
export WORKON_HOME=$HOME/.config/virtualenvs

if type ruby >/dev/null 2>&1; then
  export GEM_HOME=$(ruby -e 'print Gem.user_dir')
fi

export npm_config_prefix=$HOME/.node_modules

export PATH="$PATH:/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/bin/core_perl:$GEM_HOME/bin:$npm_config_prefix/bin:$HOME/.local/bin"

export LANG=en_GB.UTF-8
if type nvim >/dev/null 2>&1; then
  export EDITOR='nvim'
else
  export EDITOR='vim'
fi

# ssh connections
# if [[ -n $SSH_CONNECTION ]]; then ; fi
export SSH_KEY_PATH="~/.ssh/rsa_id"

if [ "$COLORTERM" = "gnome-terminal" ] ; then
  source /etc/profile.d/vte.sh
fi

zstyle ':prezto:*:*' color 'yes'

## zgen
ZGEN_PREZTO_REPO='zsh-users'
source $HOME/.zgen/zgen.zsh
if ! zgen saved; then
  zgen prezto

  zgen prezto history-substring-search
  zgen prezto utility
  zgen prezto zsh-notify

  zgen save
fi

## prezto
# prompt
prompt pure

# zsh-notify
zstyle ':notify:*' error-title 'Err'
zstyle ':notify:*' success-title 'Ok'

## aliases
alias grep="grep --color=auto --exclude-dir=.cvs --exclude-dir=.git --exclude-dir=.hg --exclude-dir=.svn"

# git alias
alias gc="git commit"
alias gh="git checkout"
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
alias gsh="git status -sb ."
alias gd="git diff"
alias gds="git diff --staged"
alias gr="git reset"
alias grh="git reset --hard"
alias glrm="git pull --rebase origin master"

# bundle alias
alias b="bundle"
alias be="bundle exec"

# vim: set ts=2 sw=2 expandtab:
