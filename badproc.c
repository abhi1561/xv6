#include"types.h"
#include"user.h"


int main()
{
	int pid;
	pid=fork();
	if(pid==0)
	{
   		while(1)
  		sleep(1000);
	}
	exit();
}
