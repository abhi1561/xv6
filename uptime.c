#include"types.h"
#include"user.h"

//int (*old_func)(void);
//int (*f)(void);
//int myuptime(void);

int main(void)
{
	printf(1,"Uptime value is %d\n",uptime());
//	if(!sysreplace(14,(int)myuptime,(int)&old_func))
//	f=(void*)old_func;
//		printf(1,"Address of uptime is %x",(old_func));
//	printf(1,"Value of uptime is now %d\n",uptime());
	exit();
}

//int myuptime(void) 
//{
//	return(old_func()+50000);
//}
