#!/bin/bash

#function acting_users
#{
	cut -d: -f1,3 /etc/passwd|sed 's/:/ /g' > lab_testing
	
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
	
	rm -f lab_testing
#}

#function lock_user
#{
        echo "Введите имя пользователя, которого хотите заблокировать."
	read user_name
        flag="0"
        #flag=0 - пользователя нет
        #flag=1 - пользователь есть и уже заблокирован
        #flag=2 - пользователь есть и не заблокирован 
        for i in ${users[@]}; do 
               if [ "$user_name" == "$i"  -a "$flag" -eq 0 ]; then
                      flag=2;
                      cat /etc/shadow | grep "$user_name"|sed 's/:/ /g' > new;
                      read s < new;
                      rm -f new;
                      let k=0
                      while [ $k -lt 15 ]; do 
                           (( k++ ));
                           
                           if [ "${s:$k:1}" == "!" ]; then
                               flag=1;
                           fi;                                
                      done;
                fi;
        done
        if [ "$flag" -eq 0 ]; then           
              echo "нет такого пользователя";
        fi;
        if [ "$flag" -eq 1 ]; then           
              echo "пользователь уже заблокирован";
        fi;
        if [ "$flag" -eq 2 ]; then                         
              echo "блокируем пользователя";
              #usermod -L "$user_name";
              echo "Успешно";
        fi;
#}

#function unlock_user
#{
        echo "Введите имя пользователя, которого хотите разблокировать."
	read user_name
        flag="0"
        #flag=0 - пользователя нет
        #flag=1 - пользователь есть и заблокирован
        #flag=2 - пользователь есть и не заблокирован 
        for i in ${users[@]}; do 
               if [ "$user_name" == "$i"  -a "$flag" -eq 0 ]; then
                      flag=2;
                      cat /etc/shadow | grep "$user_name"|sed 's/:/ /g' > new;
                      read s < new;
                      rm -f new;
                      let k=0
                      while [ $k -lt 15 ]; do 
                           (( k++ ));
                           
                           if [ "${s:$k:1}" == "!" ]; then
                               flag=1;
                           fi;                                
                      done;
                fi;
        done
        if [ "$flag" -eq 0 ]; then           
              echo "нет такого пользователя";
        fi;
        if [ "$flag" -eq 2 ]; then           
              echo "пользователь незаблокирован";
        fi;
        if [ "$flag" -eq 1 ]; then                         
              echo "разблокируем пользователя";
              #usermod -U "$user_name";
              echo "Успешно";
        fi;
#}

                      
                      




