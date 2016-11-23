#!/bin/bash

# Импорт полезных функций.
. Menu.sh
. Utility.sh

function groups_management
{
	echo "Not doen"
}

function add_group
{
	echo "Введите название для новой группы."
	read new_group_name
	addgroup "$new_group_name"
	if [ $? -eq 0 ]
	then
		echo "Успешно."
	fi
}

function delete_group
{
	echo "Введите название группы, которую хотите удалить."
	read group_to_delete
	delgroup "$group_to_delete"
	if [ $? -eq 0 ]
	then
		echo "Успешно."
	fi
}

function change_group
{
	title="Изменение состава группы."
	option1="Добавить пользователя в группу."
	option2="Удалить пользователя из группы."
	menu --title=$title $option1 add_user_to_group $option2 delete_user_from_group
}

# Просит пользователя ввести пользователя.
# Возвращает 0, если пользователь существует,
# 1 в противном случае.
function get_user
{
	echo "Введите id или имя существующего пользователя."
	read potential_user
	cut -d: -f1,3 /etc/passwd | tr : " " | contains $potential_user
	result=$?
	if [ 
	return $?
}

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
	if [ $? -eq 0 ]
	then
		echo "Успешно."
	fi
}

function delete_user_from_group
{
	echo "Введите группу и пользователя, которого хотите удалить из этой группы."
	read group user
	userdel -- "$user" "$group"
	if [ $? -eq 0 ]
	then
		echo "Успешно."
	fi
}
