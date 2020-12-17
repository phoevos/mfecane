#include <stdio.h>

extern size_t strlen(const char *s);

int main(int argc, char *argv[]) 
{
    printf("Length of the string is: %d\n", strlen(argv[1]));
    return 0;
}