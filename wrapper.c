#include"types.h"
#include"user.h"

typedef void(*sighandler_t)(void);
void sig_wrapper(int f_ptr)
{
	asm("push %eax");
	asm("push %ecx");
	asm("push %edx");
	sighandler_t f= (sighandler_t)f_ptr;
//	printf(1,"\nValue of eip before f is: 0x%x and function is: 0x%x which printed directly gives: 0x%x\n",*(((int*)&f_ptr)-1),*((int*)&f_ptr),(uint)f_ptr);
	f();
//	printf(1,"\nValue of eip after f is: 0x%x\n",*(((int*)&f_ptr)-1));
	*((int*)&f_ptr)=*(((int*)&f_ptr)-1);
	*(((int*)&f_ptr)-1)=*(((int*)&f_ptr)-2);
	asm("pop %edx");
	asm("pop %ecx");
	asm("pop %eax");
	asm("addl $4,%ebp");
}
