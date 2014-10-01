
_ps:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include"types.h"
#include"user.h"

int main()
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	53                   	push   %ebx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	81 ec 30 08 00 00    	sub    $0x830,%esp
        {
                int id;
                char state[10];
                char name[16];
        } q[64],*p;
	p=&q[0];
   d:	8d 44 24 24          	lea    0x24(%esp),%eax
  11:	89 84 24 28 08 00 00 	mov    %eax,0x828(%esp)

	n=getproc((int)p);
  18:	8b 84 24 28 08 00 00 	mov    0x828(%esp),%eax
  1f:	89 04 24             	mov    %eax,(%esp)
  22:	e8 b4 03 00 00       	call   3db <getproc>
  27:	89 84 24 24 08 00 00 	mov    %eax,0x824(%esp)
        printf(1,"pid|  state     |name\n\n");
  2e:	c7 44 24 04 8f 08 00 	movl   $0x88f,0x4(%esp)
  35:	00 
  36:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  3d:	e8 81 04 00 00       	call   4c3 <printf>
	for (i=0;i<n;i++)
  42:	c7 84 24 2c 08 00 00 	movl   $0x0,0x82c(%esp)
  49:	00 00 00 00 
  4d:	eb 6f                	jmp    be <main+0xbe>
	{
		printf(1,"%d |  %s   |%s\n",p[i].id,p[i].state,p[i].name); 
  4f:	8b 84 24 2c 08 00 00 	mov    0x82c(%esp),%eax
  56:	c1 e0 05             	shl    $0x5,%eax
  59:	89 c2                	mov    %eax,%edx
  5b:	8b 84 24 28 08 00 00 	mov    0x828(%esp),%eax
  62:	01 d0                	add    %edx,%eax
  64:	8d 48 0e             	lea    0xe(%eax),%ecx
  67:	8b 84 24 2c 08 00 00 	mov    0x82c(%esp),%eax
  6e:	c1 e0 05             	shl    $0x5,%eax
  71:	89 c2                	mov    %eax,%edx
  73:	8b 84 24 28 08 00 00 	mov    0x828(%esp),%eax
  7a:	01 d0                	add    %edx,%eax
  7c:	8d 50 04             	lea    0x4(%eax),%edx
  7f:	8b 84 24 2c 08 00 00 	mov    0x82c(%esp),%eax
  86:	c1 e0 05             	shl    $0x5,%eax
  89:	89 c3                	mov    %eax,%ebx
  8b:	8b 84 24 28 08 00 00 	mov    0x828(%esp),%eax
  92:	01 d8                	add    %ebx,%eax
  94:	8b 00                	mov    (%eax),%eax
  96:	89 4c 24 10          	mov    %ecx,0x10(%esp)
  9a:	89 54 24 0c          	mov    %edx,0xc(%esp)
  9e:	89 44 24 08          	mov    %eax,0x8(%esp)
  a2:	c7 44 24 04 a7 08 00 	movl   $0x8a7,0x4(%esp)
  a9:	00 
  aa:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  b1:	e8 0d 04 00 00       	call   4c3 <printf>
        } q[64],*p;
	p=&q[0];

	n=getproc((int)p);
        printf(1,"pid|  state     |name\n\n");
	for (i=0;i<n;i++)
  b6:	83 84 24 2c 08 00 00 	addl   $0x1,0x82c(%esp)
  bd:	01 
  be:	8b 84 24 2c 08 00 00 	mov    0x82c(%esp),%eax
  c5:	3b 84 24 24 08 00 00 	cmp    0x824(%esp),%eax
  cc:	7c 81                	jl     4f <main+0x4f>
	{
		printf(1,"%d |  %s   |%s\n",p[i].id,p[i].state,p[i].name); 
	}
	exit();
  ce:	e8 68 02 00 00       	call   33b <exit>

000000d3 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  d3:	55                   	push   %ebp
  d4:	89 e5                	mov    %esp,%ebp
  d6:	57                   	push   %edi
  d7:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  d8:	8b 4d 08             	mov    0x8(%ebp),%ecx
  db:	8b 55 10             	mov    0x10(%ebp),%edx
  de:	8b 45 0c             	mov    0xc(%ebp),%eax
  e1:	89 cb                	mov    %ecx,%ebx
  e3:	89 df                	mov    %ebx,%edi
  e5:	89 d1                	mov    %edx,%ecx
  e7:	fc                   	cld    
  e8:	f3 aa                	rep stos %al,%es:(%edi)
  ea:	89 ca                	mov    %ecx,%edx
  ec:	89 fb                	mov    %edi,%ebx
  ee:	89 5d 08             	mov    %ebx,0x8(%ebp)
  f1:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  f4:	5b                   	pop    %ebx
  f5:	5f                   	pop    %edi
  f6:	5d                   	pop    %ebp
  f7:	c3                   	ret    

