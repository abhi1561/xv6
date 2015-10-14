
_test_sigsegv:     file format elf32-i386


Disassembly of section .text:

00000000 <sig_wrapper>:
#include"types.h"
#include"user.h"

typedef void(*sighandler_t)(void);
void sig_wrapper(int f_ptr)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 ec 18             	sub    $0x18,%esp
	asm("push %eax");
   6:	50                   	push   %eax
	asm("push %ecx");
   7:	51                   	push   %ecx
	asm("push %edx");
   8:	52                   	push   %edx
	sighandler_t f= (sighandler_t)f_ptr;
   9:	8b 45 08             	mov    0x8(%ebp),%eax
   c:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	printf(1,"\nValue of eip before f is: 0x%x and function is: 0x%x which printed directly gives: 0x%x\n",*(((int*)&f_ptr)-1),*((int*)&f_ptr),(uint)f_ptr);
	f();
   f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  12:	ff d0                	call   *%eax
//	printf(1,"\nValue of eip after f is: 0x%x\n",*(((int*)&f_ptr)-1));
	*((int*)&f_ptr)=*(((int*)&f_ptr)-1);
  14:	8b 45 04             	mov    0x4(%ebp),%eax
  17:	89 45 08             	mov    %eax,0x8(%ebp)
	*(((int*)&f_ptr)-1)=*(((int*)&f_ptr)-2);
  1a:	8d 45 04             	lea    0x4(%ebp),%eax
  1d:	8b 55 00             	mov    0x0(%ebp),%edx
  20:	89 10                	mov    %edx,(%eax)
	asm("pop %edx");
  22:	5a                   	pop    %edx
	asm("pop %ecx");
  23:	59                   	pop    %ecx
	asm("pop %eax");
  24:	58                   	pop    %eax
	asm("addl $4,%ebp");
  25:	83 c5 04             	add    $0x4,%ebp
}
  28:	c9                   	leave  
  29:	c3                   	ret    

0000002a <main>:

//typedef void (*sighandler_t) (void);
int sig_handler(void);

int main()
{
  2a:	55                   	push   %ebp
  2b:	89 e5                	mov    %esp,%ebp
  2d:	83 e4 f0             	and    $0xfffffff0,%esp
  30:	83 ec 20             	sub    $0x20,%esp
	int a;
	int *ptr;
	
	if(!signal(-1,(sighandler_t)sig_wrapper))
  33:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  3a:	00 
  3b:	c7 04 24 ff ff ff ff 	movl   $0xffffffff,(%esp)
  42:	e8 11 04 00 00       	call   458 <signal>
  47:	85 c0                	test   %eax,%eax
  49:	75 14                	jne    5f <main+0x35>
		printf(1,"Signal wrapper system call worked\n");
  4b:	c7 44 24 04 14 09 00 	movl   $0x914,0x4(%esp)
  52:	00 
  53:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  5a:	e8 e9 04 00 00       	call   548 <printf>
	if(!signal(0,(sighandler_t)sig_handler))
  5f:	c7 44 24 04 be 00 00 	movl   $0xbe,0x4(%esp)
  66:	00 
  67:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  6e:	e8 e5 03 00 00       	call   458 <signal>
  73:	85 c0                	test   %eax,%eax
  75:	75 14                	jne    8b <main+0x61>
		printf(1,"Signal system call worked\n");
  77:	c7 44 24 04 37 09 00 	movl   $0x937,0x4(%esp)
  7e:	00 
  7f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  86:	e8 bd 04 00 00       	call   548 <printf>
	ptr=&a;
  8b:	8d 44 24 18          	lea    0x18(%esp),%eax
  8f:	89 44 24 1c          	mov    %eax,0x1c(%esp)
	ptr+=10000;
  93:	81 44 24 1c 40 9c 00 	addl   $0x9c40,0x1c(%esp)
  9a:	00 
	*ptr=5;
  9b:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  9f:	c7 00 05 00 00 00    	movl   $0x5,(%eax)
	printf(1,"\nBack in main\n");
  a5:	c7 44 24 04 52 09 00 	movl   $0x952,0x4(%esp)
  ac:	00 
  ad:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  b4:	e8 8f 04 00 00       	call   548 <printf>

	exit();
  b9:	e8 e2 02 00 00       	call   3a0 <exit>

000000be <sig_handler>:
}

int sig_handler(void)
{
  be:	55                   	push   %ebp
  bf:	89 e5                	mov    %esp,%ebp
  c1:	83 ec 28             	sub    $0x28,%esp
	int a;
	printf(1,"In sigsegv handler\n");
  c4:	c7 44 24 04 61 09 00 	movl   $0x961,0x4(%esp)
  cb:	00 
  cc:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  d3:	e8 70 04 00 00       	call   548 <printf>
	int *ptr=&a;
  d8:	8d 45 f0             	lea    -0x10(%ebp),%eax
  db:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	for (a=0;a<25;a++)
		printf(1,"value at ptr:0x%x\n",*(ptr+16));
  de:	8b 45 f4             	mov    -0xc(%ebp),%eax
  e1:	83 c0 40             	add    $0x40,%eax
  e4:	8b 00                	mov    (%eax),%eax
  e6:	89 44 24 08          	mov    %eax,0x8(%esp)
  ea:	c7 44 24 04 75 09 00 	movl   $0x975,0x4(%esp)
  f1:	00 
  f2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  f9:	e8 4a 04 00 00       	call   548 <printf>
	*(ptr+16)+=6;
  fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
 101:	83 c0 40             	add    $0x40,%eax
 104:	8b 55 f4             	mov    -0xc(%ebp),%edx
 107:	83 c2 40             	add    $0x40,%edx
 10a:	8b 12                	mov    (%edx),%edx
 10c:	83 c2 06             	add    $0x6,%edx
 10f:	89 10                	mov    %edx,(%eax)
		printf(1,"value at ptr:0x%x\n",*(ptr+16));
 111:	8b 45 f4             	mov    -0xc(%ebp),%eax
 114:	83 c0 40             	add    $0x40,%eax
 117:	8b 00                	mov    (%eax),%eax
 119:	89 44 24 08          	mov    %eax,0x8(%esp)
 11d:	c7 44 24 04 75 09 00 	movl   $0x975,0x4(%esp)
 124:	00 
 125:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 12c:	e8 17 04 00 00       	call   548 <printf>
//	sleep(100);
	return 0;
 131:	b8 00 00 00 00       	mov    $0x0,%eax
}
 136:	c9                   	leave  
 137:	c3                   	ret    

