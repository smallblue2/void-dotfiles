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
alias fastfetch="fastfetch --raw $HOME/Pictures/void.sixel --logo-height 0 --logo-width 50 --logo-padding-left 2 --logo-padding-top 3"
alias ff="fastfetch"

autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%b '
setopt PROMPT_SUBST
PROMPT='%F{green}%* %F{blue}%~%f %F{red}${vcs_info_msg_0_}%f$ '