000000f8 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  f8:	55                   	push   %ebp
  f9:	89 e5                	mov    %esp,%ebp
  fb:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  fe:	8b 45 08             	mov    0x8(%ebp),%eax
 101:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 104:	90                   	nop
 105:	8b 45 08             	mov    0x8(%ebp),%eax
 108:	8d 50 01             	lea    0x1(%eax),%edx
 10b:	89 55 08             	mov    %edx,0x8(%ebp)
 10e:	8b 55 0c             	mov    0xc(%ebp),%edx
 111:	8d 4a 01             	lea    0x1(%edx),%ecx
 114:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 117:	0f b6 12             	movzbl (%edx),%edx
 11a:	88 10                	mov    %dl,(%eax)
 11c:	0f b6 00             	movzbl (%eax),%eax
 11f:	84 c0                	test   %al,%al
 121:	75 e2                	jne    105 <strcpy+0xd>
    ;
  return os;
 123:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 126:	c9                   	leave  
 127:	c3                   	ret    

00000128 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 128:	55                   	push   %ebp
 129:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 12b:	eb 08                	jmp    135 <strcmp+0xd>
    p++, q++;
 12d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 131:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 135:	8b 45 08             	mov    0x8(%ebp),%eax
 138:	0f b6 00             	movzbl (%eax),%eax
 13b:	84 c0                	test   %al,%al
 13d:	74 10                	je     14f <strcmp+0x27>
 13f:	8b 45 08             	mov    0x8(%ebp),%eax
 142:	0f b6 10             	movzbl (%eax),%edx
 145:	8b 45 0c             	mov    0xc(%ebp),%eax
 148:	0f b6 00             	movzbl (%eax),%eax
 14b:	38 c2                	cmp    %al,%dl
 14d:	74 de                	je     12d <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 14f:	8b 45 08             	mov    0x8(%ebp),%eax
 152:	0f b6 00             	movzbl (%eax),%eax
 155:	0f b6 d0             	movzbl %al,%edx
 158:	8b 45 0c             	mov    0xc(%ebp),%eax
 15b:	0f b6 00             	movzbl (%eax),%eax
 15e:	0f b6 c0             	movzbl %al,%eax
 161:	29 c2                	sub    %eax,%edx
 163:	89 d0                	mov    %edx,%eax
}
 165:	5d                   	pop    %ebp
 166:	c3                   	ret    

00000167 <strlen>:

