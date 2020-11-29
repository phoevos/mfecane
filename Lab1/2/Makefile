all: tables_initial tables_exhaustive tables_random tables_simplex

tables_initial: tables_initial.c
	gcc -O0 -o tables_initial tables_initial.c

tables_exhaustive: tables_exhaustive.c
	gcc -O0 -o tables_exhaustive tables_exhaustive.c

tables_random: tables_random.c
	gcc -O0 -o tables_random tables_random.c

tables_simplex: tables_simplex.c
	gcc -O0 -o tables_simplex tables_simplex.c

clean:
	rm -f tables_initial tables_exhaustive tables_random tables_simplex
