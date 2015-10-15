#include "types.h"
#include "x86.h"
#include "defs.h"
#include "date.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
  return fork();
}

int
sys_exit(void)
{
  exit();
  return 0;  // not reached
}

int
sys_wait(void)
{
  return wait();
}

int
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
  return kill(pid);
}

int
sys_getpid(void)
{
  return proc->pid;
}

int
sys_sbrk(void)
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = proc->sz;
  if(growproc(n) < 0)
    return -1;
  return addr;
}

int
sys_dsbrk(void)
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = proc->sz;
  proc->sz+=n;
  proc->heap_pages++;
  return addr;
}




int
sys_sleep(void)
{
  int n;
  uint ticks0;
  
  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
    if(proc->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
  uint xticks;
  
  acquire(&tickslock);
  xticks = ticks;
  release(&tickslock);
  return xticks;
}

int sys_getproc(void)
{
        int sadd;

        if(argint(0, &sadd) < 0)
                return -1;
        return(getproc(sadd));
}

int
strcmp(const char *p, const char *q)
{
        while(*p && *p == *q)
        p++, q++;
        return (uchar)*p - (uchar)*q;
}

int mygetproc(int sadd)
{
        int i,no,num;
        struct procentry
        {
                int id;
                char state[10];
                char name[16];
        } *p;
        p= (struct procentry*)sadd;
        no=getproc(sadd);
        num=no;
        for (i=0;i<no;i++)
        {
                if (!strcmp(p->name,"badproc"))
                {
                        *p=*(p+(no-1));
                        num--;
                }
        p++;
        }
        return num;
}

int sys_mygetproc(void)
{
	int sadd;

        if(argint(0, &sadd) < 0)
                return -1;
        return(mygetproc(sadd));
}

int sys_findkalloc(void)
{
//	char* kalloc_addr(void)=kalloc;
	return((int)kalloc);
}

int sys_signal(void)
{
	int num,handler;
	if(argint(0,&num)<0)
		return -1;
	if(argint(1,&handler)<0)
		return -1;
	return(signal(num,(sighandler_t)handler));
}

int sys_alarm(void)
{
	int val;
	if(argint(0,&val)<0)
		return -1;
	return(alarm(val));
}

int sys_mprot(void)
{
	int addr,len,prot;
	if(argint(0,&addr)<0)
		return -1;
	if(argint(1,&len)<0)
		return -1;
	if(argint(2,&prot)<0)
		return -1;
	return(mprot((void*)addr,len,prot));

}
