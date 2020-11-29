all: phods_initial phods_opt phods_B phods_rect 

phods_initial: phods_initial.c
	gcc -O0 -o phods_initial phods_initial.c

phods_opt: phods_opt.c
	gcc -O0 -o phods_opt phods_opt.c

phods_rect: phods_rect.c
	gcc -O0 -o phods_rect phods_rect.c

phods_B: phods_B.c
	gcc -O0 -o phods_B phods_B.c

clean:
	rm -f phods_initial phods_opt phods_B phods_rect
