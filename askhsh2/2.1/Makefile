CC=gcc
CFLAGS=-Wall -g -c

all: ask2.1-2017.o ask2.1-2017-function.o ask2.1

ask2.1-2017.o: ask2.1-2017.s
	$(CC) $(CFLAGS) $< -o $@

ask2.1-2017-function.o: ask2.1-2017-function.s
	$(CC) $(CFLAGS) $< -o $@
	
ask2.1: ask2.1-2017.o ask2.1-2017-function.o
	$(CC) $^ -o $@

clean:
	rm *.o

distclean:
	rm ask2.1
