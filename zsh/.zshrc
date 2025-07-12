autoload -Uz compinit && compinit

zstyle ':prezto:*:*' color 'yes'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.local/cache/zsh

if [ -n  ${LS_COLORS} ] ; then
  zstyle ':completion:*' list-colors 'exfxcxdxbxegedabagacad'
else
  zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
fi

## zgen
source $HOME/.zgen/zgen.zsh
if ! zgen saved; then
  zgen prezto

  zgen prezto completion
  zgen prezto history-substring-search
  zgen prezto utility

  zgen save
fi

# conditionally run with starship
if command -v starship > /dev/null 2>&1 ; then
  eval "$(starship init zsh)"
else
  prompt pure
fi

git_default_branch() {
  (git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@') 2>/dev/null
}

# entering a command with a leadning space ("<SPACE>ls)
# will not save it to hsitory
setopt histignorespace

## aliases
alias grep="grep --color=auto --exclude-dir=.cvs --exclude-dir=.git --exclude-dir=.hg --exclude-dir=.svn"

# git alias
alias gc="git commit"
alias gh="git checkout"
alias gb="git branch"
alias ga="git add"
alias gf="git fetch"
alias gp="git push"
alias gpf="git push --force-with-lease"
alias gl="git pull"
alias glr="git pull --rebase"
alias glrm="git pull --rebase origin \$(git_default_branch)"
alias gs="git status -sb"
alias gsh="git status -sb ."
alias gd="git diff"
alias gds="git diff --staged"
alias gr="git reset"
alias grh="git reset --hard"
alias ghm="git checkout \$(git_default_branch)"
alias gcd="cd \$(git rev-parse --show-toplevel)"
alias gw="git worktree"

alias org="$EDITOR ~/orgfiles/refile.org"

function ghr() {
  # alias of git checkout $(select from git recent)
  local recent

  recent=($(git branch --sort=-committerdate --format='%(refname:short)' | head -9))

  PS3='Select branch, or 0 to exit: '
  select branch in "${recent[@]}"; do
      if [[ $REPLY == "0" ]]; then
          echo 'Bye!' >&2
          break
      elif [[ -z $branch ]]; then
          echo 'Invalid choice, try again' >&2
          break
      else
        git checkout "${branch}"
        break
      fi
  done
}

function gwcd() {
  # List out git worktrees and change directory to them.
  local recent

  recent=()
  while IFS= read -r line; do
    recent+=( "$line" )
  done < <( git worktree list )

  PS3='Select branch, or 0 to exit: '
  select branch in ${recent}; do
      if [[ $REPLY == "0" ]]; then
          echo 'Bye!' >&2
          break
      elif [[ -z $branch ]]; then
          echo 'Invalid choice, try again' >&2
          break
      else
        cd $(echo "${branch}" | cut -f1 -d' ')
        break
      fi
  done
}

# Adding semantic escape sequences (OSC 133)
# for nvim terminal support of moving between commands
function _starship_precmd_marker(){
  printf "\033]133;A\007"
}
precmd_functions+=(_starship_precmd_marker)

# vim: set ts=2 sw=2 expandtab:
