#!/bin/bash

# Проверка на наличие второго аргумента в первом.
# ИЛИ проверка на наличие первого аргумента в stdin.
function contains
{
	if [ -n "$2" ]
	# Если второй аргумент не пустой.
	then
		if [[ $1 =~ (^|[[:space:]])$2($|[[:space:]]) ]]
		then
			return 0
		else
			return 1
		fi
	# Второй аргумент не задан, читаем из stdin.
	else
		while read line
		do
			if [[ $line =~ (^|[[:space:]])$1($|[[:space:]]) ]]
			then
				return 0
			fi
		done
		return 1
	fi
}
