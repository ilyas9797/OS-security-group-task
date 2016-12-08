#!/bin/bash

function user_search
{
	echo "тестовый поиск польpователей"
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
	  echo "nickname = $nickname"
	  echo "uid = $uid; gid=$gid"
	  echo "name = $name"
	  echo "home = $home"
	  echo "shell = $shell"
	done >$tmp 

	
	line_count=`wc -l $tmp | cut -d' ' -f1`

	if [ $line_count -eq '0' ]
	then
	  echo "Пользователи не найдены."
	elif [ $line_count -lt $LINES ]
	then
		cat $tmp
	else
		cat &tmp | less
	fi

	rm $tmp
}

function group_search
{
	echo "тестовый поиск групп"
	read a

	tmp=`mktemp usersXXX`

	grep [^:]*"$a"[^:]*:.* /etc/group |
	while IFS=: read name x gid group_list
	do
		echo "name = $name"
		echo "gid = $gid"
		echo "Users list: $group_list"
		echo
	done >$tmp 

	line_count=`wc -l $tmp | cut -d' ' -f1`

	if [ $line_count -eq '0' ]
	then
	  echo "Пользователи не найдены."
	elif [ $line_count -lt $LINES ]
	then
		cat $tmp
	else
		cat $tmp | less
	fi


	rm $tmp
}


