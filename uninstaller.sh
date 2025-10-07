#!/usr/bin/env bash

echo "Удалить кастомизацию? [y/n]"

read ans

case $ans in
	"y")
		rm "$HOME/.bashrc.d/init_set_style"
		rm -rf "$RESPIO_CONFIG_PATH"
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
