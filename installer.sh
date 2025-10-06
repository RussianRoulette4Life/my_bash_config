#!/usr/bin/env bash

path-setup() {

	if [[ "$PATH" != *"$HOME/.local/bin"* ]]; then
		export PATH="$PATH:$HOME/.local/bin"
		echo 'export PATH="$PATH:$HOME/.local/bin' >> "$HOME/.bashrc"
	fi

}

local-bin-setup() {

	if [[ -d "$HOME/.local/bin" ]]; then
		if [[ -f "$(pwd)/update_prompt.sh" ]]; then
			cp "update_prompt.sh" "$HOME/.local/bin/update_prompt"
			chmod +x "$HOME/.local/bin/update_prompt"
			path-setup
			echo -e "Успешно установлен \e[34mupdate_prompt!\e[0m"
		else
			echo "ОШИБКА: не найден update_prompt.sh в рабочей директории ($(pwd))"
			exit 3
		fi
	else
		mkdir "$HOME/.local/bin"
		local-bin-setup
	fi
}

bashrcd-setup() {

	if [[ -d "$HOME/.bashrc.d" ]]; then
		if [[ -f "$(pwd)/init_set_style.sh" ]]; then
			cp "init_set_style.sh" "$HOME/.bashrc.d/init_set_style"
			if [[ $(grep ".bashrc.d" "$HOME/.bashrc") == "" ]]; then
				echo -e "if [ -d ~/.bashrc.d ]; then\n\tfor rc in ~/.bashrc.d/*; do\n\t\tif [ -f \"\$rc\" ]; then\n\t\t\t. \"\$rc\"\n\t\tfi \n\tdone\nfi\nunset rc" >> "$HOME/.bashrc"
			fi
			chmod +x "$HOME/.bashrc.d/init_set_style"
			echo "init_set_style установлен!"
			local-bin-setup
		else
			echo "ОШИБКА: не найден init_set_style.sh в рабочей директории ($(pwd))"
		fi
	else
		mkdir "$HOME/.bashrc.d"
		if [[ $(grep ".bashrc.d" "$HOME/.bashrc") == "" ]]; then
			echo -e "if [ -d ~/.bashrc.d ]; then\n\tfor rc in ~/.bashrc.d/*; do\n\t\tif [ -f \"\$rc\" ]; then\n\t\t\t. \"\$rc\"\n\t\tfi \n\tdone\nfi\nunset rc" >> "$HOME/.bashrc"
		fi
		bashrcd-setup
	fi

}

echo "Добро пожаловать в установщик моей темы для bash! Она работает следующим образом:
	- Создаёт ~/.bashrc.d при отсутствии
	- Копирует в неё init_set_style.sh (оставляя без sh)
	- Создаёт (если нет) ~/.local/bin, кидает туда update_prompt.sh (без sh)
	- Добавляет в .bashrc строки если нет логики просмотра ~/.bashrc.d
Продолжить? [y/n]"

read ans

case $ans in
	"y")
		echo -e "\e[32mНачинаем\e[0m..."
		;;
	"n")
		echo -e "Извините... Завершаем."
		exit 1
		;;
	*)
		echo "обидно так-то..."
		exit 1000
		;;
esac

bashrcd-setup

echo -e "Установка \e[32mзавершена!\e[0m Тема будет применена через \e[31m5\e[0m секунд"
sleep 5
source "$HOME/.bashrc"



