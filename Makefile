C = gcc
CFLAGS = -g -fno-stack-protector -z noexecstack

all: retlib

retlib: retlib.c
	$(CC) -DBUF_SIZE=64 $(CFLAGS) -o retlib retlib.c
	sudo chown root retlib
	sudo chmod 4755 retlib