00000138 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 138:	55                   	push   %ebp
 139:	89 e5                	mov    %esp,%ebp
 13b:	57                   	push   %edi
 13c:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 13d:	8b 4d 08             	mov    0x8(%ebp),%ecx
 140:	8b 55 10             	mov    0x10(%ebp),%edx
 143:	8b 45 0c             	mov    0xc(%ebp),%eax
 146:	89 cb                	mov    %ecx,%ebx
 148:	89 df                	mov    %ebx,%edi
 14a:	89 d1                	mov    %edx,%ecx
 14c:	fc                   	cld    
 14d:	f3 aa                	rep stos %al,%es:(%edi)
 14f:	89 ca                	mov    %ecx,%edx
 151:	89 fb                	mov    %edi,%ebx
 153:	89 5d 08             	mov    %ebx,0x8(%ebp)
 156:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 159:	5b                   	pop    %ebx
 15a:	5f                   	pop    %edi
 15b:	5d                   	pop    %ebp
 15c:	c3                   	ret    

0000015d <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 15d:	55                   	push   %ebp
 15e:	89 e5                	mov    %esp,%ebp
 160:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 163:	8b 45 08             	mov    0x8(%ebp),%eax
 166:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 169:	90                   	nop
 16a:	8b 45 08             	mov    0x8(%ebp),%eax
 16d:	8d 50 01             	lea    0x1(%eax),%edx
 170:	89 55 08             	mov    %edx,0x8(%ebp)
 173:	8b 55 0c             	mov    0xc(%ebp),%edx
 176:	8d 4a 01             	lea    0x1(%edx),%ecx
 179:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 17c:	0f b6 12             	movzbl (%edx),%edx
 17f:	88 10                	mov    %dl,(%eax)
 181:	0f b6 00             	movzbl (%eax),%eax
 184:	84 c0                	test   %al,%al
 186:	75 e2                	jne    16a <strcpy+0xd>
    ;
  return os;
 188:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 18b:	c9                   	leave  
 18c:	c3                   	ret    

0000018d <strcmp>:

int
strcmp(const char *p, const char *q)
{
 18d:	55                   	push   %ebp
 18e:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 190:	eb 08                	jmp    19a <strcmp+0xd>
    p++, q++;
 192:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 196:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 19a:	8b 45 08             	mov    0x8(%ebp),%eax
 19d:	0f b6 00             	movzbl (%eax),%eax
 1a0:	84 c0                	test   %al,%al
 1a2:	74 10                	je     1b4 <strcmp+0x27>
 1a4:	8b 45 08             	mov    0x8(%ebp),%eax
 1a7:	0f b6 10             	movzbl (%eax),%edx
 1aa:	8b 45 0c             	mov    0xc(%ebp),%eax
 1ad:	0f b6 00             	movzbl (%eax),%eax
 1b0:	38 c2                	cmp    %al,%dl
 1b2:	74 de                	je     192 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 1b4:	8b 45 08             	mov    0x8(%ebp),%eax
 1b7:	0f b6 00             	movzbl (%eax),%eax
 1ba:	0f b6 d0             	movzbl %al,%edx
 1bd:	8b 45 0c             	mov    0xc(%ebp),%eax
 1c0:	0f b6 00             	movzbl (%eax),%eax
 1c3:	0f b6 c0             	movzbl %al,%eax
 1c6:	29 c2                	sub    %eax,%edx
 1c8:	89 d0                	mov    %edx,%eax
}
 1ca:	5d                   	pop    %ebp
 1cb:	c3                   	ret    

000001cc <strlen>:

uint
strlen(char *s)
{
 1cc:	55                   	push   %ebp
 1cd:	89 e5                	mov    %esp,%ebp
 1cf:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 1d2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 1d9:	eb 04                	jmp    1df <strlen+0x13>
 1db:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 1df:	8b 55 fc             	mov    -0x4(%ebp),%edx
 1e2:	8b 45 08             	mov    0x8(%ebp),%eax
 1e5:	01 d0                	add    %edx,%eax
 1e7:	0f b6 00             	movzbl (%eax),%eax
 1ea:	84 c0                	test   %al,%al
 1ec:	75 ed                	jne    1db <strlen+0xf>
    ;
  return n;
 1ee:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 1f1:	c9                   	leave  
 1f2:	c3                   	ret    

000001f3 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1f3:	55                   	push   %ebp
 1f4:	89 e5                	mov    %esp,%ebp
 1f6:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 1f9:	8b 45 10             	mov    0x10(%ebp),%eax
 1fc:	89 44 24 08          	mov    %eax,0x8(%esp)
 200:	8b 45 0c             	mov    0xc(%ebp),%eax
 203:	89 44 24 04          	mov    %eax,0x4(%esp)
 207:	8b 45 08             	mov    0x8(%ebp),%eax
 20a:	89 04 24             	mov    %eax,(%esp)
 20d:	e8 26 ff ff ff       	call   138 <stosb>
  return dst;
 212:	8b 45 08             	mov    0x8(%ebp),%eax
}
 215:	c9                   	leave  
 216:	c3                   	ret    

