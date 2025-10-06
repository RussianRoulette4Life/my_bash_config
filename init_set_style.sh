#!/usr/bin/sh

export PROMPT_COMMAND_OLD='PS1="\n\e[1;3m$USER@$HOSTNAME\e[0m:${PWD/*$HOME/\~}\n\$ "'

clear

cat << LOGO
                             ,,                                               
'7MMF'     A     '7MF'     '7MM                                               
  'MA     ,MA     ,V         MM                                               
   VM:   ,VVM:   ,V .gP"Ya   MM  ,p6"bo   ,pW"Wq.'7MMpMMMb.pMMMb.  .gP"Ya     
    MM.  M' MM.  M',M'   Yb  MM 6M'  OO  6W'   'Wb MM    MM    MM ,M'   Yb    
    'MM A'  'MM A' 8M""""""  MM 8M       8M     M8 MM    MM    MM 8M""""""    
     :MM;    :MM;  YM.    ,  MM YM.    , YA.   ,A9 MM    MM    MM YM.    , ,, 
      VF      VF    'Mbmmd'.JMML.YMbmd'   'Ybmd9'.JMML  JMML  JMML.'Mbmmd' dg 
                                                                           ,j 
                                                                          ,'  


	'7MMF'  '7MMF'                                                  
	  MM      MM                                                    
	  MM      MM  7MM   7MM   7MMpMMMb.pMMMb.   ,6"Yb.   7MMpMMMb.  
	  MMmmmmmmMM   MM    MM    MM    MM    MM  8)   MM    MM    MM  
	  MM      MM   MM    MM    MM    MM    MM   ,pm9MM    MM    MM  
	  MM      MM   MM    MM    MM    MM    MM  8M   MM    MM    MM  
	.JMML.  .JMML. 'Mbod"YML..JMML  JMML  JMML.'Moo9^Yo..JMML  JMML.


LOGO

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
