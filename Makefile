CC = gcc
CFLAGS = -g -fno-stack-protector -z noexecstack

all: setup shLoc exploit retlib

setup:
	sudo sysctl -w kernel.randomize_va_space=0
	sudo ln -sf /bin/zsh /bin/sh
shLoc: findLoc.c
	$(CC) -o shLoc findLoc.c
exploit: exploit.c
	$(CC) -o exploit exploit.c
	
retlib: retlib.c
	$(CC) -DBUF_SIZE=64 $(CFLAGS) -o retlib retlib.c
	sudo chown root retlib
	sudo chmod 4755 retlib

clear: rm shLoc exploit retlib