00000217 <strchr>:

char*
strchr(const char *s, char c)
{
 217:	55                   	push   %ebp
 218:	89 e5                	mov    %esp,%ebp
 21a:	83 ec 04             	sub    $0x4,%esp
 21d:	8b 45 0c             	mov    0xc(%ebp),%eax
 220:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 223:	eb 14                	jmp    239 <strchr+0x22>
    if(*s == c)
 225:	8b 45 08             	mov    0x8(%ebp),%eax
 228:	0f b6 00             	movzbl (%eax),%eax
 22b:	3a 45 fc             	cmp    -0x4(%ebp),%al
 22e:	75 05                	jne    235 <strchr+0x1e>
      return (char*)s;
 230:	8b 45 08             	mov    0x8(%ebp),%eax
 233:	eb 13                	jmp    248 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 235:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 239:	8b 45 08             	mov    0x8(%ebp),%eax
 23c:	0f b6 00             	movzbl (%eax),%eax
 23f:	84 c0                	test   %al,%al
 241:	75 e2                	jne    225 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 243:	b8 00 00 00 00       	mov    $0x0,%eax
}
 248:	c9                   	leave  
 249:	c3                   	ret    

0000024a <gets>:

char*
gets(char *buf, int max)
{
 24a:	55                   	push   %ebp
 24b:	89 e5                	mov    %esp,%ebp
 24d:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 250:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 257:	eb 4c                	jmp    2a5 <gets+0x5b>
    cc = read(0, &c, 1);
 259:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 260:	00 
 261:	8d 45 ef             	lea    -0x11(%ebp),%eax
 264:	89 44 24 04          	mov    %eax,0x4(%esp)
 268:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 26f:	e8 44 01 00 00       	call   3b8 <read>
 274:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 277:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 27b:	7f 02                	jg     27f <gets+0x35>
      break;
 27d:	eb 31                	jmp    2b0 <gets+0x66>
    buf[i++] = c;
 27f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 282:	8d 50 01             	lea    0x1(%eax),%edx
 285:	89 55 f4             	mov    %edx,-0xc(%ebp)
 288:	89 c2                	mov    %eax,%edx
 28a:	8b 45 08             	mov    0x8(%ebp),%eax
 28d:	01 c2                	add    %eax,%edx
 28f:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 293:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 295:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 299:	3c 0a                	cmp    $0xa,%al
 29b:	74 13                	je     2b0 <gets+0x66>
 29d:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 2a1:	3c 0d                	cmp    $0xd,%al
 2a3:	74 0b                	je     2b0 <gets+0x66>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2a8:	83 c0 01             	add    $0x1,%eax
 2ab:	3b 45 0c             	cmp    0xc(%ebp),%eax
 2ae:	7c a9                	jl     259 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 2b0:	8b 55 f4             	mov    -0xc(%ebp),%edx
 2b3:	8b 45 08             	mov    0x8(%ebp),%eax
 2b6:	01 d0                	add    %edx,%eax
 2b8:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 2bb:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2be:	c9                   	leave  
 2bf:	c3                   	ret    

000002c0 <stat>:

int
stat(char *n, struct stat *st)
{
 2c0:	55                   	push   %ebp
 2c1:	89 e5                	mov    %esp,%ebp
 2c3:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2c6:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 2cd:	00 
 2ce:	8b 45 08             	mov    0x8(%ebp),%eax
 2d1:	89 04 24             	mov    %eax,(%esp)
 2d4:	e8 07 01 00 00       	call   3e0 <open>
 2d9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 2dc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 2e0:	79 07                	jns    2e9 <stat+0x29>
    return -1;
 2e2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2e7:	eb 23                	jmp    30c <stat+0x4c>
  r = fstat(fd, st);
 2e9:	8b 45 0c             	mov    0xc(%ebp),%eax
 2ec:	89 44 24 04          	mov    %eax,0x4(%esp)
 2f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2f3:	89 04 24             	mov    %eax,(%esp)
 2f6:	e8 fd 00 00 00       	call   3f8 <fstat>
 2fb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 2fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
 301:	89 04 24             	mov    %eax,(%esp)
 304:	e8 bf 00 00 00       	call   3c8 <close>
  return r;
 309:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 30c:	c9                   	leave  
 30d:	c3                   	ret    

0000030e <atoi>:

int
atoi(const char *s)
{
 30e:	55                   	push   %ebp
 30f:	89 e5                	mov    %esp,%ebp
 311:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 314:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 31b:	eb 25                	jmp    342 <atoi+0x34>
    n = n*10 + *s++ - '0';
 31d:	8b 55 fc             	mov    -0x4(%ebp),%edx
 320:	89 d0                	mov    %edx,%eax
 322:	c1 e0 02             	shl    $0x2,%eax
 325:	01 d0                	add    %edx,%eax
 327:	01 c0                	add    %eax,%eax
 329:	89 c1                	mov    %eax,%ecx
 32b:	8b 45 08             	mov    0x8(%ebp),%eax
 32e:	8d 50 01             	lea    0x1(%eax),%edx
 331:	89 55 08             	mov    %edx,0x8(%ebp)
 334:	0f b6 00             	movzbl (%eax),%eax
 337:	0f be c0             	movsbl %al,%eax
 33a:	01 c8                	add    %ecx,%eax
 33c:	83 e8 30             	sub    $0x30,%eax
 33f:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 342:	8b 45 08             	mov    0x8(%ebp),%eax
 345:	0f b6 00             	movzbl (%eax),%eax
 348:	3c 2f                	cmp    $0x2f,%al
 34a:	7e 0a                	jle    356 <atoi+0x48>
 34c:	8b 45 08             	mov    0x8(%ebp),%eax
 34f:	0f b6 00             	movzbl (%eax),%eax
 352:	3c 39                	cmp    $0x39,%al
 354:	7e c7                	jle    31d <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 356:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 359:	c9                   	leave  
 35a:	c3                   	ret    

0000035b <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 35b:	55                   	push   %ebp
 35c:	89 e5                	mov    %esp,%ebp
 35e:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 361:	8b 45 08             	mov    0x8(%ebp),%eax
 364:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 367:	8b 45 0c             	mov    0xc(%ebp),%eax
 36a:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 36d:	eb 17                	jmp    386 <memmove+0x2b>
    *dst++ = *src++;
 36f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 372:	8d 50 01             	lea    0x1(%eax),%edx
 375:	89 55 fc             	mov    %edx,-0x4(%ebp)
 378:	8b 55 f8             	mov    -0x8(%ebp),%edx
 37b:	8d 4a 01             	lea    0x1(%edx),%ecx
 37e:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 381:	0f b6 12             	movzbl (%edx),%edx
 384:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 386:	8b 45 10             	mov    0x10(%ebp),%eax
 389:	8d 50 ff             	lea    -0x1(%eax),%edx
 38c:	89 55 10             	mov    %edx,0x10(%ebp)
 38f:	85 c0                	test   %eax,%eax
 391:	7f dc                	jg     36f <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 393:	8b 45 08             	mov    0x8(%ebp),%eax
}
 396:	c9                   	leave  
 397:	c3                   	ret    

00000398 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 398:	b8 01 00 00 00       	mov    $0x1,%eax
 39d:	cd 40                	int    $0x40
 39f:	c3                   	ret    

000003a0 <exit>:
SYSCALL(exit)
 3a0:	b8 02 00 00 00       	mov    $0x2,%eax
 3a5:	cd 40                	int    $0x40
 3a7:	c3                   	ret    

000003a8 <wait>:
SYSCALL(wait)
 3a8:	b8 03 00 00 00       	mov    $0x3,%eax
 3ad:	cd 40                	int    $0x40
 3af:	c3                   	ret    

000003b0 <pipe>:
SYSCALL(pipe)
 3b0:	b8 04 00 00 00       	mov    $0x4,%eax
 3b5:	cd 40                	int    $0x40
 3b7:	c3                   	ret    

000003b8 <read>:
SYSCALL(read)
 3b8:	b8 05 00 00 00       	mov    $0x5,%eax
 3bd:	cd 40                	int    $0x40
 3bf:	c3                   	ret    

000003c0 <write>:
SYSCALL(write)
 3c0:	b8 10 00 00 00       	mov    $0x10,%eax
 3c5:	cd 40                	int    $0x40
 3c7:	c3                   	ret    

000003c8 <close>:
SYSCALL(close)
 3c8:	b8 15 00 00 00       	mov    $0x15,%eax
 3cd:	cd 40                	int    $0x40
 3cf:	c3                   	ret    

000003d0 <kill>:
SYSCALL(kill)
 3d0:	b8 06 00 00 00       	mov    $0x6,%eax
 3d5:	cd 40                	int    $0x40
 3d7:	c3                   	ret    

000003d8 <exec>:
SYSCALL(exec)
 3d8:	b8 07 00 00 00       	mov    $0x7,%eax
 3dd:	cd 40                	int    $0x40
 3df:	c3                   	ret    

000003e0 <open>:
SYSCALL(open)
 3e0:	b8 0f 00 00 00       	mov    $0xf,%eax
 3e5:	cd 40                	int    $0x40
 3e7:	c3                   	ret    

000003e8 <mknod>:
SYSCALL(mknod)
 3e8:	b8 11 00 00 00       	mov    $0x11,%eax
 3ed:	cd 40                	int    $0x40
 3ef:	c3                   	ret    

000003f0 <unlink>:
SYSCALL(unlink)
 3f0:	b8 12 00 00 00       	mov    $0x12,%eax
 3f5:	cd 40                	int    $0x40
 3f7:	c3                   	ret    

000003f8 <fstat>:
SYSCALL(fstat)
 3f8:	b8 08 00 00 00       	mov    $0x8,%eax
 3fd:	cd 40                	int    $0x40
 3ff:	c3                   	ret    

00000400 <link>:
SYSCALL(link)
 400:	b8 13 00 00 00       	mov    $0x13,%eax
 405:	cd 40                	int    $0x40
 407:	c3                   	ret    

00000408 <mkdir>:
SYSCALL(mkdir)
 408:	b8 14 00 00 00       	mov    $0x14,%eax
 40d:	cd 40                	int    $0x40
 40f:	c3                   	ret    

00000410 <chdir>:
SYSCALL(chdir)
 410:	b8 09 00 00 00       	mov    $0x9,%eax
 415:	cd 40                	int    $0x40
 417:	c3                   	ret    

00000418 <dup>:
SYSCALL(dup)
 418:	b8 0a 00 00 00       	mov    $0xa,%eax
 41d:	cd 40                	int    $0x40
 41f:	c3                   	ret    

00000420 <getpid>:
SYSCALL(getpid)
 420:	b8 0b 00 00 00       	mov    $0xb,%eax
 425:	cd 40                	int    $0x40
 427:	c3                   	ret    

00000428 <sbrk>:
SYSCALL(sbrk)
 428:	b8 0c 00 00 00       	mov    $0xc,%eax
 42d:	cd 40                	int    $0x40
 42f:	c3                   	ret    

00000430 <sleep>:
SYSCALL(sleep)
 430:	b8 0d 00 00 00       	mov    $0xd,%eax
 435:	cd 40                	int    $0x40
 437:	c3                   	ret    

00000438 <uptime>:
SYSCALL(uptime)
 438:	b8 0e 00 00 00       	mov    $0xe,%eax
 43d:	cd 40                	int    $0x40
 43f:	c3                   	ret    

00000440 <getproc>:
SYSCALL(getproc)
 440:	b8 16 00 00 00       	mov    $0x16,%eax
 445:	cd 40                	int    $0x40
 447:	c3                   	ret    

00000448 <sysreplace>:
SYSCALL(sysreplace)
 448:	b8 17 00 00 00       	mov    $0x17,%eax
 44d:	cd 40                	int    $0x40
 44f:	c3                   	ret    

00000450 <findkalloc>:
SYSCALL(findkalloc)
 450:	b8 18 00 00 00       	mov    $0x18,%eax
 455:	cd 40                	int    $0x40
 457:	c3                   	ret    

00000458 <signal>:
SYSCALL(signal)
 458:	b8 19 00 00 00       	mov    $0x19,%eax
 45d:	cd 40                	int    $0x40
 45f:	c3                   	ret    

00000460 <alarm>:
SYSCALL(alarm)
 460:	b8 1a 00 00 00       	mov    $0x1a,%eax
 465:	cd 40                	int    $0x40
 467:	c3                   	ret    

00000468 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 468:	55                   	push   %ebp
 469:	89 e5                	mov    %esp,%ebp
 46b:	83 ec 18             	sub    $0x18,%esp
 46e:	8b 45 0c             	mov    0xc(%ebp),%eax
 471:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 474:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 47b:	00 
 47c:	8d 45 f4             	lea    -0xc(%ebp),%eax
 47f:	89 44 24 04          	mov    %eax,0x4(%esp)
 483:	8b 45 08             	mov    0x8(%ebp),%eax
 486:	89 04 24             	mov    %eax,(%esp)
 489:	e8 32 ff ff ff       	call   3c0 <write>
}
 48e:	c9                   	leave  
 48f:	c3                   	ret    

00000490 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 490:	55                   	push   %ebp
 491:	89 e5                	mov    %esp,%ebp
 493:	56                   	push   %esi
 494:	53                   	push   %ebx
 495:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 498:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 49f:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 4a3:	74 17                	je     4bc <printint+0x2c>
 4a5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 4a9:	79 11                	jns    4bc <printint+0x2c>
    neg = 1;
 4ab:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 4b2:	8b 45 0c             	mov    0xc(%ebp),%eax
 4b5:	f7 d8                	neg    %eax
 4b7:	89 45 ec             	mov    %eax,-0x14(%ebp)
 4ba:	eb 06                	jmp    4c2 <printint+0x32>
  } else {
    x = xx;
 4bc:	8b 45 0c             	mov    0xc(%ebp),%eax
 4bf:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 4c2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 4c9:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 4cc:	8d 41 01             	lea    0x1(%ecx),%eax
 4cf:	89 45 f4             	mov    %eax,-0xc(%ebp)
 4d2:	8b 5d 10             	mov    0x10(%ebp),%ebx
 4d5:	8b 45 ec             	mov    -0x14(%ebp),%eax
 4d8:	ba 00 00 00 00       	mov    $0x0,%edx
 4dd:	f7 f3                	div    %ebx
 4df:	89 d0                	mov    %edx,%eax
 4e1:	0f b6 80 14 0c 00 00 	movzbl 0xc14(%eax),%eax
 4e8:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 4ec:	8b 75 10             	mov    0x10(%ebp),%esi
 4ef:	8b 45 ec             	mov    -0x14(%ebp),%eax
 4f2:	ba 00 00 00 00       	mov    $0x0,%edx
 4f7:	f7 f6                	div    %esi
 4f9:	89 45 ec             	mov    %eax,-0x14(%ebp)
 4fc:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 500:	75 c7                	jne    4c9 <printint+0x39>
  if(neg)
 502:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 506:	74 10                	je     518 <printint+0x88>
    buf[i++] = '-';
 508:	8b 45 f4             	mov    -0xc(%ebp),%eax
 50b:	8d 50 01             	lea    0x1(%eax),%edx
 50e:	89 55 f4             	mov    %edx,-0xc(%ebp)
 511:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 516:	eb 1f                	jmp    537 <printint+0xa7>
 518:	eb 1d                	jmp    537 <printint+0xa7>
    putc(fd, buf[i]);
 51a:	8d 55 dc             	lea    -0x24(%ebp),%edx
 51d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 520:	01 d0                	add    %edx,%eax
 522:	0f b6 00             	movzbl (%eax),%eax
 525:	0f be c0             	movsbl %al,%eax
 528:	89 44 24 04          	mov    %eax,0x4(%esp)
 52c:	8b 45 08             	mov    0x8(%ebp),%eax
 52f:	89 04 24             	mov    %eax,(%esp)
 532:	e8 31 ff ff ff       	call   468 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 537:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 53b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 53f:	79 d9                	jns    51a <printint+0x8a>
    putc(fd, buf[i]);
}
 541:	83 c4 30             	add    $0x30,%esp
 544:	5b                   	pop    %ebx
 545:	5e                   	pop    %esi
 546:	5d                   	pop    %ebp
 547:	c3                   	ret    

