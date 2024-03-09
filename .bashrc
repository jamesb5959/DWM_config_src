#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias unzip='bsdtar xvf'
# PS1='[\u@\h \W]\$ '
PS1="\[\e[38;5;242m\][\[\e[38;5;72m\]\u\[\e[38;5;73m\]@\[\e[38;5;74m\]\h \[\e[1;38;5;30m\]\W\[\e[38;5;242m\]]\[\033[0m\]$ "
# neofetch  --ascii .config/neofetch/ascii/nerv --ascii_colors 0
