#!/bin/bash

# Импорт функции acting_users.
. Utility.sh

#функция блокировки/разблокировки пользователя
function lock_or_unlock_user
{
        # Нужно для получения списка существующих пользователей.
        acting_users

        echo "введите имя пользователя, которого хотите заблокировать/разблокировать ИЛИ его номер:"
	read user_name
        flag="0"
        #flag=0 - пользователя нет
        #flag=1 - пользователь есть и уже заблокирован
        #flag=2 - пользователь есть и не заблокирован

        #проверяем номер или нет, если номер, то меняем user_name на имя
        while [ "$c" -ge "0" ]; do
               if [ "$c" == "$user_name" ]; then
                      user_name=${users[$c]};
               fi;        
               ((c--))
        done

        #проверка наличия в массиве users и также состояния раблок/заблок
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

        #если пользователь есть, то произойдет одно из трех действий
        if [ "$flag" -eq 0 ]; then           
              echo "нет такого пользователя";
        fi;
        if [ "$flag" -eq 1 ]; then           
              echo "разблокируем пользователя";
              #usermod -U "$user_name";
              echo "Успешно";
        fi;
        if [ "$flag" -eq 2 ]; then                         
              echo "блокируем пользователя";
              #usermod -L "$user_name";
              echo "Успешно";
        fi;
}