uint
strlen(char *s)
{
 167:	55                   	push   %ebp
 168:	89 e5                	mov    %esp,%ebp
 16a:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 16d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 174:	eb 04                	jmp    17a <strlen+0x13>
 176:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 17a:	8b 55 fc             	mov    -0x4(%ebp),%edx
 17d:	8b 45 08             	mov    0x8(%ebp),%eax
 180:	01 d0                	add    %edx,%eax
 182:	0f b6 00             	movzbl (%eax),%eax
 185:	84 c0                	test   %al,%al
 187:	75 ed                	jne    176 <strlen+0xf>
    ;
  return n;
 189:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 18c:	c9                   	leave  
 18d:	c3                   	ret    

0000018e <memset>:

void*
memset(void *dst, int c, uint n)
{
 18e:	55                   	push   %ebp
 18f:	89 e5                	mov    %esp,%ebp
 191:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 194:	8b 45 10             	mov    0x10(%ebp),%eax
 197:	89 44 24 08          	mov    %eax,0x8(%esp)
 19b:	8b 45 0c             	mov    0xc(%ebp),%eax
 19e:	89 44 24 04          	mov    %eax,0x4(%esp)
 1a2:	8b 45 08             	mov    0x8(%ebp),%eax
 1a5:	89 04 24             	mov    %eax,(%esp)
 1a8:	e8 26 ff ff ff       	call   d3 <stosb>
  return dst;
 1ad:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1b0:	c9                   	leave  
 1b1:	c3                   	ret    

000001b2 <strchr>:

char*
strchr(const char *s, char c)
{
 1b2:	55                   	push   %ebp
 1b3:	89 e5                	mov    %esp,%ebp
 1b5:	83 ec 04             	sub    $0x4,%esp
 1b8:	8b 45 0c             	mov    0xc(%ebp),%eax
 1bb:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 1be:	eb 14                	jmp    1d4 <strchr+0x22>
    if(*s == c)
 1c0:	8b 45 08             	mov    0x8(%ebp),%eax
 1c3:	0f b6 00             	movzbl (%eax),%eax
 1c6:	3a 45 fc             	cmp    -0x4(%ebp),%al
 1c9:	75 05                	jne    1d0 <strchr+0x1e>
      return (char*)s;
 1cb:	8b 45 08             	mov    0x8(%ebp),%eax
 1ce:	eb 13                	jmp    1e3 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 1d0:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 1d4:	8b 45 08             	mov    0x8(%ebp),%eax
 1d7:	0f b6 00             	movzbl (%eax),%eax
 1da:	84 c0                	test   %al,%al
 1dc:	75 e2                	jne    1c0 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 1de:	b8 00 00 00 00       	mov    $0x0,%eax
}
 1e3:	c9                   	leave  
 1e4:	c3                   	ret    

000001e5 <gets>:

char*
gets(char *buf, int max)
{
 1e5:	55                   	push   %ebp
 1e6:	89 e5                	mov    %esp,%ebp
 1e8:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1eb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 1f2:	eb 4c                	jmp    240 <gets+0x5b>
    cc = read(0, &c, 1);
 1f4:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 1fb:	00 
 1fc:	8d 45 ef             	lea    -0x11(%ebp),%eax
 1ff:	89 44 24 04          	mov    %eax,0x4(%esp)
 203:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 20a:	e8 44 01 00 00       	call   353 <read>
 20f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 212:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 216:	7f 02                	jg     21a <gets+0x35>
      break;
 218:	eb 31                	jmp    24b <gets+0x66>
    buf[i++] = c;
 21a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 21d:	8d 50 01             	lea    0x1(%eax),%edx
 220:	89 55 f4             	mov    %edx,-0xc(%ebp)
 223:	89 c2                	mov    %eax,%edx
 225:	8b 45 08             	mov    0x8(%ebp),%eax
 228:	01 c2                	add    %eax,%edx
 22a:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 22e:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 230:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 234:	3c 0a                	cmp    $0xa,%al
 236:	74 13                	je     24b <gets+0x66>
 238:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 23c:	3c 0d                	cmp    $0xd,%al
 23e:	74 0b                	je     24b <gets+0x66>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 240:	8b 45 f4             	mov    -0xc(%ebp),%eax
 243:	83 c0 01             	add    $0x1,%eax
 246:	3b 45 0c             	cmp    0xc(%ebp),%eax
 249:	7c a9                	jl     1f4 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 24b:	8b 55 f4             	mov    -0xc(%ebp),%edx
 24e:	8b 45 08             	mov    0x8(%ebp),%eax
 251:	01 d0                	add    %edx,%eax
 253:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 256:	8b 45 08             	mov    0x8(%ebp),%eax
}
 259:	c9                   	leave  
 25a:	c3                   	ret    

0000025b <stat>:

int
stat(char *n, struct stat *st)
{
 25b:	55                   	push   %ebp
 25c:	89 e5                	mov    %esp,%ebp
 25e:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 261:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 268:	00 
 269:	8b 45 08             	mov    0x8(%ebp),%eax
 26c:	89 04 24             	mov    %eax,(%esp)
 26f:	e8 07 01 00 00       	call   37b <open>
 274:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 277:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 27b:	79 07                	jns    284 <stat+0x29>
    return -1;
 27d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 282:	eb 23                	jmp    2a7 <stat+0x4c>
  r = fstat(fd, st);
 284:	8b 45 0c             	mov    0xc(%ebp),%eax
 287:	89 44 24 04          	mov    %eax,0x4(%esp)
 28b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 28e:	89 04 24             	mov    %eax,(%esp)
 291:	e8 fd 00 00 00       	call   393 <fstat>
 296:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 299:	8b 45 f4             	mov    -0xc(%ebp),%eax
 29c:	89 04 24             	mov    %eax,(%esp)
 29f:	e8 bf 00 00 00       	call   363 <close>
  return r;
 2a4:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 2a7:	c9                   	leave  
 2a8:	c3                   	ret    

000002a9 <atoi>:

int
atoi(const char *s)
{
 2a9:	55                   	push   %ebp
 2aa:	89 e5                	mov    %esp,%ebp
 2ac:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 2af:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 2b6:	eb 25                	jmp    2dd <atoi+0x34>
    n = n*10 + *s++ - '0';
 2b8:	8b 55 fc             	mov    -0x4(%ebp),%edx
 2bb:	89 d0                	mov    %edx,%eax
 2bd:	c1 e0 02             	shl    $0x2,%eax
 2c0:	01 d0                	add    %edx,%eax
 2c2:	01 c0                	add    %eax,%eax
 2c4:	89 c1                	mov    %eax,%ecx
 2c6:	8b 45 08             	mov    0x8(%ebp),%eax
 2c9:	8d 50 01             	lea    0x1(%eax),%edx
 2cc:	89 55 08             	mov    %edx,0x8(%ebp)
 2cf:	0f b6 00             	movzbl (%eax),%eax
 2d2:	0f be c0             	movsbl %al,%eax
 2d5:	01 c8                	add    %ecx,%eax
 2d7:	83 e8 30             	sub    $0x30,%eax
 2da:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2dd:	8b 45 08             	mov    0x8(%ebp),%eax
 2e0:	0f b6 00             	movzbl (%eax),%eax
 2e3:	3c 2f                	cmp    $0x2f,%al
 2e5:	7e 0a                	jle    2f1 <atoi+0x48>
 2e7:	8b 45 08             	mov    0x8(%ebp),%eax
 2ea:	0f b6 00             	movzbl (%eax),%eax
 2ed:	3c 39                	cmp    $0x39,%al
 2ef:	7e c7                	jle    2b8 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 2f1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 2f4:	c9                   	leave  
 2f5:	c3                   	ret    

000002f6 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 2f6:	55                   	push   %ebp
 2f7:	89 e5                	mov    %esp,%ebp
 2f9:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 2fc:	8b 45 08             	mov    0x8(%ebp),%eax
 2ff:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 302:	8b 45 0c             	mov    0xc(%ebp),%eax
 305:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 308:	eb 17                	jmp    321 <memmove+0x2b>
    *dst++ = *src++;
 30a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 30d:	8d 50 01             	lea    0x1(%eax),%edx
 310:	89 55 fc             	mov    %edx,-0x4(%ebp)
 313:	8b 55 f8             	mov    -0x8(%ebp),%edx
 316:	8d 4a 01             	lea    0x1(%edx),%ecx
 319:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 31c:	0f b6 12             	movzbl (%edx),%edx
 31f:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 321:	8b 45 10             	mov    0x10(%ebp),%eax
 324:	8d 50 ff             	lea    -0x1(%eax),%edx
 327:	89 55 10             	mov    %edx,0x10(%ebp)
 32a:	85 c0                	test   %eax,%eax
 32c:	7f dc                	jg     30a <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 32e:	8b 45 08             	mov    0x8(%ebp),%eax
}
 331:	c9                   	leave  
 332:	c3                   	ret    

00000333 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 333:	b8 01 00 00 00       	mov    $0x1,%eax
 338:	cd 40                	int    $0x40
 33a:	c3                   	ret    

0000033b <exit>:
SYSCALL(exit)
 33b:	b8 02 00 00 00       	mov    $0x2,%eax
 340:	cd 40                	int    $0x40
 342:	c3                   	ret    

00000343 <wait>:
SYSCALL(wait)
 343:	b8 03 00 00 00       	mov    $0x3,%eax
 348:	cd 40                	int    $0x40
 34a:	c3                   	ret    

0000034b <pipe>:
SYSCALL(pipe)
 34b:	b8 04 00 00 00       	mov    $0x4,%eax
 350:	cd 40                	int    $0x40
 352:	c3                   	ret    

00000353 <read>:
SYSCALL(read)
 353:	b8 05 00 00 00       	mov    $0x5,%eax
 358:	cd 40                	int    $0x40
 35a:	c3                   	ret    

0000035b <write>:
SYSCALL(write)
 35b:	b8 10 00 00 00       	mov    $0x10,%eax
 360:	cd 40                	int    $0x40
 362:	c3                   	ret    

00000363 <close>:
SYSCALL(close)
 363:	b8 15 00 00 00       	mov    $0x15,%eax
 368:	cd 40                	int    $0x40
 36a:	c3                   	ret    

0000036b <kill>:
SYSCALL(kill)
 36b:	b8 06 00 00 00       	mov    $0x6,%eax
 370:	cd 40                	int    $0x40
 372:	c3                   	ret    

00000373 <exec>:
SYSCALL(exec)
 373:	b8 07 00 00 00       	mov    $0x7,%eax
 378:	cd 40                	int    $0x40
 37a:	c3                   	ret    

0000037b <open>:
SYSCALL(open)
 37b:	b8 0f 00 00 00       	mov    $0xf,%eax
 380:	cd 40                	int    $0x40
 382:	c3                   	ret    

00000383 <mknod>:
SYSCALL(mknod)
 383:	b8 11 00 00 00       	mov    $0x11,%eax
 388:	cd 40                	int    $0x40
 38a:	c3                   	ret    

0000038b <unlink>:
SYSCALL(unlink)
 38b:	b8 12 00 00 00       	mov    $0x12,%eax
 390:	cd 40                	int    $0x40
 392:	c3                   	ret    

00000393 <fstat>:
SYSCALL(fstat)
 393:	b8 08 00 00 00       	mov    $0x8,%eax
 398:	cd 40                	int    $0x40
 39a:	c3                   	ret    

0000039b <link>:
SYSCALL(link)
 39b:	b8 13 00 00 00       	mov    $0x13,%eax
 3a0:	cd 40                	int    $0x40
 3a2:	c3                   	ret    

000003a3 <mkdir>:
SYSCALL(mkdir)
 3a3:	b8 14 00 00 00       	mov    $0x14,%eax
 3a8:	cd 40                	int    $0x40
 3aa:	c3                   	ret    

000003ab <chdir>:
SYSCALL(chdir)
 3ab:	b8 09 00 00 00       	mov    $0x9,%eax
 3b0:	cd 40                	int    $0x40
 3b2:	c3                   	ret    

000003b3 <dup>:
SYSCALL(dup)
 3b3:	b8 0a 00 00 00       	mov    $0xa,%eax
 3b8:	cd 40                	int    $0x40
 3ba:	c3                   	ret    

000003bb <getpid>:
SYSCALL(getpid)
 3bb:	b8 0b 00 00 00       	mov    $0xb,%eax
 3c0:	cd 40                	int    $0x40
 3c2:	c3                   	ret    

000003c3 <sbrk>:
SYSCALL(sbrk)
 3c3:	b8 0c 00 00 00       	mov    $0xc,%eax
 3c8:	cd 40                	int    $0x40
 3ca:	c3                   	ret    

000003cb <sleep>:
SYSCALL(sleep)
 3cb:	b8 0d 00 00 00       	mov    $0xd,%eax
 3d0:	cd 40                	int    $0x40
 3d2:	c3                   	ret    

000003d3 <uptime>:
SYSCALL(uptime)
 3d3:	b8 0e 00 00 00       	mov    $0xe,%eax
 3d8:	cd 40                	int    $0x40
 3da:	c3                   	ret    

000003db <getproc>:
SYSCALL(getproc)
 3db:	b8 16 00 00 00       	mov    $0x16,%eax
 3e0:	cd 40                	int    $0x40
 3e2:	c3                   	ret    

000003e3 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 3e3:	55                   	push   %ebp
 3e4:	89 e5                	mov    %esp,%ebp
 3e6:	83 ec 18             	sub    $0x18,%esp
 3e9:	8b 45 0c             	mov    0xc(%ebp),%eax
 3ec:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 3ef:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 3f6:	00 
 3f7:	8d 45 f4             	lea    -0xc(%ebp),%eax
 3fa:	89 44 24 04          	mov    %eax,0x4(%esp)
 3fe:	8b 45 08             	mov    0x8(%ebp),%eax
 401:	89 04 24             	mov    %eax,(%esp)
 404:	e8 52 ff ff ff       	call   35b <write>
}
 409:	c9                   	leave  
 40a:	c3                   	ret    

0000040b <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 40b:	55                   	push   %ebp
 40c:	89 e5                	mov    %esp,%ebp
 40e:	56                   	push   %esi
 40f:	53                   	push   %ebx
 410:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 413:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 41a:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 41e:	74 17                	je     437 <printint+0x2c>
 420:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 424:	79 11                	jns    437 <printint+0x2c>
    neg = 1;
 426:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 42d:	8b 45 0c             	mov    0xc(%ebp),%eax
 430:	f7 d8                	neg    %eax
 432:	89 45 ec             	mov    %eax,-0x14(%ebp)
 435:	eb 06                	jmp    43d <printint+0x32>
  } else {
    x = xx;
 437:	8b 45 0c             	mov    0xc(%ebp),%eax
 43a:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 43d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 444:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 447:	8d 41 01             	lea    0x1(%ecx),%eax
 44a:	89 45 f4             	mov    %eax,-0xc(%ebp)
 44d:	8b 5d 10             	mov    0x10(%ebp),%ebx
 450:	8b 45 ec             	mov    -0x14(%ebp),%eax
 453:	ba 00 00 00 00       	mov    $0x0,%edx
 458:	f7 f3                	div    %ebx
 45a:	89 d0                	mov    %edx,%eax
 45c:	0f b6 80 04 0b 00 00 	movzbl 0xb04(%eax),%eax
 463:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 467:	8b 75 10             	mov    0x10(%ebp),%esi
 46a:	8b 45 ec             	mov    -0x14(%ebp),%eax
 46d:	ba 00 00 00 00       	mov    $0x0,%edx
 472:	f7 f6                	div    %esi
 474:	89 45 ec             	mov    %eax,-0x14(%ebp)
 477:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 47b:	75 c7                	jne    444 <printint+0x39>
  if(neg)
 47d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 481:	74 10                	je     493 <printint+0x88>
    buf[i++] = '-';
 483:	8b 45 f4             	mov    -0xc(%ebp),%eax
 486:	8d 50 01             	lea    0x1(%eax),%edx
 489:	89 55 f4             	mov    %edx,-0xc(%ebp)
 48c:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 491:	eb 1f                	jmp    4b2 <printint+0xa7>
 493:	eb 1d                	jmp    4b2 <printint+0xa7>
    putc(fd, buf[i]);
 495:	8d 55 dc             	lea    -0x24(%ebp),%edx
 498:	8b 45 f4             	mov    -0xc(%ebp),%eax
 49b:	01 d0                	add    %edx,%eax
 49d:	0f b6 00             	movzbl (%eax),%eax
 4a0:	0f be c0             	movsbl %al,%eax
 4a3:	89 44 24 04          	mov    %eax,0x4(%esp)
 4a7:	8b 45 08             	mov    0x8(%ebp),%eax
 4aa:	89 04 24             	mov    %eax,(%esp)
 4ad:	e8 31 ff ff ff       	call   3e3 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 4b2:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 4b6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4ba:	79 d9                	jns    495 <printint+0x8a>
    putc(fd, buf[i]);
}
 4bc:	83 c4 30             	add    $0x30,%esp
 4bf:	5b                   	pop    %ebx
 4c0:	5e                   	pop    %esi
 4c1:	5d                   	pop    %ebp
 4c2:	c3                   	ret    

000004c3 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4c3:	55                   	push   %ebp
 4c4:	89 e5                	mov    %esp,%ebp
 4c6:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 4c9:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 4d0:	8d 45 0c             	lea    0xc(%ebp),%eax
 4d3:	83 c0 04             	add    $0x4,%eax
 4d6:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 4d9:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 4e0:	e9 7c 01 00 00       	jmp    661 <printf+0x19e>
    c = fmt[i] & 0xff;
 4e5:	8b 55 0c             	mov    0xc(%ebp),%edx
 4e8:	8b 45 f0             	mov    -0x10(%ebp),%eax
 4eb:	01 d0                	add    %edx,%eax
 4ed:	0f b6 00             	movzbl (%eax),%eax
 4f0:	0f be c0             	movsbl %al,%eax
 4f3:	25 ff 00 00 00       	and    $0xff,%eax
 4f8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 4fb:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4ff:	75 2c                	jne    52d <printf+0x6a>
      if(c == '%'){
 501:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 505:	75 0c                	jne    513 <printf+0x50>
        state = '%';
 507:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 50e:	e9 4a 01 00 00       	jmp    65d <printf+0x19a>
      } else {
        putc(fd, c);
 513:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 516:	0f be c0             	movsbl %al,%eax
 519:	89 44 24 04          	mov    %eax,0x4(%esp)
 51d:	8b 45 08             	mov    0x8(%ebp),%eax
 520:	89 04 24             	mov    %eax,(%esp)
 523:	e8 bb fe ff ff       	call   3e3 <putc>
 528:	e9 30 01 00 00       	jmp    65d <printf+0x19a>
      }
    } else if(state == '%'){
 52d:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 531:	0f 85 26 01 00 00    	jne    65d <printf+0x19a>
      if(c == 'd'){
 537:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 53b:	75 2d                	jne    56a <printf+0xa7>
        printint(fd, *ap, 10, 1);
 53d:	8b 45 e8             	mov    -0x18(%ebp),%eax
 540:	8b 00                	mov    (%eax),%eax
 542:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 549:	00 
 54a:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 551:	00 
 552:	89 44 24 04          	mov    %eax,0x4(%esp)
 556:	8b 45 08             	mov    0x8(%ebp),%eax
 559:	89 04 24             	mov    %eax,(%esp)
 55c:	e8 aa fe ff ff       	call   40b <printint>
        ap++;
 561:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 565:	e9 ec 00 00 00       	jmp    656 <printf+0x193>
      } else if(c == 'x' || c == 'p'){
 56a:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 56e:	74 06                	je     576 <printf+0xb3>
 570:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 574:	75 2d                	jne    5a3 <printf+0xe0>
        printint(fd, *ap, 16, 0);
 576:	8b 45 e8             	mov    -0x18(%ebp),%eax
 579:	8b 00                	mov    (%eax),%eax
 57b:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 582:	00 
 583:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 58a:	00 
 58b:	89 44 24 04          	mov    %eax,0x4(%esp)
 58f:	8b 45 08             	mov    0x8(%ebp),%eax
 592:	89 04 24             	mov    %eax,(%esp)
 595:	e8 71 fe ff ff       	call   40b <printint>
        ap++;
 59a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 59e:	e9 b3 00 00 00       	jmp    656 <printf+0x193>
      } else if(c == 's'){
 5a3:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 5a7:	75 45                	jne    5ee <printf+0x12b>
        s = (char*)*ap;
 5a9:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5ac:	8b 00                	mov    (%eax),%eax
 5ae:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 5b1:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 5b5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 5b9:	75 09                	jne    5c4 <printf+0x101>
          s = "(null)";
 5bb:	c7 45 f4 b7 08 00 00 	movl   $0x8b7,-0xc(%ebp)
        while(*s != 0){
 5c2:	eb 1e                	jmp    5e2 <printf+0x11f>
 5c4:	eb 1c                	jmp    5e2 <printf+0x11f>
          putc(fd, *s);
 5c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5c9:	0f b6 00             	movzbl (%eax),%eax
 5cc:	0f be c0             	movsbl %al,%eax
 5cf:	89 44 24 04          	mov    %eax,0x4(%esp)
 5d3:	8b 45 08             	mov    0x8(%ebp),%eax
 5d6:	89 04 24             	mov    %eax,(%esp)
 5d9:	e8 05 fe ff ff       	call   3e3 <putc>
          s++;
 5de:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 5e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5e5:	0f b6 00             	movzbl (%eax),%eax
 5e8:	84 c0                	test   %al,%al
 5ea:	75 da                	jne    5c6 <printf+0x103>
 5ec:	eb 68                	jmp    656 <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5ee:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 5f2:	75 1d                	jne    611 <printf+0x14e>
        putc(fd, *ap);
 5f4:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5f7:	8b 00                	mov    (%eax),%eax
 5f9:	0f be c0             	movsbl %al,%eax
 5fc:	89 44 24 04          	mov    %eax,0x4(%esp)
 600:	8b 45 08             	mov    0x8(%ebp),%eax
 603:	89 04 24             	mov    %eax,(%esp)
 606:	e8 d8 fd ff ff       	call   3e3 <putc>
        ap++;
 60b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 60f:	eb 45                	jmp    656 <printf+0x193>
      } else if(c == '%'){
 611:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 615:	75 17                	jne    62e <printf+0x16b>
        putc(fd, c);
 617:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 61a:	0f be c0             	movsbl %al,%eax
 61d:	89 44 24 04          	mov    %eax,0x4(%esp)
 621:	8b 45 08             	mov    0x8(%ebp),%eax
 624:	89 04 24             	mov    %eax,(%esp)
 627:	e8 b7 fd ff ff       	call   3e3 <putc>
 62c:	eb 28                	jmp    656 <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 62e:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 635:	00 
 636:	8b 45 08             	mov    0x8(%ebp),%eax
 639:	89 04 24             	mov    %eax,(%esp)
 63c:	e8 a2 fd ff ff       	call   3e3 <putc>
        putc(fd, c);
 641:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 644:	0f be c0             	movsbl %al,%eax
 647:	89 44 24 04          	mov    %eax,0x4(%esp)
 64b:	8b 45 08             	mov    0x8(%ebp),%eax
 64e:	89 04 24             	mov    %eax,(%esp)
 651:	e8 8d fd ff ff       	call   3e3 <putc>
      }
      state = 0;
 656:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 65d:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 661:	8b 55 0c             	mov    0xc(%ebp),%edx
 664:	8b 45 f0             	mov    -0x10(%ebp),%eax
 667:	01 d0                	add    %edx,%eax
 669:	0f b6 00             	movzbl (%eax),%eax
 66c:	84 c0                	test   %al,%al
 66e:	0f 85 71 fe ff ff    	jne    4e5 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 674:	c9                   	leave  
 675:	c3                   	ret    

00000676 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 676:	55                   	push   %ebp
 677:	89 e5                	mov    %esp,%ebp
 679:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 67c:	8b 45 08             	mov    0x8(%ebp),%eax
 67f:	83 e8 08             	sub    $0x8,%eax
 682:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 685:	a1 20 0b 00 00       	mov    0xb20,%eax
 68a:	89 45 fc             	mov    %eax,-0x4(%ebp)
 68d:	eb 24                	jmp    6b3 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 68f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 692:	8b 00                	mov    (%eax),%eax
 694:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 697:	77 12                	ja     6ab <free+0x35>
 699:	8b 45 f8             	mov    -0x8(%ebp),%eax
 69c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 69f:	77 24                	ja     6c5 <free+0x4f>
 6a1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a4:	8b 00                	mov    (%eax),%eax
 6a6:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6a9:	77 1a                	ja     6c5 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6ab:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ae:	8b 00                	mov    (%eax),%eax
 6b0:	89 45 fc             	mov    %eax,-0x4(%ebp)
 6b3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6b6:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6b9:	76 d4                	jbe    68f <free+0x19>
 6bb:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6be:	8b 00                	mov    (%eax),%eax
 6c0:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6c3:	76 ca                	jbe    68f <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 6c5:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6c8:	8b 40 04             	mov    0x4(%eax),%eax
 6cb:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6d2:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6d5:	01 c2                	add    %eax,%edx
 6d7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6da:	8b 00                	mov    (%eax),%eax
 6dc:	39 c2                	cmp    %eax,%edx
 6de:	75 24                	jne    704 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 6e0:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6e3:	8b 50 04             	mov    0x4(%eax),%edx
 6e6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6e9:	8b 00                	mov    (%eax),%eax
 6eb:	8b 40 04             	mov    0x4(%eax),%eax
 6ee:	01 c2                	add    %eax,%edx
 6f0:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6f3:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 6f6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6f9:	8b 00                	mov    (%eax),%eax
 6fb:	8b 10                	mov    (%eax),%edx
 6fd:	8b 45 f8             	mov    -0x8(%ebp),%eax
 700:	89 10                	mov    %edx,(%eax)
 702:	eb 0a                	jmp    70e <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 704:	8b 45 fc             	mov    -0x4(%ebp),%eax
 707:	8b 10                	mov    (%eax),%edx
 709:	8b 45 f8             	mov    -0x8(%ebp),%eax
 70c:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 70e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 711:	8b 40 04             	mov    0x4(%eax),%eax
 714:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 71b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 71e:	01 d0                	add    %edx,%eax
 720:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 723:	75 20                	jne    745 <free+0xcf>
    p->s.size += bp->s.size;
 725:	8b 45 fc             	mov    -0x4(%ebp),%eax
 728:	8b 50 04             	mov    0x4(%eax),%edx
 72b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 72e:	8b 40 04             	mov    0x4(%eax),%eax
 731:	01 c2                	add    %eax,%edx
 733:	8b 45 fc             	mov    -0x4(%ebp),%eax
 736:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 739:	8b 45 f8             	mov    -0x8(%ebp),%eax
 73c:	8b 10                	mov    (%eax),%edx
 73e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 741:	89 10                	mov    %edx,(%eax)
 743:	eb 08                	jmp    74d <free+0xd7>
  } else
    p->s.ptr = bp;
 745:	8b 45 fc             	mov    -0x4(%ebp),%eax
 748:	8b 55 f8             	mov    -0x8(%ebp),%edx
 74b:	89 10                	mov    %edx,(%eax)
  freep = p;
 74d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 750:	a3 20 0b 00 00       	mov    %eax,0xb20
}
 755:	c9                   	leave  
 756:	c3                   	ret    

