#!/bin/bash

# Повторяет переданную аргументом команду до тех пор,
# пока пользователь не захочет прервать.
function repeat
{
  while :
  do
    # Выполнение команды.
    $*

    # Спрашивает пользователя, желает ли он выполнить заново.
    echo "Повторить? (Y/n)"
    read answer

    case "$answer" in
      y|Y)
        continue ;;
      n|N)
        return 0 ;;
      *)
        echo "Ответ не распознан. Считается, что да." ;;
    esac

  done
}


# Данная функция создает меню.
# Аргументами являются последовательно пункты меню и команды, которые нужно выполнить.
# Ключ --title= задает имя меню (выводится в начале).
# Ключ --quit= задает описание для выхода из меню.
# Ключ --help= задает справочную информацию для данного меню.
# Пример:
# $menu --title="Red and Blue menu" --quit="Color everything in black" --help="Print!" Red "echo Red chosen" Blue "echo Blue chosen"
function menu
{

	local item_number=1	# Число пунктов меню.
	local func_number=1	# Число функций меню. Должно совпадать с предыдущим.
	local quit='В предыдущее меню.'	# Стандартная надпись для выхода из этого меню. Может быть изменена.

	# Массив items содержит пункты меню.
	declare -a items
	# Массив funcs содержит функции, которые надо вызывать при выборе соответствующего пункта.
	declare -a funcs


	# Чтение аргументов.

	# Последовательно рассматривается каждый аргумент.
	for arg;
	do
		# Ключ --title задает заглавие меню.
		if [[ "$arg" = --title=* ]]
		then
			title=${arg:8}

		# Ключ --quit задает надпись выхода из этого меню.
		elif [[ "$arg" = --quit=* ]]
		then
			quit=${arg:7}

		# Ключ --help задает то, что будет выведено при вводе help.
		elif [[ "$arg" = --help=* ]]
		then
			help_info=${arg:7}

		# Если пунктов и функций одинаковое число, значит следующий аргумент - пункт меню.
		elif [ $item_number -eq $func_number ]
		then
			items[$item_number]="$arg"
			let item_number+=1

		# В противном случае следующий аргумент - функция для предыдущего пункта.
		else
			funcs[$func_number]="$arg"
			let func_number+=1
		fi
	done


	# Если число пунктов и функций не совпало - значит были переданы неправильные аргументы.
	if [ $item_number -ne $func_number ]
	then
		echo "Ошибка! Последний пункт меню остался без команды." >&2
		return 1
	fi


	# Основной цикл меню.
	while :
	do
		# Вывод меню.

		# Вывод заглавия.
		echo $title
		echo
		
		# Вывод пунктов меню.
		for ((i=1; i-item_number; i++))
		do
			printf '%i. %s\n' $i "${items[i]}"
		done
		printf 'q. %s\n\n' "$quit"

		# Вывод уведомления о том, что в данном меню можно воспользовать help'ом.
		echo "Вы можете ввести help для получения справочной информации о данном меню."
		echo

		# Обработка ответа пользователя.
		while :
		do
			read answer

			# Проверка на выход.
			if [ "$answer" = q ]
			then
				return 0

			# Проверка на справочную информацию.
			elif [ "$answer" = "help" ]
			then
				echo "$help_info"
				echo

			# Проверка на корректный номер пункта.
			elif [[ $answer =~ ^[0-9]+$ ]] && (( answer >= 1 && answer < item_number ))
			then
				echo
				${funcs[answer]}
				echo
				break

			# В противном случае пользователь ввел какую-то абракадабру.
			else
				echo "Не удалось распознать выбор. Введите номер нужного пункта меню, q для выхода из этого меню или help для получения справочной информации."
			fi
		done
	done
}
