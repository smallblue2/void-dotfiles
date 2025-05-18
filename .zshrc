# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt extendedglob
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/niall/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# GTK Theme
export GTK_THEME=Gruvbox-Material-Dark-HIDPI

alias ls="ls --color"