00000757 <morecore>:

static Header*
morecore(uint nu)
{
 757:	55                   	push   %ebp
 758:	89 e5                	mov    %esp,%ebp
 75a:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 75d:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 764:	77 07                	ja     76d <morecore+0x16>
    nu = 4096;
 766:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 76d:	8b 45 08             	mov    0x8(%ebp),%eax
 770:	c1 e0 03             	shl    $0x3,%eax
 773:	89 04 24             	mov    %eax,(%esp)
 776:	e8 48 fc ff ff       	call   3c3 <sbrk>
 77b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 77e:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 782:	75 07                	jne    78b <morecore+0x34>
    return 0;
 784:	b8 00 00 00 00       	mov    $0x0,%eax
 789:	eb 22                	jmp    7ad <morecore+0x56>
  hp = (Header*)p;
 78b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 78e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 791:	8b 45 f0             	mov    -0x10(%ebp),%eax
 794:	8b 55 08             	mov    0x8(%ebp),%edx
 797:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 79a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 79d:	83 c0 08             	add    $0x8,%eax
 7a0:	89 04 24             	mov    %eax,(%esp)
 7a3:	e8 ce fe ff ff       	call   676 <free>
  return freep;
 7a8:	a1 20 0b 00 00       	mov    0xb20,%eax
}
 7ad:	c9                   	leave  
 7ae:	c3                   	ret    

