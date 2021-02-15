CC = gcc
CFLAGS = -g -fno-stack-protector -z noexecstack

all: attackDASH

attackZSH: offASLR onZSH shLoc exploit retlib

attackDASH: offASLR exploitROP retlibROP

offASLR:
	sudo sysctl -w kernel.randomize_va_space=0
onZSH:
	sudo ln -sf /bin/zsh /bin/sh
shLoc: findLoc.c
	$(CC) -o shLoc findLoc.c
exploit: exploit.c
	$(CC) -o exploit exploit.c
	
exploitROP: exploitROP.c
	$(CC) -o exploitROP exploitROP.c
retlib: retlib.c
	$(CC) -DBUF_SIZE=64 $(CFLAGS) -o retlib retlib.c
	sudo chown root retlib
	sudo chmod 4755 retlib
retlibROP: retlibROP.c
	$(CC) -DBUF_SIZE=64 $(CFLAGS) -o retlibROP retlibROP.c
	sudo chown root retlibROP
	sudo chmod 4755 retlibROP

clear: rm shLoc exploit retlib
