source $HOME/.zsh/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles
antigen bundle git
antigen bundle pip
antigen bundle lein
antigen bundle command-not-found
antigen bundle zsh-users/zsh-completions

# Load the theme.
antigen theme caiogondim/bullet-train-oh-my-zsh-theme bullet-train

# bullet train config
BULLETTRAIN_PROMPT_CHAR=">"
BULLETTRAIN_TIME_SHOW=false
BULLETTRAIN_GIT_BG=white
BULLETTRAIN_GIT_FG=black
BULLETTRAIN_GIT_EXTENDED=true
BULLETTRAIN_GIT_MODIFIED=" %F{yellow}⚫%F{black}"
BULLETTRAIN_GIT_DIRTY=" %F{black}Δ%F{black}"
BULLETTRAIN_GIT_CLEAN=" "
BULLETTRAIN_GIT_UNTRACKED=" %F{blue}✭%F{black}"

BULLETTRAIN_VIRTUALENV_PREFIX=""
BULLETTRAIN_VIRTUALENV_FG="black"

# Tell antigen that you're done.
antigen apply

export WORKON_HOME=$HOME/.config/virtualenv
export VIRTUALENVWRAPPER_SCRIPT=/usr/bin/virtualenvwrapper.sh
source /usr/bin/virtualenvwrapper_lazy.sh
