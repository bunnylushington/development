ZSH=$HOME/.oh-my-zsh
ZSH_THEME="montuori"
DISABLE_AUTO_UPDATE=true
plugins=(git git-flow osx vagrant tmux rebar mix docker)
export ZSH_TMUX_AUTOCONNECT=true
export DISABLE_AUTO_TITLE=true

[[ $EMACS = t ]] && unsetopt zle

source $ZSH/oh-my-zsh.sh
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

alias tmux="tmux -2"
export TERM=xterm-256color

export LESSOPEN="| /usr/bin/source-highlight-esc.sh %s"
export LESS='-R'