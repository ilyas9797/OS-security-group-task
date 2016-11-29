#!/bin/bash

# Импорт полезных функций.
. Menu.sh

function groups_management
{
	title='Меню управления группами.'
	help_info='Здесь вы можете добавлять, удалять группы и изменять их состав'
	quit='В главное меню.'
	option1='Добавить группу.'
	option2='Удалить группу.'
	option3='Изменить состав группы.'
	menu --title="$title" --help="$help_info" --quit="$quit" "$option1" add_group "$option2" delete_group "$option3" change_group
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
	echo "Удалить пользователя y/N?"
	read reply
	if [ $reply != "y" ]
	then 
		echo "Отказ в удалении"
		return 0
	fi
	#Домашняя папка
	echo "Удалить домашний каталог пользователя y/N?"
	read reply
	if [ $reply = "y" ]
	then 
		key="-r"
	fi
	userdel "$key" -- "$user_to_delete"
	result=$?
	if [ $result -eq 0 ]
	then
		echo "Успешно."
	fi
	return $result
}
