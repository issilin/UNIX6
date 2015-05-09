#!/bin/bash
flag=0
rootList=`find -L $1 -maxdepth 10 -ls 2>/dev/null | awk '{print $1,$11}'`
for object in $rootList
do
	if [ $flag -eq 0 ];then
		inode=$object
		flag=1 
		if [ "${inodes[$inode]}" = "" ]; then
			inodes[$inode]=1
		else
			let "inodes[$inode]=${inodes[$inode]} + 1"
		fi
	else
		filename[$inode]=$object
		flag=0
	fi
done

for i in "${!inodes[@]}"
do
  echo "${filename[$i]} ----- Ссылок: ${inodes[$i]}"
done

# Вариант программы которая выводит количество ссылок в системе
# eval find $1 -ls 2>/dev/null | awk '{print $11,$4}'