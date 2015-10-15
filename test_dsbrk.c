#include"types.h"
#include"user.h"
#define SIZE 10000
int main()
{
	int i,t1,t2,dsbrk_alloc_t,dsbrk_write_t,sbrk_alloc_t,sbrk_write_t;
	int *addr=(int*)sbrk(40960);
	t1=uptime();
	for (i=0;i<SIZE;i++)
		*(addr+i)=dsbrk(4096);
	t2=uptime();
	dsbrk_alloc_t=t2-t1;
	t1=uptime();
	for (i=0;i<SIZE;i++)
		*((int*)addr[i])=i;
	t2=uptime();
	dsbrk_write_t=t2-t1;
	printf(1,"Allocation time of dsbrk is %d and write time for dsbrk is %d\n",dsbrk_alloc_t,dsbrk_write_t);
	t1=uptime();
	for (i=0;i<SIZE;i++)
		*(addr+i)=(int)sbrk(4096);
	t2=uptime();
	sbrk_alloc_t=t2-t1;
	t1=uptime();
	for (i=0;i<SIZE;i++)
		*((int*)addr[i])=i;
	t2=uptime();
	sbrk_write_t=t2-t1;
	printf(1,"Allocation time of sbrk is %d and write time for sbrk is %d\n",sbrk_alloc_t,sbrk_write_t);
	exit();
}
