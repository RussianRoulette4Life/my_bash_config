
export PROMPT_COMMAND='PS1="$(bash -c $RESPIO_CONFIG_PATH/themes/$RESPIO_THEME)"'
bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'
bind '"\e[Z": menu-complete-backward'
alias ls="ls --color"
alias l="ls"
alias ll="ls -la"
alias la="ls -a"
alias lR="ls -Ra"
alias grep="grep --color -E"
alias cl="source ~/.bashrc"
