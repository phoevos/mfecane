all: dijkstra_initial dijkstra_ddtr

dijkstra_initial: dijkstra_initial.c
	gcc dijkstra_initial.c -o dijkstra_initial -pthread -lcdsl -L./../synch_implementations -I./../synch_implementations

dijkstra_ddtr: dijkstra_ddtr.c
	gcc dijkstra_ddtr.c -o dijkstra_ddtr -pthread -lcdsl -L./../synch_implementations -I./../synch_implementations

clean:
	rm -f dijkstra_ddtr dijkstra_initial