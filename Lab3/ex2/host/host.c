#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <termios.h>
#include <stdio.h>

#define BUFF_SIZE 66
int main(int argc, char **argv)
{
    int fd, len;
    char input[BUFF_SIZE], output[BUFF_SIZE];
    ssize_t rcnt;
    struct termios config;

    if (argc != 2) {
  		fprintf(stderr, "Usage: ./host device\n \tdevice: serial port destination (example: /dev/pts/7)\n");
  		exit(1);
  	}

    printf("Please give a string to send to guest:\n");
    rcnt = read(0, input, BUFF_SIZE);
    if (rcnt<0){
      perror("read");
  		exit(1);
    }
    len = rcnt;
    if (len == 66) {
  		fprintf(stderr, "Host: string is more than 64 bytes!\n");
      fflush(0);
  		exit(1);
  	}
    else
      printf("Host: string is %d bytes. Valid!\n", len);


    fd = open(argv[1], O_RDWR | O_NOCTTY);

    if (fd == -1) {
        printf("Failed to open port\n");
        return 1;
    }

    if(tcgetattr(fd, &config) < 0) {
        printf("Couldn't get the data from the terminal\n");
        return 1;
    }

    config.c_lflag = 0;
    config.c_lflag |= ICANON; /* Make port canonical */
    config.c_cflag |= (CLOCAL | CREAD | CS8);
    config.c_cflag &= ~CSTOPB;
    config.c_cc[VMIN] = 1; /* bogus */
    config.c_cc[VTIME] = 0; /* bogus */


   /* Set baud speed */
    if(cfsetispeed(&config, B9600) < 0 || cfsetospeed(&config, B9600) < 0) {
        printf("Problem with baudrate\n");
        return 1;
    }

    /* Finally, apply the configuration */
    if(tcsetattr(fd, TCSANOW, &config) < 0) {
        printf("Couldn't apply settings\n");
        return 1;
    }

    tcflush(fd, TCIOFLUSH); /* Clear everything that is in the terminal*/

    printf("Sending to guest...\n");

    write(fd, input, BUFF_SIZE);

    printf("Reading from guest...\n");

    read(fd, output, BUFF_SIZE);

    int i, final;

    final = output[2];

    final=final-'0';


    if(final!=0)
      printf("The most frequent character is %c and it appeared %d times.\n", output[0], final);
    else
      printf("No characters were given\n");

    close(fd);
    return 0;
}
