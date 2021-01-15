#include <linux/kernel.h>

asmlinkage long sys_hello(void)
{	
	int num=22;
        printk("Greeting from kernel and team no %d\n", num);
        return 0;
}
