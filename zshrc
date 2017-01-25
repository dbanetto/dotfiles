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


# Bullet train config
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
BULLETTRAIN_HG_SHOW=false

prompt_ruby() {
  if [ command -v rbenv > /dev/null 2>&1 ]; then
    local current = $(rbenv version | sed -e 's/ (set.*$//')
    if [[ ! "$(rbenv global)" == "$current" ]]; then
      prompt_segment $BULLETTRAIN_RUBY_BG $BULLETTRAIN_RUBY_FG $BULLETTRAIN_RUBY_PREFIX" $current"
    fi
  fi
}

# segment ordering
BULLETTRAIN_PROMPT_ORDER=(
    status
    context
    dir
    ruby
    virtualenv
    git
    cmd_exec_time
)

export PATH="$HOME/.rbenv/bin:$PATH"

if type rbenv >/dev/null 2>&1; then
  eval "$(rbenv init -)"
fi

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

# zgen
source $HOME/.zgen/zgen.zsh
if ! zgen saved; then
  # Load the oh-my-zshs library.
  zgen oh-my-zsh

  ## Bundles
  # optionals
  if [[ "$(uname)" == "Darwin" ]] ; then
    zgen oh-my-zsh plugins/brew
    zgen oh-my-zsh plugins/osx
  fi

  if type virtualenv >/dev/null 2>&1; then
    zgen oh-my-zsh plugins/virtualenvwrapper
  fi
  if type rbenv >/dev/null 2>&1; then
    zgen oh-my-zsh plugins/rbenv
  fi

  # completions
  zgen load zsh-users/zsh-completions src
  zgen load zyphrus/zsh-scripts

  # theme
  zgen load caiogondim/bullet-train-oh-my-zsh-theme bullet-train

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

# vim: set ts=2 sw=2 expandtab:
