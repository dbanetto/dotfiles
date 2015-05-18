source $HOME/.zsh/antigen.zsh
[[ "$TERM" == "xterm" ]] && export TERM=xterm-256color
# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles
antigen bundle git
antigen bundle pip
antigen bundle lein
antigen bundle command-not-found
antigen bundle zsh-users/zsh-completions src
antigen-bundle Tarrasch/zsh-bd

# Bullet train config
BULLETTRAIN_TIME_SHOW=false
BULLETTRAIN_NVM_SHOW=false
BULLETTRAIN_RVM_SHOW=false # Causes huge slowdown

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
BULLETTRAIN_GIT_MODIFIED=" "
BULLETTRAIN_GIT_DIRTY=" Δ"
BULLETTRAIN_GIT_CLEAN=" "
BULLETTRAIN_GIT_UNTRACKED=" "
BULLETTRAIN_GIT_AHEAD=" %F{mangenta}⬆%F{black}"
BULLETTRAIN_GIT_BEHIND=" %F{mangenta}⬇%F{black}"
BULLETTRAIN_GIT_DIVERGED=" %F{mangenta}⬍%F{black}"

# Load the theme.
antigen theme caiogondim/bullet-train-oh-my-zsh-theme bullet-train

# Tell antigen that you're done.
antigen apply

export PATH="$PATH:/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/bin/core_perl:$HOME/.gem/ruby/2.1.0/bin:/opt/java/bin:$HOME/.local/bin"
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_GB.UTF-8
export EDITOR='vim'

# ssh connections
if [[ -n $SSH_CONNECTION ]]; then
  BULLETTRAIN_IS_SSH_CLIENT=true
fi
export SSH_KEY_PATH="~/.ssh/rsa_id"

if [ "$COLORTERM" = "gnome-terminal" ] ; then
	source /etc/profile.d/vte.sh
fi

alias grep="grep --color=auto --exclude-dir=.cvs --exclude-dir=.git --exclude-dir=.hg --exclude-dir=.svn"
export GREP_OPTIONS=

export WORKON_HOME=$HOME/.config/virtualenvs
export VIRTUALENVWRAPPER_SCRIPT=/usr/bin/virtualenvwrapper.sh
source /usr/bin/virtualenvwrapper_lazy.sh
