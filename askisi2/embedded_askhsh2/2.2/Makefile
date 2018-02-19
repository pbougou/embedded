CC=gcc
CFLAGS=-Wall -g -c

all: ask2.2-2017.o ask2.2-2017-function.o ask2.2

ask2.2-2017.o: ask2.2-2017.s
	$(CC) $(CFLAGS) $< -o $@

ask2.2-2017-function.o: ask2.2-2017-function.s
	$(CC) $(CFLAGS) $< -o $@
	
ask2.2: ask2.2-2017.o ask2.2-2017-function.o
	$(CC) $^ -o $@ 
