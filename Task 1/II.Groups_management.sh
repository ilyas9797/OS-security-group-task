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
	menu --title="$title" --help="$help_info" --quit="$quit" "$option1" "repeat add_group" "$option2" "repeat delete_group" "$option3" change_group
}

function add_group
{
	echo "Введите название для новой группы."
	read new_group_name
	groupadd -- "$new_group_name"
	result=$?
	if [ $result -eq 0 ]
	then
		echo "Успешно."
	fi
	return $result
}

function delete_group
{
	echo "Введите название группы, которую хотите удалить."
	read group_to_delete
	groupdel -- "$group_to_delete"
	result=$?
	if [ $result -eq 0 ]
	then
		echo "Успешно."
	fi
	return $result
}

function change_group
{
	title="Изменение состава группы."
	help_info='Здесь вы можете изменить состав групп.'
	option1="Добавить пользователя в группу."
	option2="Удалить пользователя из группы."
	menu --title="$title" --help="$help_info" "$option1" "repeat add_user_to_group" "$option2" "repeat delete_user_from_group"
}

function add_user_to_group
{
	echo "Введите группу и пользователя, которого хотите добавить в эту группу(через пробел)."
	read group user
	gpasswd --add "$user" -- "$group"
	result=$?
	return $result
}

function delete_user_from_group
{
	echo "Введите группу и пользователя, которого хотите удалить из этой группы."
	read group user
	gpasswd --delete "$user" -- "$group"
	result=$?
	return $result
}

# Собственно запуск скрипта, состоящий только из вызова меню.
groups_management
