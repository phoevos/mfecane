CC = gcc
CFLAGS = -Wall  -g

guest: guest.s
	$(CC) $(CFLAGS) guest.s -o guest

clean:
	rm -f guest
