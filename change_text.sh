#!/usr/bin/env bash

change_text() {
	PREV_DIR="$(pwd)"
	cd "$HOME/.bashrc.d"
	touch "./temp.sh"
	if [[ "$1" != "" ]]; then
		echo -e "#!/usr/bin/env bash\nclear\ncat $1" > "./temp.sh"
	else
		echo -e "#!/usr/bin/env bash\nclear" > "./temp.sh"
	fi
	cat "$PREV_DIR/scripts/init_set_style.sh" >> "./temp.sh"
	chmod +x "./temp.sh"
	rm "init_set_style"
	mv "./temp.sh" "init_set_style"
}

echo "Напишите имя файла, которое хотите выводить перед каждым запуском консоли. Выбор:"

ls banners

echo -n "Ваш выбор: "

read choice

if [[ -f "banners/$choice" ]]; then
	change_text "$RESPIO_CONFIG_PATH/banners/$choice"
else
	echo "нет"
fi