000007af <malloc>:

void*
malloc(uint nbytes)
{
 7af:	55                   	push   %ebp
 7b0:	89 e5                	mov    %esp,%ebp
 7b2:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7b5:	8b 45 08             	mov    0x8(%ebp),%eax
 7b8:	83 c0 07             	add    $0x7,%eax
 7bb:	c1 e8 03             	shr    $0x3,%eax
 7be:	83 c0 01             	add    $0x1,%eax
 7c1:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 7c4:	a1 20 0b 00 00       	mov    0xb20,%eax
 7c9:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7cc:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 7d0:	75 23                	jne    7f5 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 7d2:	c7 45 f0 18 0b 00 00 	movl   $0xb18,-0x10(%ebp)
 7d9:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7dc:	a3 20 0b 00 00       	mov    %eax,0xb20
 7e1:	a1 20 0b 00 00       	mov    0xb20,%eax
 7e6:	a3 18 0b 00 00       	mov    %eax,0xb18
    base.s.size = 0;
 7eb:	c7 05 1c 0b 00 00 00 	movl   $0x0,0xb1c
 7f2:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7f5:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7f8:	8b 00                	mov    (%eax),%eax
 7fa:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 7fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 800:	8b 40 04             	mov    0x4(%eax),%eax
 803:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 806:	72 4d                	jb     855 <malloc+0xa6>
      if(p->s.size == nunits)
 808:	8b 45 f4             	mov    -0xc(%ebp),%eax
 80b:	8b 40 04             	mov    0x4(%eax),%eax
 80e:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 811:	75 0c                	jne    81f <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 813:	8b 45 f4             	mov    -0xc(%ebp),%eax
 816:	8b 10                	mov    (%eax),%edx
 818:	8b 45 f0             	mov    -0x10(%ebp),%eax
 81b:	89 10                	mov    %edx,(%eax)
 81d:	eb 26                	jmp    845 <malloc+0x96>
      else {
        p->s.size -= nunits;
 81f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 822:	8b 40 04             	mov    0x4(%eax),%eax
 825:	2b 45 ec             	sub    -0x14(%ebp),%eax
 828:	89 c2                	mov    %eax,%edx
 82a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 82d:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 830:	8b 45 f4             	mov    -0xc(%ebp),%eax
 833:	8b 40 04             	mov    0x4(%eax),%eax
 836:	c1 e0 03             	shl    $0x3,%eax
 839:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 83c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 83f:	8b 55 ec             	mov    -0x14(%ebp),%edx
 842:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 845:	8b 45 f0             	mov    -0x10(%ebp),%eax
 848:	a3 20 0b 00 00       	mov    %eax,0xb20
      return (void*)(p + 1);
 84d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 850:	83 c0 08             	add    $0x8,%eax
 853:	eb 38                	jmp    88d <malloc+0xde>
    }
    if(p == freep)
 855:	a1 20 0b 00 00       	mov    0xb20,%eax
 85a:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 85d:	75 1b                	jne    87a <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 85f:	8b 45 ec             	mov    -0x14(%ebp),%eax
 862:	89 04 24             	mov    %eax,(%esp)
 865:	e8 ed fe ff ff       	call   757 <morecore>
 86a:	89 45 f4             	mov    %eax,-0xc(%ebp)
 86d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 871:	75 07                	jne    87a <malloc+0xcb>
        return 0;
 873:	b8 00 00 00 00       	mov    $0x0,%eax
 878:	eb 13                	jmp    88d <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 87a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 87d:	89 45 f0             	mov    %eax,-0x10(%ebp)
 880:	8b 45 f4             	mov    -0xc(%ebp),%eax
 883:	8b 00                	mov    (%eax),%eax
 885:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 888:	e9 70 ff ff ff       	jmp    7fd <malloc+0x4e>
}
 88d:	c9                   	leave  
 88e:	c3                   	ret    
