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

function add_group
{
	echo "Введите название для новой группы."
	read new_group_name
	groupadd "$new_group_name"
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
	groupdel "$group_to_delete"
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
	menu --title="$title" --help="$help_info" "$option1" add_user_to_group "$option2" delete_user_from_group
}

# НЕ НУЖНА
# Просит пользователя ввести пользователя.
# Возвращает 0, если пользователь существует,
# 1 в противном случае.
function get_user
{
	echo "Введите id или имя существующего пользователя."
	read potential_user
	cut -d: -f1,3 /etc/passwd | tr : " " | contains $potential_user
	result=$?
	return $?
}

# НЕ НУЖНА
# Аналогично для групп.
function get_group
{
	echo "Введите id или название существующей группы."
	read potential_group
	cut -d: -f1,3 /etc/group | tr : " " | contains $potential_group
	return $?
}

function add_user_to_group
{
	echo "Введите группу и пользователя, которого хотите добавить в эту группу(через пробел)."
	read group user
	useradd -aG -- "$user" "$group"
	result=$?
	if [ $result -eq 0 ]
	then
		echo "Успешно."
	fi
	return $result
}

function delete_user_from_group
{
	echo "Введите группу и пользователя, которого хотите удалить из этой группы."
	read group user
	userdel -- "$user" "$group"
	result=$?
	if [ $result -eq 0 ]
	then
		echo "Успешно."
	fi
	return $result
}
