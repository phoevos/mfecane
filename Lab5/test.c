#include <unistd.h>
#include <sys/syscall.h>
#include <stdio.h>

#define SYS_hello 386

int main(void) {
    printf("Invoking hello system call.\n");
    long ret = syscall(SYS_hello);
    printf("Syscall returned %ld.\n", ret);
    return 0;
}
