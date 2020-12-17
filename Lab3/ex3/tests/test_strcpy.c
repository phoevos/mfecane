#include <stdio.h>

extern char *strcpy(char *dest, const char *src);

int main(int argc, char *argv[]) 
{
    char str2[100];

    strcpy(str2, argv[1]);

    printf("New string is: %s\n", str2);
    return 0;
}