00000548 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 548:	55                   	push   %ebp
 549:	89 e5                	mov    %esp,%ebp
 54b:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 54e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 555:	8d 45 0c             	lea    0xc(%ebp),%eax
 558:	83 c0 04             	add    $0x4,%eax
 55b:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 55e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 565:	e9 7c 01 00 00       	jmp    6e6 <printf+0x19e>
    c = fmt[i] & 0xff;
 56a:	8b 55 0c             	mov    0xc(%ebp),%edx
 56d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 570:	01 d0                	add    %edx,%eax
 572:	0f b6 00             	movzbl (%eax),%eax
 575:	0f be c0             	movsbl %al,%eax
 578:	25 ff 00 00 00       	and    $0xff,%eax
 57d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 580:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 584:	75 2c                	jne    5b2 <printf+0x6a>
      if(c == '%'){
 586:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 58a:	75 0c                	jne    598 <printf+0x50>
        state = '%';
 58c:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 593:	e9 4a 01 00 00       	jmp    6e2 <printf+0x19a>
      } else {
        putc(fd, c);
 598:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 59b:	0f be c0             	movsbl %al,%eax
 59e:	89 44 24 04          	mov    %eax,0x4(%esp)
 5a2:	8b 45 08             	mov    0x8(%ebp),%eax
 5a5:	89 04 24             	mov    %eax,(%esp)
 5a8:	e8 bb fe ff ff       	call   468 <putc>
 5ad:	e9 30 01 00 00       	jmp    6e2 <printf+0x19a>
      }
    } else if(state == '%'){
 5b2:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 5b6:	0f 85 26 01 00 00    	jne    6e2 <printf+0x19a>
      if(c == 'd'){
 5bc:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 5c0:	75 2d                	jne    5ef <printf+0xa7>
        printint(fd, *ap, 10, 1);
 5c2:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5c5:	8b 00                	mov    (%eax),%eax
 5c7:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 5ce:	00 
 5cf:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 5d6:	00 
 5d7:	89 44 24 04          	mov    %eax,0x4(%esp)
 5db:	8b 45 08             	mov    0x8(%ebp),%eax
 5de:	89 04 24             	mov    %eax,(%esp)
 5e1:	e8 aa fe ff ff       	call   490 <printint>
        ap++;
 5e6:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5ea:	e9 ec 00 00 00       	jmp    6db <printf+0x193>
      } else if(c == 'x' || c == 'p'){
 5ef:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 5f3:	74 06                	je     5fb <printf+0xb3>
 5f5:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 5f9:	75 2d                	jne    628 <printf+0xe0>
        printint(fd, *ap, 16, 0);
 5fb:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5fe:	8b 00                	mov    (%eax),%eax
 600:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 607:	00 
 608:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 60f:	00 
 610:	89 44 24 04          	mov    %eax,0x4(%esp)
 614:	8b 45 08             	mov    0x8(%ebp),%eax
 617:	89 04 24             	mov    %eax,(%esp)
 61a:	e8 71 fe ff ff       	call   490 <printint>
        ap++;
 61f:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 623:	e9 b3 00 00 00       	jmp    6db <printf+0x193>
      } else if(c == 's'){
 628:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 62c:	75 45                	jne    673 <printf+0x12b>
        s = (char*)*ap;
 62e:	8b 45 e8             	mov    -0x18(%ebp),%eax
 631:	8b 00                	mov    (%eax),%eax
 633:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 636:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 63a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 63e:	75 09                	jne    649 <printf+0x101>
          s = "(null)";
 640:	c7 45 f4 88 09 00 00 	movl   $0x988,-0xc(%ebp)
        while(*s != 0){
 647:	eb 1e                	jmp    667 <printf+0x11f>
 649:	eb 1c                	jmp    667 <printf+0x11f>
          putc(fd, *s);
 64b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 64e:	0f b6 00             	movzbl (%eax),%eax
 651:	0f be c0             	movsbl %al,%eax
 654:	89 44 24 04          	mov    %eax,0x4(%esp)
 658:	8b 45 08             	mov    0x8(%ebp),%eax
 65b:	89 04 24             	mov    %eax,(%esp)
 65e:	e8 05 fe ff ff       	call   468 <putc>
          s++;
 663:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 667:	8b 45 f4             	mov    -0xc(%ebp),%eax
 66a:	0f b6 00             	movzbl (%eax),%eax
 66d:	84 c0                	test   %al,%al
 66f:	75 da                	jne    64b <printf+0x103>
 671:	eb 68                	jmp    6db <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 673:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 677:	75 1d                	jne    696 <printf+0x14e>
        putc(fd, *ap);
 679:	8b 45 e8             	mov    -0x18(%ebp),%eax
 67c:	8b 00                	mov    (%eax),%eax
 67e:	0f be c0             	movsbl %al,%eax
 681:	89 44 24 04          	mov    %eax,0x4(%esp)
 685:	8b 45 08             	mov    0x8(%ebp),%eax
 688:	89 04 24             	mov    %eax,(%esp)
 68b:	e8 d8 fd ff ff       	call   468 <putc>
        ap++;
 690:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 694:	eb 45                	jmp    6db <printf+0x193>
      } else if(c == '%'){
 696:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 69a:	75 17                	jne    6b3 <printf+0x16b>
        putc(fd, c);
 69c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 69f:	0f be c0             	movsbl %al,%eax
 6a2:	89 44 24 04          	mov    %eax,0x4(%esp)
 6a6:	8b 45 08             	mov    0x8(%ebp),%eax
 6a9:	89 04 24             	mov    %eax,(%esp)
 6ac:	e8 b7 fd ff ff       	call   468 <putc>
 6b1:	eb 28                	jmp    6db <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 6b3:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 6ba:	00 
 6bb:	8b 45 08             	mov    0x8(%ebp),%eax
 6be:	89 04 24             	mov    %eax,(%esp)
 6c1:	e8 a2 fd ff ff       	call   468 <putc>
        putc(fd, c);
 6c6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 6c9:	0f be c0             	movsbl %al,%eax
 6cc:	89 44 24 04          	mov    %eax,0x4(%esp)
 6d0:	8b 45 08             	mov    0x8(%ebp),%eax
 6d3:	89 04 24             	mov    %eax,(%esp)
 6d6:	e8 8d fd ff ff       	call   468 <putc>
      }
      state = 0;
 6db:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6e2:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 6e6:	8b 55 0c             	mov    0xc(%ebp),%edx
 6e9:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6ec:	01 d0                	add    %edx,%eax
 6ee:	0f b6 00             	movzbl (%eax),%eax
 6f1:	84 c0                	test   %al,%al
 6f3:	0f 85 71 fe ff ff    	jne    56a <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 6f9:	c9                   	leave  
 6fa:	c3                   	ret    

000006fb <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6fb:	55                   	push   %ebp
 6fc:	89 e5                	mov    %esp,%ebp
 6fe:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 701:	8b 45 08             	mov    0x8(%ebp),%eax
 704:	83 e8 08             	sub    $0x8,%eax
 707:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 70a:	a1 30 0c 00 00       	mov    0xc30,%eax
 70f:	89 45 fc             	mov    %eax,-0x4(%ebp)
 712:	eb 24                	jmp    738 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 714:	8b 45 fc             	mov    -0x4(%ebp),%eax
 717:	8b 00                	mov    (%eax),%eax
 719:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 71c:	77 12                	ja     730 <free+0x35>
 71e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 721:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 724:	77 24                	ja     74a <free+0x4f>
 726:	8b 45 fc             	mov    -0x4(%ebp),%eax
 729:	8b 00                	mov    (%eax),%eax
 72b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 72e:	77 1a                	ja     74a <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 730:	8b 45 fc             	mov    -0x4(%ebp),%eax
 733:	8b 00                	mov    (%eax),%eax
 735:	89 45 fc             	mov    %eax,-0x4(%ebp)
 738:	8b 45 f8             	mov    -0x8(%ebp),%eax
 73b:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 73e:	76 d4                	jbe    714 <free+0x19>
 740:	8b 45 fc             	mov    -0x4(%ebp),%eax
 743:	8b 00                	mov    (%eax),%eax
 745:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 748:	76 ca                	jbe    714 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 74a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 74d:	8b 40 04             	mov    0x4(%eax),%eax
 750:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 757:	8b 45 f8             	mov    -0x8(%ebp),%eax
 75a:	01 c2                	add    %eax,%edx
 75c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 75f:	8b 00                	mov    (%eax),%eax
 761:	39 c2                	cmp    %eax,%edx
 763:	75 24                	jne    789 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 765:	8b 45 f8             	mov    -0x8(%ebp),%eax
 768:	8b 50 04             	mov    0x4(%eax),%edx
 76b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 76e:	8b 00                	mov    (%eax),%eax
 770:	8b 40 04             	mov    0x4(%eax),%eax
 773:	01 c2                	add    %eax,%edx
 775:	8b 45 f8             	mov    -0x8(%ebp),%eax
 778:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 77b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 77e:	8b 00                	mov    (%eax),%eax
 780:	8b 10                	mov    (%eax),%edx
 782:	8b 45 f8             	mov    -0x8(%ebp),%eax
 785:	89 10                	mov    %edx,(%eax)
 787:	eb 0a                	jmp    793 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 789:	8b 45 fc             	mov    -0x4(%ebp),%eax
 78c:	8b 10                	mov    (%eax),%edx
 78e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 791:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 793:	8b 45 fc             	mov    -0x4(%ebp),%eax
 796:	8b 40 04             	mov    0x4(%eax),%eax
 799:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 7a0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7a3:	01 d0                	add    %edx,%eax
 7a5:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 7a8:	75 20                	jne    7ca <free+0xcf>
    p->s.size += bp->s.size;
 7aa:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7ad:	8b 50 04             	mov    0x4(%eax),%edx
 7b0:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7b3:	8b 40 04             	mov    0x4(%eax),%eax
 7b6:	01 c2                	add    %eax,%edx
 7b8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7bb:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 7be:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7c1:	8b 10                	mov    (%eax),%edx
 7c3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7c6:	89 10                	mov    %edx,(%eax)
 7c8:	eb 08                	jmp    7d2 <free+0xd7>
  } else
    p->s.ptr = bp;
 7ca:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7cd:	8b 55 f8             	mov    -0x8(%ebp),%edx
 7d0:	89 10                	mov    %edx,(%eax)
  freep = p;
 7d2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7d5:	a3 30 0c 00 00       	mov    %eax,0xc30
}
 7da:	c9                   	leave  
 7db:	c3                   	ret    

