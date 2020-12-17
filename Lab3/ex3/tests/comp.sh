#!/bin/bash

# ffs I can't get the Makefile to work, use this to compile tests.
# or fix the Makefile and pls let me know or sth

gcc -Wall -c ../strlen.s
gcc -Wall -c ../strcpy.s
gcc -Wall -c ../strcmp.s
gcc -Wall -c ../strcat.s

gcc -Wall -c test_strlen.c
gcc -Wall test_strlen.o strlen.o -o len.out

gcc -Wall -c test_strcpy.c
gcc -Wall test_strcpy.o strcpy.o -o cpy.out

gcc -Wall -c test_strcmp.c
gcc -Wall test_strcmp.o strcmp.o -o cmp.out

gcc -Wall -c test_strcat.c
gcc -Wall test_strcat.o strcat.o -o cat.out

rm -f *.o
