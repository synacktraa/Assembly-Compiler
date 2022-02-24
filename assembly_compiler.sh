#!/bin/bash

path=$(pwd)
file=$1
dir=${file%/*}
file=${file##*/}

if [ "$dir" == "$file" ];
then
	path=$path
else
	path="$path/$dir"
fi
if [ -f "$path/$file" ]; 
then   
	if [[ $1 =~ .*\.(asm|so) ]]; 
	then
		dir_name=$path
		base_name=$file
	else
		echo "Invalid file type!" 
		exit 1
	fi
else
	echo "File not found!"
	exit 1		
fi

filename="${base_name%.*}"
extension="${base_name##*.}"

assembly_lst="$path/$filename.lst"
assembly_exec="$path/$filename"
assembly_obj="$path/$filename.o"

yasm -g dwarf2 -f elf64 $base_name -l $assembly_lst
ld -g -o $assembly_exec $assembly_obj

