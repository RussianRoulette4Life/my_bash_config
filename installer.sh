#!/usr/bin/env bash

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

configure-compact-theme() {
	echo -n "Хотите промпт ультракомпактный, компактный или широкий? [_u_ltracompact/_c_ompact/_w_ide]: "
	read ans
	sed -i "s/COMPACT=[a-z]/COMPACT=$ans/" "$RESPIO_CONFIG_PATH/settings"

}

configure-theme() {
	echo "Какую тему стоит установить?"
	for theme in $(ls "$RESPIO_CONFIG_PATH/themes"); do
		echo -e "Тема: $theme\n$(bash -c $RESPIO_CONFIG_PATH/themes/$theme)\n"
	done
	echo "Ничего: стандартная тема (default)"
	read ans
	if [[ $ans != "" ]]; then
		sed -i "s/THEME=[a-z]*/THEME=$ans/" "$RESPIO_CONFIG_PATH/settings"
	fi

	if [[ $ans != "simple" ]]; then
		configure-compact-theme
	fi
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


bashrcd-setup() {

	if [[ -d "$HOME/.bashrc.d" ]]; then
		if [[ -f "$(pwd)/scripts/init_set_style.sh" ]]; then
			cp "scripts/init_set_style.sh" "$HOME/.bashrc.d/init_set_style"
			if [[ $(grep ".bashrc.d" "$HOME/.bashrc") == "" ]]; then
				echo -e "if [ -d ~/.bashrc.d ]; then\n\tfor rc in ~/.bashrc.d/*; do\n\t\tif [ -f \"\$rc\" ]; then\n\t\t\t. \"\$rc\"\n\t\tfi \n\tdone\nfi\nunset rc" >> "$HOME/.respio_bootstrap"
			fi
			chmod +x "$HOME/.bashrc.d/init_set_style"
			echo "init_set_style установлен!"
		else
			echo "ОШИБКА: не найден init_set_style.sh в рабочей директории ($(pwd))"
		fi
	else
		mkdir "$HOME/.bashrc.d"
		bashrcd-setup
	fi

}

start-install() {
	cp "default/respio_bootstrap" "$HOME/.respio_bootstrap"
	if [[ $(cat "$HOME/.bashrc" | grep "source $HOME/.respio_bootstrap") == "" ]]; then
		echo "source $HOME/.respio_bootstrap" >> "$HOME/.bashrc"
	else
		sed -i "s-#source $HOME/.respio_bootstrap-source $HOME/.respio_bootstrap-" "$HOME/.bashrc"
	fi
	# IMPORTANT: все файлы для тем копируются именно на этом этапе
	if [[ ! -d $RESPIO_CONFIG_PATH ]]; then
		mkdir $RESPIO_CONFIG_PATH
		cp "$(pwd)/default/settings.sh" "$RESPIO_CONFIG_PATH/settings"
		cp -r "$(pwd)/themes" "$RESPIO_CONFIG_PATH/themes"
	fi
}
echo "Добро пожаловать в установщик моей темы для bash! Она работает следующим образом:
	- Создаёт ~/.bashrc.d при отсутствии
	- Копирует в неё init_set_style.sh (оставляя без sh)
	- Добавляет в .bashrc строки если нет логики просмотра ~/.bashrc.d
	- создаёт конфиг папку (скорее всего в ~/.local/share), куда заливает баннеры, темы и настройки
Продолжить? [y/n]"

read ans

if [[ $( ls "/usr/bin" | grep "git" ) == "" ]]; then
	echo "Установите git!"
	exit 109
else
	echo "git найден"
fi

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
configure-banner
configure-theme

echo -e "Установка \e[32mзавершена!\e[0m Тема будет применена после \e[31mперезапуска терминала!\e[0m"



