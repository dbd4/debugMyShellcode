#!/bin/bash
echo -e "\033[0;32m"
echo -e "\t\t\t+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+"
echo -e "\t\t\t|d|e|b|u|g|M|y|S|h|e|l|l|c|o|d|e|"
echo -e "\t\t\t+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+"
echo -e "\033[0m"
if [[ $* = *-h* ]]||[[ $* = *--help* ]];then
	echo -e "This script will execute the testMyShellcode binary with the shellcode contained"
	echo -e "in the file \"payload\" and start a gdb instance to debug your shellcode"
	echo "----------------------------------------"
	echo "usage: ./debugMyShellcode.sh [-h] [-nNX] [-f <file>]"
	echo "----------------------------------------"
	echo -e "-h, --help\tShows this help message"
	echo -e "-nNX\t\tUses the noNX binary. Use this if your shellcode"
	echo -e "\t\tcalls or jumps to the stack"

	echo -e "-f <file>\tUses the file specified as the shellcode to input"
	echo -e "\t\t(the default file is \"./payload\")"

	echo -e "--pwn\t\tTries to use pwndbg instead of defined hooks. This"
	echo -e "\t\toption will use \"init-pwndbg\" so make sure you have"
	echo -e "\t\tset it up correctly in \"~/.gdbinit\""
	exit
fi

tmpf=$(mktemp --suffix=.gdb)
tester=testMyShellcode
payload_file=./payload

[[ $* = *-nNX* ]] && tester=testMyShellcode_noNX

if [[ $* = *-f* ]]; then
	file=$(echo $* | sed 's/.*-f //' | sed 's/\s.*//')
	if [ -f "$file" ]; then
		payload_file=$file
	else
		echo "[ERROR]: \"$file\" is not a file"
		exit
	fi
fi

echo "set disassembly-flavor intel
set prompt \033[0;40m[\033[35mdebugMyShellcode\033[0;40m]>\033[0m 
file $tester
b *main+149
r < $payload_file
" > $tmpf
if [[ $* = *--pwn* ]]; then
	echo "init-pwndbg
	si" >> $tmpf
else
	echo "define hook-stop
	 printf \"\n\t\t\t\e[4;31m          REGISTERS          \e[0m\n\n\e[1;33m\"
	 i r rax rbx rcx rdx rdi rsi r8 r9 r10 r11 r12 r13 r14 r15 rbp rsp rip
	 printf \"\e[0m\n\t\t\t\e[4;31m       NEXT INSTRUCTION      \e[0m\n\n\"
	 x/15i \$pc
	 printf \"\n\t\t\t\e[4;31m            STACK            \e[0m\n\n\"
	 x/16wx \$sp
	 printf \"\n\"
	end
	si" >> $tmpf
fi

gdb -q -x $tmpf