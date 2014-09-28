#include"types.h"
#include"user.h"
#include"fcntl.h"

int main()
{
	int pid;
	pid=fork();
	if(pid==0)
	{
		int fd;
		while(1)
		{
			fd=open("badproc.out", O_CREATE|O_RDWR);
			printf(fd,"%d\n",uptime());
			close(fd);
  			sleep(100);
		}
	}
	exit();
}
