#!/usr/bin/env bash

echo "Удалить кастомизацию? [y/n]"

read ans

case $ans in
	"y")
		rm "$HOME/.bashrc.d/init_set_style"
		rm -rf "$RESPIO_CONFIG_PATH"
		rm "$HOME/.respio_bootstrap"
		sed -i "s-^source $HOME/.respio_bootstrap-#source $HOME/.respio_bootstrap-" "$HOME/.bashrc"
		echo "Готово!"
		;;
	"n")
		echo "извинити"
		exit 1
		;;
	*)
		echo "?"
		exit 1000
		;;

esac