000007dc <morecore>:

static Header*
morecore(uint nu)
{
 7dc:	55                   	push   %ebp
 7dd:	89 e5                	mov    %esp,%ebp
 7df:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 7e2:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 7e9:	77 07                	ja     7f2 <morecore+0x16>
    nu = 4096;
 7eb:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 7f2:	8b 45 08             	mov    0x8(%ebp),%eax
 7f5:	c1 e0 03             	shl    $0x3,%eax
 7f8:	89 04 24             	mov    %eax,(%esp)
 7fb:	e8 28 fc ff ff       	call   428 <sbrk>
 800:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 803:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 807:	75 07                	jne    810 <morecore+0x34>
    return 0;
 809:	b8 00 00 00 00       	mov    $0x0,%eax
 80e:	eb 22                	jmp    832 <morecore+0x56>
  hp = (Header*)p;
 810:	8b 45 f4             	mov    -0xc(%ebp),%eax
 813:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 816:	8b 45 f0             	mov    -0x10(%ebp),%eax
 819:	8b 55 08             	mov    0x8(%ebp),%edx
 81c:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 81f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 822:	83 c0 08             	add    $0x8,%eax
 825:	89 04 24             	mov    %eax,(%esp)
 828:	e8 ce fe ff ff       	call   6fb <free>
  return freep;
 82d:	a1 30 0c 00 00       	mov    0xc30,%eax
}
 832:	c9                   	leave  
 833:	c3                   	ret    

