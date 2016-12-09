#!/bin/bash

#функция, которая записывает действительных полоьзователей в массив,
#выводит на их экран, а также показывает, кто заюдокирован, а кто - нет. 
function acting_users
{
        #считываем всех пользователей из /etc/passwd (1 и 3 столбцы), вместо двоеточия ставим пробелы, записываем в  lab_testing
	cut -d: -f1,3 /etc/passwd|sed 's/:/ /g' > lab_testing
	
        #записываем в массив пользователей, чей ID>1000
        echo "доступные пользователи:"
	c=0;
	while read line; do
		let b=0;
		for i in $line; do
			let b+=1;
			a[$b]=$i;
		done;
		if [ "${a[2]}" -ge "1000" ]; then
			let c+=1; users[$c]=${a[1]};
			#echo "$c. ${a[1]}";
		fi;
	done < lab_testing
	
	#если хотите проверить, правильно ли записан массив:
	#for i in ${users[@]}; do echo " $i";done;
	
        #удаляем промежуточный файл lab_testing
	rm -f lab_testing
}
