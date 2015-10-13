#include"types.h"
#include"user.h"
#include"wrapper.c"

//typedef void (*sighandler_t) (void);
int sig_handler(void);

int main()
{
	int a;
	int *ptr;
	
	if(!signal(-1,(sighandler_t)sig_wrapper))
		printf(1,"Signal wrapper system call worked\n");
	if(!signal(0,(sighandler_t)sig_handler))
		printf(1,"Signal system call worked\n");
	ptr=&a;
	ptr+=10000;
	*ptr=5;
	printf(1,"\nBack in main\n");

	exit();
}

int sig_handler(void)
{
	int a;
	printf(1,"In sigsegv handler\n");
	int *ptr=&a;
//	for (a=0;a<25;a++)
		printf(1,"value at ptr:0x%x\n",*(ptr+16));
	*(ptr+16)+=6;
		printf(1,"value at ptr:0x%x\n",*(ptr+16));
//	sleep(100);
	return 0;
}


