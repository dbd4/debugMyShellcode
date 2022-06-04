# debugMyShellcode

```
			+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
			|d|e|b|u|g|M|y|S|h|e|l|l|c|o|d|e|
			+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      
```

## Description

Set of easy to use and fast tools to test or debug your shellcode. It includes 2 tools:

* [**testMyShellcode/testMyShellcode_noNX**](testMyShellcode.c): To run your shellcode fast.
* [**debugMyShellcode.sh**](debugMyShellcode.sh): To debug your shellcode fast.

## Usage 

* [**testMyShellcode/testMyShellcode_noNX**](testMyShellcode.c)
  Just run ```testMyShellcode <file>``` or enter your shellcode as input in stdin (E.g. as a pipe) ```cat shellcode | testMyShellcode```. You can also use the no NX version just by typing "testMyShellcode_noNX" instead of "testMyShellcode".
  
* [**debugMyShellcode.sh**](debugMyShellcode.sh)
  Put your shellcode in bytes in "payload" and run ```debugMyShellcode.sh``` or use any of the other options:
  ```
  ----------------------------------------
  usage: ./debugMyShellcode.sh [-h] [-nNX] [-f <file>]
  ----------------------------------------
  -h, --help	Shows this help message
  -nNX	  	  Uses the noNX binary. Use this if your shellcode
  		        calls or jumps to the stack
  -f <file>	  Uses the file specified as the shellcode to input
  	      	  (the default file is "./payload")
  --pwn		    Tries to use pwndbg instead of defined hooks. This
	      	    option will use "init-pwndbg" so make sure you have
	      	    set it up correctly in "~/.gdbinit"
  ```
