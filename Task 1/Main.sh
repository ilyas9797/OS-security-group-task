#!/bin/bash

# Импорт полезных функций.
. Menu.sh

function main
{
	# Проверка на выполнение от рута.
	user=`whoami`
	if [ "$user" = "root" ]
	then
		echo "Данный скрипт можно выполнять только от имени пользователя root." >&2
		return 1
	fi

	# Вывод справки при ключе --help
	if [ "$1" = "--help" ]
	then
		echo "Данный скрипт позволяет создавать, удалять, искать пользователей и группы. А также блокировать пользователей, менять их пароли и добавлять/удалять из групп."
		echo
	fi
	
	# Название программы.
	echo "Управление пользователями и группами."
	echo
	# Авторы.
	echo "Авторы: Бобров В., Гентюк В., Клюев А., Лермонтов В., Хайруллин И."
	echo
	# Краткое описание.
	echo "Данный скрипт предоставляет возможности управления пользователями и группами."
	echo

	# Меню.
	title='Главное меню.'
	help_info='Здесь вы можете выбрать, что делать дальше.'
	quit='Выход из программы.'
	option1='Управление пользователями.'
	action1="bash I.Users_management.sh"
	option2='Управление группами.'
	action2="bash II.Groups_management.sh"
	option3='Поиск пользователей или групп.'
	menu --title="$title" --help="$help_info" --quit="$quit" "$option1" "$action1" "$option2" "$action2" "$option3" "echo Не сделано"
}

# Запуск скрипта.
main $*
