#!/bin/bash

. Utility.sh

function change_password
{
	acting_users > /dev/null 2>&1
	# Теперь в users список пользователей.
	#for i in ${users[@]}; do echo " $i";done;
	for ((i=1; i<=${#users[@]}; ++i))
	do
		echo $i "${users[i]}"
	done
	
	echo "Введите имя пользователя или его порядковый номер."
	read reply
	
	# Распознание порядкового номера.
	if [[ "$reply" =~ ^[0-9]+$ ]] && (( reply >= 1 && reply <= ${#users[@]} ))
	then
		user=${users[reply]}
	elif [[ "$reply" =~ ^[0-9]+$ ]]
	then
		echo "Введен неправильный порядковый номер." >&2
		return 1
	else
		user="$reply"
	fi
	
	passwd "$user"
	return $?
}

change_password $*
