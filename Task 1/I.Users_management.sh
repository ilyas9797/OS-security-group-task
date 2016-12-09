#!/bin/bash

# Импорт полезных функций.
. Menu.sh
. Task_I_c.sh
. Task_I_e.sh

function users_management
{
	title='Меню управления пользователями.'
	help_info='Здесь вы можете добавлять и удалять пользователей.'
	quit='В главное меню.'
	option1='Добавить пользователя.'
	option2='Удалить пользователя.'
	option3='Блокировка/разблокировка пользователя.'
	action3="repeat lock_or_unlock_user"
	option4="Добавить пользователя в группу."
	action4="echo not done yet"
	option5="Смена пароля пользователя."
	action5="repeat change_password"
	menu --title="$title" --help="$help_info" --quit="$quit" "$option1" "repeat add_user" "$option2" "repeat delete_user" "$option3" "$action3" "$option4" "$action4" "$option5" "$action5"
}

function add_user
{
	echo "Введите имя нового пользователя."
	read new_user_name
	useradd -- "$new_user_name"
	result=$?
	if [ $result -eq 0 ]
	then
		echo "Успешно."
	fi
	return $result
}

function delete_user
{
	echo "Введите имя или ID пользователя, которого хотите удалить."
	read user_to_delete
	# Уточнение.
	printf "Удалить пользователя %s? (y/N)" "$user_to_delete"
	read reply
	if [ $reply != "y" ]
	then 
		echo "Вы решили не удалять."
		return 0
	fi
	# Домашняя папка
	echo "Удалить домашний каталог пользователя? (y/N)"
	read reply
	if [ $reply = "y" ]
	then 
		key="--remove"
	else
		key=" "
	fi
	# Удаление пользователя.
	userdel $key -- "$user_to_delete"
	result=$?
	if [ $result -eq 0 ]
	then
		echo "Успешно."
	fi
	return $result
}

# Собственно запуск скрипта, состоящий только из вызова меню.
users_management $*
