#!/bin/bash

. Menu.sh

function user_and_group_search
{
	title='Меню поиска пользователей и групп.'
	help_info='Здесь вы можете найти пользователей и группы.'
	quit='В главное меню.'
	option1='Найти пользователя.'
	option2='Найти группу.'
	menu --title="$title" --help="$help_info" --quit="$quit" "$option1" "repeat user_search" "$option2" "repeat group_search"
}

function user_search
{
	echo "Введите имя пользователя или часть имени."
	read a

	tmp=`mktemp usersXXX`

	grep [^:]*"$a"[^:]*:.* /etc/passwd |
	while IFS=: read nickname x1 uid gid name home shell x2
	do
	  if [ $uid -lt 1000 ]
	  then
		continue
	  fi
	  echo
	  echo "Логин = $nickname"
	  echo "uid = $uid; gid = $gid"
	  echo "Имя = $name"
	  echo "Домашняя папка = $home"
	  echo "shell = $shell"
	done >$tmp 

	
	line_count=`wc -l $tmp | cut -d' ' -f1`
	LINES=$(tput lines)

	if [ $line_count -eq '0' ]
	then
	  echo "Пользователи не найдены."
	elif [ "$line_count" -lt "$LINES" ]
	then
		cat $tmp
	else
		cat $tmp | less
	fi

	rm $tmp
}

function group_search
{
	echo "Введите название группы или часть названия."
	read a

	tmp=`mktemp usersXXX`

	grep [^:]*"$a"[^:]*:.* /etc/group |
	while IFS=: read name x gid group_list
	do
		echo "Название = $name"
		echo "gid = $gid"
		echo "Список пользователей: $group_list"
		echo
	done >$tmp 

	line_count=`wc -l $tmp | cut -d' ' -f1`
	LINES=$(tput lines)

	if [ $line_count -eq '0' ]
	then
	  echo "Группы не найдены."
	elif [ "$line_count" -lt "$LINES" ]
	then
		cat $tmp
	else
		cat $tmp | less
	fi


	rm $tmp
}

# Собственно запуск скрипта, состоящий только из вызова меню.
user_and_group_search $*
