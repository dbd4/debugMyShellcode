#!/bin/bash

directory=$(pwd)
gcc testMyShellcode.c -o testMyShellcode
gcc testMyShellcode.c -fno-stack-protector -o testMyShellcode_noNX
echo "Do you want to include the debugMyShellcode directory to your path?"
echo -e "\tWARNING!: This will change the PATH environment variable using the ~/.bashrc file so"
echo -en "\tthat you can use the tools included in the directory from anywhere in your system. [Y/n]: "
read option
if [[ $option = [yY] ]]; then
	echo -ne "\nIs $directory the correct debugMyShellcode directory? [Y/n]: "
	read correct
	if ! [[ $correct = [yY] ]]; then
		echo -n "Input the correct directory: "
		read directory
		if ! [ -d "$directory" ]; then
			echo "[ERROR]: \"$directory\" is not a directory"
			exit
		fi
	fi
	echo -ne "\nexport PATH=\$PATH:$directory # So that you can use the debugMyShellcode tools from anywhere" >> ~/.bashrc
fi
bash