00000834 <malloc>:

void*
malloc(uint nbytes)
{
 834:	55                   	push   %ebp
 835:	89 e5                	mov    %esp,%ebp
 837:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 83a:	8b 45 08             	mov    0x8(%ebp),%eax
 83d:	83 c0 07             	add    $0x7,%eax
 840:	c1 e8 03             	shr    $0x3,%eax
 843:	83 c0 01             	add    $0x1,%eax
 846:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 849:	a1 30 0c 00 00       	mov    0xc30,%eax
 84e:	89 45 f0             	mov    %eax,-0x10(%ebp)
 851:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 855:	75 23                	jne    87a <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 857:	c7 45 f0 28 0c 00 00 	movl   $0xc28,-0x10(%ebp)
 85e:	8b 45 f0             	mov    -0x10(%ebp),%eax
 861:	a3 30 0c 00 00       	mov    %eax,0xc30
 866:	a1 30 0c 00 00       	mov    0xc30,%eax
 86b:	a3 28 0c 00 00       	mov    %eax,0xc28
    base.s.size = 0;
 870:	c7 05 2c 0c 00 00 00 	movl   $0x0,0xc2c
 877:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 87a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 87d:	8b 00                	mov    (%eax),%eax
 87f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 882:	8b 45 f4             	mov    -0xc(%ebp),%eax
 885:	8b 40 04             	mov    0x4(%eax),%eax
 888:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 88b:	72 4d                	jb     8da <malloc+0xa6>
      if(p->s.size == nunits)
 88d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 890:	8b 40 04             	mov    0x4(%eax),%eax
 893:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 896:	75 0c                	jne    8a4 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 898:	8b 45 f4             	mov    -0xc(%ebp),%eax
 89b:	8b 10                	mov    (%eax),%edx
 89d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8a0:	89 10                	mov    %edx,(%eax)
 8a2:	eb 26                	jmp    8ca <malloc+0x96>
      else {
        p->s.size -= nunits;
 8a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8a7:	8b 40 04             	mov    0x4(%eax),%eax
 8aa:	2b 45 ec             	sub    -0x14(%ebp),%eax
 8ad:	89 c2                	mov    %eax,%edx
 8af:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8b2:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 8b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8b8:	8b 40 04             	mov    0x4(%eax),%eax
 8bb:	c1 e0 03             	shl    $0x3,%eax
 8be:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 8c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8c4:	8b 55 ec             	mov    -0x14(%ebp),%edx
 8c7:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 8ca:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8cd:	a3 30 0c 00 00       	mov    %eax,0xc30
      return (void*)(p + 1);
 8d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8d5:	83 c0 08             	add    $0x8,%eax
 8d8:	eb 38                	jmp    912 <malloc+0xde>
    }
    if(p == freep)
 8da:	a1 30 0c 00 00       	mov    0xc30,%eax
 8df:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 8e2:	75 1b                	jne    8ff <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 8e4:	8b 45 ec             	mov    -0x14(%ebp),%eax
 8e7:	89 04 24             	mov    %eax,(%esp)
 8ea:	e8 ed fe ff ff       	call   7dc <morecore>
 8ef:	89 45 f4             	mov    %eax,-0xc(%ebp)
 8f2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 8f6:	75 07                	jne    8ff <malloc+0xcb>
        return 0;
 8f8:	b8 00 00 00 00       	mov    $0x0,%eax
 8fd:	eb 13                	jmp    912 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
 902:	89 45 f0             	mov    %eax,-0x10(%ebp)
 905:	8b 45 f4             	mov    -0xc(%ebp),%eax
 908:	8b 00                	mov    (%eax),%eax
 90a:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 90d:	e9 70 ff ff ff       	jmp    882 <malloc+0x4e>
}
 912:	c9                   	leave  
 913:	c3                   	ret    
