CC = gcc
CFLAGS = -g -fno-stack-protector -z noexecstack

all: attackDASH

attackZSH: offASLR onZSH shLoc exploit retlib

attackDASH: offASLR retlibROP

offASLR:
	sudo sysctl -w kernel.randomize_va_space=0
onZSH:
	sudo ln -sf /bin/zsh /bin/sh
shLoc: findLoc.c
	$(CC) -o shLoc findLoc.c
exploit: exploit.c
	$(CC) -o exploit exploit.c
	
exploitROP: exploitR.c
	$(CC) -o exploitR exploitR.c
retlib: retlib.c
	$(CC) -DBUF_SIZE=64 $(CFLAGS) -o retlib retlib.c
	sudo chown root retlib
	sudo chmod 4755 retlib
retlibROP: retlibR.c
	$(CC) -DBUF_SIZE=64 $(CFLAGS) -o retlibR retlibR.c
	sudo chown root retlibR
	sudo chmod 4755 retlibR

clear: rm shLoc exploit retlib
