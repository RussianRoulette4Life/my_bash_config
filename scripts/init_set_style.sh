export PROMPT_COMMAND_OLD='PS1="\n\e[1;3m$USER@$HOSTNAME\e[0m:${PWD/*$HOME/\~}\n\$ "'

export PROMPT_COMMAND='PS1="$(update_prompt)"'
bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'
alias ls="ls --color"
alias l="ls"
alias ll="ls -la"
alias la="ls -a"
alias lR="ls -Ra"
alias grep="grep --color -E"
alias cl="source ~/.bashrc"
