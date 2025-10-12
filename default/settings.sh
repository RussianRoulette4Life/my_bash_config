#!/usr/bin/env bash


# выбор темы. название файла совпадает с названием shell-скрипта, 
# который выдаёт промпт в том или ином виде (через echo). 
# сами файлы в RESPIO_CONFIG_PATH/themes/
export RESPIO_THEME=default


# СЕКЦИЯ ДЛЯ СТАНДАРТНОЙ ТЕМЫ!
## работает для тем с длинными стрелочками (w - wide, c - compact, u - ultracompact)
export RESPIO_COMPACT=u
export RESPIO_SHOW_TIME=yes

# СЕКЦИЯ ДЛЯ ОБОИХ ТЕМ!
export RESPIO_SHOW_BAT_CHARGE=yes
