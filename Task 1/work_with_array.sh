#!/bin/bash
cut -d: -f1,3 /etc/passwd|sed 's/:/ /g' > lab_testing
c=0;
while read line; do
	let b=0;
	for i in $line; do
		let b+=1;
		a[$b]=$i;
	done;
	if [ "${a[2]}" -ge "1000" ]; then
		let c+=1; user[$c]=${a[1]};
		echo "$c. ${a[1]}";
	fi;
done < lab_testing

#если хотите проверить, правильно ли записан массив:
#for i in ${user[@]}; do echo " $i";done;


	
