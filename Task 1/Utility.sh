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
			echo "$c. ${a[1]}";
		fi;
	done < lab_testing
	
	#если хотите проверить, правильно ли записан массив:
	#for i in ${users[@]}; do echo " $i";done;
	
        #удаляем промежуточный файл lab_testing
	rm -f lab_testing

        #записываем номера заблокированных пользователей в locked
        #разблокированных в unlocked
        n1=0;
        n2=0;
        c=0;
        for i in ${users[@]}; do
                flag=2;
                cat /etc/shadow | grep "$i"|sed 's/:/ /g' > new;
                read s < new;
                rm -f new;
                let k=0
                while [ $k -lt 15 ]; do
                           (( k++ ));
                           if [ "${s:$k:1}" == "!" ]; then
                               flag=1;
                           fi;
                done
                if [ "$flag" -eq 1 ]; then
                           # пользователь заблокирован
                           let c+=1
                           ((n1++))
                           locked[$n1]=$c
                fi
                if [ "$flag" -eq 2 ]; then
                           # пользователь разблокирован
                           let c+=1
                           ((n2++))
                           unlocked[$n2]=$c
                fi
        done

        #вывод заблокированных пользователей
        echo "из них заблокированы:"
        for i in ${locked[@]}; do
                echo "$i. ${users[$i]}";
        done

        #вывод заблокированных пользователей
        echo "разблокированные пользователи:"
        for i in ${unlocked[@]}; do
                echo "$i. ${users[$i]}";
        done
}
