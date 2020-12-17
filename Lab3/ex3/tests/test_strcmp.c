#include <stdio.h>

extern int strcmp(const char *s1, const char *s2);

int main(int argc, char *argv[]) 
{
    int result;
    
    result = strcmp(argv[1], argv[2]);
    printf("String 1 - String 2: %d\n", result);

    result = strcmp(argv[2], argv[1]);
    printf("String 2 - String 1: %d\n", result);

    result = strcmp(argv[1], argv[3]);
    printf("String 1 - String 3: %d\n", result);

    return 0;
}