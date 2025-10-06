#!/usr/bin/env bash

LOCAL_EXEC_PATH="$HOME/.local/bin"
RESPIO_CONFIG_PATH="$HOME/.local/share/ResPio"

# получает путь и засовывает его в cat
add-to-top-of-init-set-style() {
	PREV_DIR="$(pwd)"
	BANNER=$1
	cd "$HOME/.bashrc.d"
	touch "./temp.sh"
	if [[ "$BANNER" != "" ]]; then
		echo -e "#!/usr/bin/env bash\nclear\ncat $BANNER" > "./temp.sh"
	else
		echo -e "#!/usr/bin/env bash\nclear" > "./temp.sh"
	fi
	cat "init_set_style" >> "./temp.sh"
	chmod +x "./temp.sh"
	rm "init_set_style"
	mv "./temp.sh" "init_set_style"
}

configure-theme() {
	echo -n "Хотите компактный промпт или широкий? [_c_ompact/_w_ide]: "
	read ans
	case $ans in
		"c")
			sed -i 's/COMPACT=0/COMPACT=1/' "$RESPIO_CONFIG_PATH/settings"
			;;
		"w")
			sed -i 's/COMPACT=1/COMPACT=0/' "$RESPIO_CONFIG_PATH/settings"
			;;
		*)
			echo "не понял :("
			;;
	esac

}

configure-banner() {

	cp -rf "$(pwd)/banners" "$RESPIO_CONFIG_PATH/banners"
	echo "Какой текст вы хотели бы выбрать для вывода при входе в командную строчку?
		1. Welcome, Human
		2. Welcome
		3. E. C. Pioneer
		4. Первопроходец
		5. Добрый день
		*. ничего"
	read ans
	case $ans in
		"1")
			add-to-top-of-init-set-style "$RESPIO_CONFIG_PATH/banners/welcome-human"
			;;
		"2")
			add-to-top-of-init-set-style "$RESPIO_CONFIG_PATH/banners/welcome"
			;;
		"3")
			add-to-top-of-init-set-style "$RESPIO_CONFIG_PATH/banners/e-c-pioneer"
			;;
		"4")
			add-to-top-of-init-set-style "$RESPIO_CONFIG_PATH/banners/pp"
			;;
		"5")
			add-to-top-of-init-set-style "$RESPIO_CONFIG_PATH/banners/dd"
			;;
		*)
			add-to-top-of-init-set-style
			;;
	esac

}

path-setup() {

	if [[ "$PATH" != *"$LOCAL_EXEC_PATH"* ]]; then
		export PATH="$PATH:$LOCAL_EXEC_PATH"
		echo "export PATH=\$PATH:$LOCAL_EXEC_PATH" >> "$HOME/.bashrc"
	fi

}

local-bin-setup() {

	if [[ -d "$LOCAL_EXEC_PATH" ]]; then
		if [[ -f "$(pwd)/scripts/update_prompt.sh" ]]; then
			cp "scripts/update_prompt.sh" "$LOCAL_EXEC_PATH/update_prompt"
			chmod +x "$LOCAL_EXEC_PATH/update_prompt"
			path-setup
			echo -e "Успешно установлен \e[34mupdate_prompt!\e[0m"
		else
			echo "ОШИБКА: не найден update_prompt.sh в рабочей директории ($(pwd))"
			exit 3
		fi
	else
		mkdir "$LOCAL_EXEC_PATH"
		local-bin-setup
	fi
}

bashrcd-setup() {

	if [[ -d "$HOME/.bashrc.d" ]]; then
		if [[ -f "$(pwd)/scripts/init_set_style.sh" ]]; then
			cp "scripts/init_set_style.sh" "$HOME/.bashrc.d/init_set_style"
			if [[ $(grep ".bashrc.d" "$HOME/.bashrc") == "" ]]; then
				echo '# если тема удалена, можно спокойно удалять строки до unset rc' >> "$HOME/.bashrc"
				echo -e "if [ -d ~/.bashrc.d ]; then\n\tfor rc in ~/.bashrc.d/*; do\n\t\tif [ -f \"\$rc\" ]; then\n\t\t\t. \"\$rc\"\n\t\tfi \n\tdone\nfi\nunset rc" >> "$HOME/.bashrc"
			fi
			chmod +x "$HOME/.bashrc.d/init_set_style"
			echo "init_set_style установлен!"
		else
			echo "ОШИБКА: не найден init_set_style.sh в рабочей директории ($(pwd))"
		fi
	else
		mkdir "$HOME/.bashrc.d"
		if [[ $(grep ".bashrc.d" "$HOME/.bashrc") == "" ]]; then
				echo '# если тема удалена, можно спокойно удалять строки до unset rc' >> "$HOME/.bashrc"
			echo -e "if [ -d ~/.bashrc.d ]; then\n\tfor rc in ~/.bashrc.d/*; do\n\t\tif [ -f \"\$rc\" ]; then\n\t\t\t. \"\$rc\"\n\t\tfi \n\tdone\nfi\nunset rc" >> "$HOME/.bashrc"
		fi
		bashrcd-setup
	fi

}

start-install() {

	touch "$HOME/.bashrc_temp"
	
	if [[ ! -d $RESPIO_CONFIG_PATH ]]; then
		mkdir $RESPIO_CONFIG_PATH
		cp "$(pwd)/default/settings.sh" "$RESPIO_CONFIG_PATH/settings"
	fi

	if [[ $(grep "RESPIO_CONFIG_PATH" "$HOME/.bashrc") == "" ]]; then
		echo -e "# .bashrc but cool\nexport RESPIO_CONFIG_PATH=$RESPIO_CONFIG_PATH\nsource \$RESPIO_CONFIG_PATH/settings" >> "$HOME/.bashrc_temp"
	fi
	if [[ ! -f "$RESPIO_CONFIG_PATH/settings" ]]; then
		cp "$(pwd)/default/settings.sh" "$RESPIO_CONFIG_PATH/settings"
	fi
	cat "$HOME/.bashrc" >> "$HOME/.bashrc_temp"
	rm "$HOME/.bashrc"
	mv "$HOME/.bashrc_temp" "$HOME/.bashrc"
}
echo "Добро пожаловать в установщик моей темы для bash! Она работает следующим образом:
	- Создаёт ~/.bashrc.d при отсутствии
	- Копирует в неё init_set_style.sh (оставляя без sh)
	- Создаёт (если нет) ~/.local/bin, кидает туда update_prompt.sh (без sh)
	- Добавляет в .bashrc строки если нет логики просмотра ~/.bashrc.d
	- создаёт конфиг папку (скорее всего в ~/.local/share), куда заливает баннеры
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

start-install
bashrcd-setup
local-bin-setup
configure-banner
configure-theme

echo -e "Установка \e[32mзавершена!\e[0m Тема будет применена после \e[31mперезапуска терминала!\e[0m"



