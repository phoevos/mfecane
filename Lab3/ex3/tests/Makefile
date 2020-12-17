CC = gcc
CFLAGS = -Wall -g
OBJ = strcmp.o strcpy.o strcat.o strlen.o
ASS = ../strcmp.s ../strcpy.s ../strcat.s ../strlen.s

all: test_strcmp test_strcpy test_strcat test_strlen

%.o: $(ASS).s
	$(CC) -c $< $(CFLAGS)

test_strcmp.o: test_strcmp.c
	$(CC) -c -o $@ $^ $(CFLAGS)

test_strcmp: test_strcmp.o strcmp.o
	$(CC) -o $@ $^

test_strcpy.o: test_strcpy.c
	$(CC) -c -o $@ $^ $(CFLAGS)

test_strcpy: test_strcpy.o strcpy.o
	$(CC) -o $@ $^

test_strcat.o: test_strcat.c
	$(CC) -c -o $@ $^ $(CFLAGS)

test_strcat: test_strcat.o strcat.o
	$(CC) -o $@ $^

test_strlen.o: test_strlen.c
	$(CC) -c -o $@ $^ $(CFLAGS)

test_strlen: test_strlen.o strlen.o
	$(CC) -o $@ $^

clean:
	rm -f *.o *.out