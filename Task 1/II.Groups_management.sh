#!/bin/bash

# Импорт полезных функций.
. Menu.sh
. Utility.sh

function add_group
{
	echo "Введите название для новой группы."
	read new_group_name
	addgroup "new_group_name"
	#if [ $? -eq 0 ]

	#	echo "Успешно."
}

function delete_group
{
  echo "Введите название группы, которую хотите удалить."
  read group_to_delete
  delgroup "group_to_delete"
  #if $? == 0:
  #  echo "Успешно."
}

function change_group
{
	menu --title="Изменение состава группы" "Добавить пользователя в группу" add_user_to_group "Удалить пользователя из группы" delete_user_from_group
}

# Просит пользователя ввести пользователя.
# Возвращает 0, если пользователь существует,
# 1 в противном случае.
function get_user
{
	echo "Введите id или имя существующего пользователя."
	read potential_user
	cut -d: -f1,3 /etc/passwd | tr : " " | contains $potential_user
	return $?
}

# Аналогично для групп.
function get_group
{
	echo "Введите id или имя существующего пользователя."
	read potential_user
	cut -d: -f1,3 /etc/passwd | tr : " " | contains $potential_user
	return $?
}

function add_user_to_group
{
echo hi
}

function delete_user_from_group
{
echo hi
}
