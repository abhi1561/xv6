#include"types.h"
#include"user.h"
#include"wrapper.c"

//typedef void (*sighandler_t) (void);
int sig_handler(void);

int main()
{
	int i;
	if(!signal(-1,(sighandler_t)sig_wrapper))
		printf(1,"Signal wrapper system call worked\n");
	if(!signal(1,(sighandler_t)sig_handler))
		printf(1,"Signal system call worked\n");
	alarm(1);
        for(i=0;i<5000000;i++);
	printf(1,"\nExiting main\n");

	exit();
}

int sig_handler(void)
{
	printf(1,"Timer Fired\n");	
	return 0;
}


