C = gcc
CFLAGS = -g -fno-stack-protector -z noexecstack

all: attack

attack: source1.c
	$(CC) $(CFLAGS) -o attack stack.c 
