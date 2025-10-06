#!/usr/bin/env bash

CTR_COL="\e[31m"
USR_COL="\e[34;3m"
RST_COL="\e[0m"
DIR_COL="\e[32;4m"
PMT_COL="\e[7m"
GIT_COL="\e[35;1m"

GIT_BRANCH=$(git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/\1/p')

# compact or naw
case $RESPIO_COMPACT in
	"0")
		ARROW="────────►"
		;;
	"1")
		ARROW="──►"
		;;
	"2")
		ARROW="─►"
		;;
esac

if [[ -n $CONTAINER_ID ]]; then
	export TOP_PROMPT="╭─($USR_COL$USER@$HOSTNAME$RST_COL)$ARROW{$CTR_COL$CONTAINER_ID$RST_COL}$ARROW[$DIR_COL${PWD/*$HOME/\~}$RST_COL]"
else
	export TOP_PROMPT="╭─($USR_COL$USER@$HOSTNAME$RST_COL)$ARROW[$DIR_COL${PWD/*$HOME/\~}$RST_COL]"
fi

if [[ "$GIT_BRANCH" != "" ]]; then 
	TOP_PROMPT="$TOP_PROMPT$ARROW[$GIT_COL$GIT_BRANCH$RST_COL]" 
fi

MID_PROMPT="┷"
echo "\n$TOP_PROMPT\n$MID_PROMPT \$ "
