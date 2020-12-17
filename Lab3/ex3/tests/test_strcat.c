#include <stdio.h>

extern char *strcat(char *dest, const char *src);

int main(int argc, char *argv[]) 
{
    char str1[100] = "Indlovu: ";

    strcat(str1, argv[1]);

    printf("New string is: %s\n", str1);
    return 0;
}