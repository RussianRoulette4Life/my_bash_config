#!/usr/bin/env bash

CTR_COL="\e[31m"
USR_COL="\e[1;3m"
RST_COL="\e[0m"
DIR_COL="\e[32;4m"
PMT_COL="\e[7m"

if [[ -n $CONTAINER_ID ]]; then
	export TOP_PROMPT="╭─($USR_COL$USER@$HOSTNAME$RST_COL)────────►[$DIR_COL${PWD/*$HOME/\~}$RST_COL]────────►{$CTR_COL$CONTAINER_ID$RST_COL}"
else
	export TOP_PROMPT="╭─($USR_COL$USER@$HOSTNAME$RST_COL)────────►[$DIR_COL${PWD/*$HOME/\~}$RST_COL]"
fi

export MID_PROMPT="┷"
echo "\n$TOP_PROMPT\n$MID_PROMPT \$ "
