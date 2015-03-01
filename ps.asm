
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
  2e:	c7 44 24 04 97 08 00 	movl   $0x897,0x4(%esp)
  35:	00 
  36:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  3d:	e8 89 04 00 00       	call   4cb <printf>
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
  a2:	c7 44 24 04 af 08 00 	movl   $0x8af,0x4(%esp)
  a9:	00 
  aa:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  b1:	e8 15 04 00 00       	call   4cb <printf>
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

000003e3 <sysreplace>:
SYSCALL(sysreplace)
 3e3:	b8 17 00 00 00       	mov    $0x17,%eax
 3e8:	cd 40                	int    $0x40
 3ea:	c3                   	ret    

000003eb <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 3eb:	55                   	push   %ebp
 3ec:	89 e5                	mov    %esp,%ebp
 3ee:	83 ec 18             	sub    $0x18,%esp
 3f1:	8b 45 0c             	mov    0xc(%ebp),%eax
 3f4:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 3f7:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 3fe:	00 
 3ff:	8d 45 f4             	lea    -0xc(%ebp),%eax
 402:	89 44 24 04          	mov    %eax,0x4(%esp)
 406:	8b 45 08             	mov    0x8(%ebp),%eax
 409:	89 04 24             	mov    %eax,(%esp)
 40c:	e8 4a ff ff ff       	call   35b <write>
}
 411:	c9                   	leave  
 412:	c3                   	ret    

00000413 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 413:	55                   	push   %ebp
 414:	89 e5                	mov    %esp,%ebp
 416:	56                   	push   %esi
 417:	53                   	push   %ebx
 418:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 41b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 422:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 426:	74 17                	je     43f <printint+0x2c>
 428:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 42c:	79 11                	jns    43f <printint+0x2c>
    neg = 1;
 42e:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 435:	8b 45 0c             	mov    0xc(%ebp),%eax
 438:	f7 d8                	neg    %eax
 43a:	89 45 ec             	mov    %eax,-0x14(%ebp)
 43d:	eb 06                	jmp    445 <printint+0x32>
  } else {
    x = xx;
 43f:	8b 45 0c             	mov    0xc(%ebp),%eax
 442:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 445:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 44c:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 44f:	8d 41 01             	lea    0x1(%ecx),%eax
 452:	89 45 f4             	mov    %eax,-0xc(%ebp)
 455:	8b 5d 10             	mov    0x10(%ebp),%ebx
 458:	8b 45 ec             	mov    -0x14(%ebp),%eax
 45b:	ba 00 00 00 00       	mov    $0x0,%edx
 460:	f7 f3                	div    %ebx
 462:	89 d0                	mov    %edx,%eax
 464:	0f b6 80 0c 0b 00 00 	movzbl 0xb0c(%eax),%eax
 46b:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 46f:	8b 75 10             	mov    0x10(%ebp),%esi
 472:	8b 45 ec             	mov    -0x14(%ebp),%eax
 475:	ba 00 00 00 00       	mov    $0x0,%edx
 47a:	f7 f6                	div    %esi
 47c:	89 45 ec             	mov    %eax,-0x14(%ebp)
 47f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 483:	75 c7                	jne    44c <printint+0x39>
  if(neg)
 485:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 489:	74 10                	je     49b <printint+0x88>
    buf[i++] = '-';
 48b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 48e:	8d 50 01             	lea    0x1(%eax),%edx
 491:	89 55 f4             	mov    %edx,-0xc(%ebp)
 494:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 499:	eb 1f                	jmp    4ba <printint+0xa7>
 49b:	eb 1d                	jmp    4ba <printint+0xa7>
    putc(fd, buf[i]);
 49d:	8d 55 dc             	lea    -0x24(%ebp),%edx
 4a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4a3:	01 d0                	add    %edx,%eax
 4a5:	0f b6 00             	movzbl (%eax),%eax
 4a8:	0f be c0             	movsbl %al,%eax
 4ab:	89 44 24 04          	mov    %eax,0x4(%esp)
 4af:	8b 45 08             	mov    0x8(%ebp),%eax
 4b2:	89 04 24             	mov    %eax,(%esp)
 4b5:	e8 31 ff ff ff       	call   3eb <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 4ba:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 4be:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4c2:	79 d9                	jns    49d <printint+0x8a>
    putc(fd, buf[i]);
}
 4c4:	83 c4 30             	add    $0x30,%esp
 4c7:	5b                   	pop    %ebx
 4c8:	5e                   	pop    %esi
 4c9:	5d                   	pop    %ebp
 4ca:	c3                   	ret    

000004cb <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4cb:	55                   	push   %ebp
 4cc:	89 e5                	mov    %esp,%ebp
 4ce:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 4d1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 4d8:	8d 45 0c             	lea    0xc(%ebp),%eax
 4db:	83 c0 04             	add    $0x4,%eax
 4de:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 4e1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 4e8:	e9 7c 01 00 00       	jmp    669 <printf+0x19e>
    c = fmt[i] & 0xff;
 4ed:	8b 55 0c             	mov    0xc(%ebp),%edx
 4f0:	8b 45 f0             	mov    -0x10(%ebp),%eax
 4f3:	01 d0                	add    %edx,%eax
 4f5:	0f b6 00             	movzbl (%eax),%eax
 4f8:	0f be c0             	movsbl %al,%eax
 4fb:	25 ff 00 00 00       	and    $0xff,%eax
 500:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 503:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 507:	75 2c                	jne    535 <printf+0x6a>
      if(c == '%'){
 509:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 50d:	75 0c                	jne    51b <printf+0x50>
        state = '%';
 50f:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 516:	e9 4a 01 00 00       	jmp    665 <printf+0x19a>
      } else {
        putc(fd, c);
 51b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 51e:	0f be c0             	movsbl %al,%eax
 521:	89 44 24 04          	mov    %eax,0x4(%esp)
 525:	8b 45 08             	mov    0x8(%ebp),%eax
 528:	89 04 24             	mov    %eax,(%esp)
 52b:	e8 bb fe ff ff       	call   3eb <putc>
 530:	e9 30 01 00 00       	jmp    665 <printf+0x19a>
      }
    } else if(state == '%'){
 535:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 539:	0f 85 26 01 00 00    	jne    665 <printf+0x19a>
      if(c == 'd'){
 53f:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 543:	75 2d                	jne    572 <printf+0xa7>
        printint(fd, *ap, 10, 1);
 545:	8b 45 e8             	mov    -0x18(%ebp),%eax
 548:	8b 00                	mov    (%eax),%eax
 54a:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 551:	00 
 552:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 559:	00 
 55a:	89 44 24 04          	mov    %eax,0x4(%esp)
 55e:	8b 45 08             	mov    0x8(%ebp),%eax
 561:	89 04 24             	mov    %eax,(%esp)
 564:	e8 aa fe ff ff       	call   413 <printint>
        ap++;
 569:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 56d:	e9 ec 00 00 00       	jmp    65e <printf+0x193>
      } else if(c == 'x' || c == 'p'){
 572:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 576:	74 06                	je     57e <printf+0xb3>
 578:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 57c:	75 2d                	jne    5ab <printf+0xe0>
        printint(fd, *ap, 16, 0);
 57e:	8b 45 e8             	mov    -0x18(%ebp),%eax
 581:	8b 00                	mov    (%eax),%eax
 583:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 58a:	00 
 58b:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 592:	00 
 593:	89 44 24 04          	mov    %eax,0x4(%esp)
 597:	8b 45 08             	mov    0x8(%ebp),%eax
 59a:	89 04 24             	mov    %eax,(%esp)
 59d:	e8 71 fe ff ff       	call   413 <printint>
        ap++;
 5a2:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5a6:	e9 b3 00 00 00       	jmp    65e <printf+0x193>
      } else if(c == 's'){
 5ab:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 5af:	75 45                	jne    5f6 <printf+0x12b>
        s = (char*)*ap;
 5b1:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5b4:	8b 00                	mov    (%eax),%eax
 5b6:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 5b9:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 5bd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 5c1:	75 09                	jne    5cc <printf+0x101>
          s = "(null)";
 5c3:	c7 45 f4 bf 08 00 00 	movl   $0x8bf,-0xc(%ebp)
        while(*s != 0){
 5ca:	eb 1e                	jmp    5ea <printf+0x11f>
 5cc:	eb 1c                	jmp    5ea <printf+0x11f>
          putc(fd, *s);
 5ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5d1:	0f b6 00             	movzbl (%eax),%eax
 5d4:	0f be c0             	movsbl %al,%eax
 5d7:	89 44 24 04          	mov    %eax,0x4(%esp)
 5db:	8b 45 08             	mov    0x8(%ebp),%eax
 5de:	89 04 24             	mov    %eax,(%esp)
 5e1:	e8 05 fe ff ff       	call   3eb <putc>
          s++;
 5e6:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 5ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5ed:	0f b6 00             	movzbl (%eax),%eax
 5f0:	84 c0                	test   %al,%al
 5f2:	75 da                	jne    5ce <printf+0x103>
 5f4:	eb 68                	jmp    65e <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5f6:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 5fa:	75 1d                	jne    619 <printf+0x14e>
        putc(fd, *ap);
 5fc:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5ff:	8b 00                	mov    (%eax),%eax
 601:	0f be c0             	movsbl %al,%eax
 604:	89 44 24 04          	mov    %eax,0x4(%esp)
 608:	8b 45 08             	mov    0x8(%ebp),%eax
 60b:	89 04 24             	mov    %eax,(%esp)
 60e:	e8 d8 fd ff ff       	call   3eb <putc>
        ap++;
 613:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 617:	eb 45                	jmp    65e <printf+0x193>
      } else if(c == '%'){
 619:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 61d:	75 17                	jne    636 <printf+0x16b>
        putc(fd, c);
 61f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 622:	0f be c0             	movsbl %al,%eax
 625:	89 44 24 04          	mov    %eax,0x4(%esp)
 629:	8b 45 08             	mov    0x8(%ebp),%eax
 62c:	89 04 24             	mov    %eax,(%esp)
 62f:	e8 b7 fd ff ff       	call   3eb <putc>
 634:	eb 28                	jmp    65e <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 636:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 63d:	00 
 63e:	8b 45 08             	mov    0x8(%ebp),%eax
 641:	89 04 24             	mov    %eax,(%esp)
 644:	e8 a2 fd ff ff       	call   3eb <putc>
        putc(fd, c);
 649:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 64c:	0f be c0             	movsbl %al,%eax
 64f:	89 44 24 04          	mov    %eax,0x4(%esp)
 653:	8b 45 08             	mov    0x8(%ebp),%eax
 656:	89 04 24             	mov    %eax,(%esp)
 659:	e8 8d fd ff ff       	call   3eb <putc>
      }
      state = 0;
 65e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 665:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 669:	8b 55 0c             	mov    0xc(%ebp),%edx
 66c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 66f:	01 d0                	add    %edx,%eax
 671:	0f b6 00             	movzbl (%eax),%eax
 674:	84 c0                	test   %al,%al
 676:	0f 85 71 fe ff ff    	jne    4ed <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 67c:	c9                   	leave  
 67d:	c3                   	ret    

0000067e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 67e:	55                   	push   %ebp
 67f:	89 e5                	mov    %esp,%ebp
 681:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 684:	8b 45 08             	mov    0x8(%ebp),%eax
 687:	83 e8 08             	sub    $0x8,%eax
 68a:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 68d:	a1 28 0b 00 00       	mov    0xb28,%eax
 692:	89 45 fc             	mov    %eax,-0x4(%ebp)
 695:	eb 24                	jmp    6bb <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 697:	8b 45 fc             	mov    -0x4(%ebp),%eax
 69a:	8b 00                	mov    (%eax),%eax
 69c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 69f:	77 12                	ja     6b3 <free+0x35>
 6a1:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6a4:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6a7:	77 24                	ja     6cd <free+0x4f>
 6a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ac:	8b 00                	mov    (%eax),%eax
 6ae:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6b1:	77 1a                	ja     6cd <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6b3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6b6:	8b 00                	mov    (%eax),%eax
 6b8:	89 45 fc             	mov    %eax,-0x4(%ebp)
 6bb:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6be:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6c1:	76 d4                	jbe    697 <free+0x19>
 6c3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6c6:	8b 00                	mov    (%eax),%eax
 6c8:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6cb:	76 ca                	jbe    697 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 6cd:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6d0:	8b 40 04             	mov    0x4(%eax),%eax
 6d3:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6da:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6dd:	01 c2                	add    %eax,%edx
 6df:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6e2:	8b 00                	mov    (%eax),%eax
 6e4:	39 c2                	cmp    %eax,%edx
 6e6:	75 24                	jne    70c <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 6e8:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6eb:	8b 50 04             	mov    0x4(%eax),%edx
 6ee:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6f1:	8b 00                	mov    (%eax),%eax
 6f3:	8b 40 04             	mov    0x4(%eax),%eax
 6f6:	01 c2                	add    %eax,%edx
 6f8:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6fb:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 6fe:	8b 45 fc             	mov    -0x4(%ebp),%eax
 701:	8b 00                	mov    (%eax),%eax
 703:	8b 10                	mov    (%eax),%edx
 705:	8b 45 f8             	mov    -0x8(%ebp),%eax
 708:	89 10                	mov    %edx,(%eax)
 70a:	eb 0a                	jmp    716 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 70c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 70f:	8b 10                	mov    (%eax),%edx
 711:	8b 45 f8             	mov    -0x8(%ebp),%eax
 714:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 716:	8b 45 fc             	mov    -0x4(%ebp),%eax
 719:	8b 40 04             	mov    0x4(%eax),%eax
 71c:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 723:	8b 45 fc             	mov    -0x4(%ebp),%eax
 726:	01 d0                	add    %edx,%eax
 728:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 72b:	75 20                	jne    74d <free+0xcf>
    p->s.size += bp->s.size;
 72d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 730:	8b 50 04             	mov    0x4(%eax),%edx
 733:	8b 45 f8             	mov    -0x8(%ebp),%eax
 736:	8b 40 04             	mov    0x4(%eax),%eax
 739:	01 c2                	add    %eax,%edx
 73b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 73e:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 741:	8b 45 f8             	mov    -0x8(%ebp),%eax
 744:	8b 10                	mov    (%eax),%edx
 746:	8b 45 fc             	mov    -0x4(%ebp),%eax
 749:	89 10                	mov    %edx,(%eax)
 74b:	eb 08                	jmp    755 <free+0xd7>
  } else
    p->s.ptr = bp;
 74d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 750:	8b 55 f8             	mov    -0x8(%ebp),%edx
 753:	89 10                	mov    %edx,(%eax)
  freep = p;
 755:	8b 45 fc             	mov    -0x4(%ebp),%eax
 758:	a3 28 0b 00 00       	mov    %eax,0xb28
}
 75d:	c9                   	leave  
 75e:	c3                   	ret    

0000075f <morecore>:

static Header*
morecore(uint nu)
{
 75f:	55                   	push   %ebp
 760:	89 e5                	mov    %esp,%ebp
 762:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 765:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 76c:	77 07                	ja     775 <morecore+0x16>
    nu = 4096;
 76e:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 775:	8b 45 08             	mov    0x8(%ebp),%eax
 778:	c1 e0 03             	shl    $0x3,%eax
 77b:	89 04 24             	mov    %eax,(%esp)
 77e:	e8 40 fc ff ff       	call   3c3 <sbrk>
 783:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 786:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 78a:	75 07                	jne    793 <morecore+0x34>
    return 0;
 78c:	b8 00 00 00 00       	mov    $0x0,%eax
 791:	eb 22                	jmp    7b5 <morecore+0x56>
  hp = (Header*)p;
 793:	8b 45 f4             	mov    -0xc(%ebp),%eax
 796:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 799:	8b 45 f0             	mov    -0x10(%ebp),%eax
 79c:	8b 55 08             	mov    0x8(%ebp),%edx
 79f:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 7a2:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7a5:	83 c0 08             	add    $0x8,%eax
 7a8:	89 04 24             	mov    %eax,(%esp)
 7ab:	e8 ce fe ff ff       	call   67e <free>
  return freep;
 7b0:	a1 28 0b 00 00       	mov    0xb28,%eax
}
 7b5:	c9                   	leave  
 7b6:	c3                   	ret    

000007b7 <malloc>:

void*
malloc(uint nbytes)
{
 7b7:	55                   	push   %ebp
 7b8:	89 e5                	mov    %esp,%ebp
 7ba:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7bd:	8b 45 08             	mov    0x8(%ebp),%eax
 7c0:	83 c0 07             	add    $0x7,%eax
 7c3:	c1 e8 03             	shr    $0x3,%eax
 7c6:	83 c0 01             	add    $0x1,%eax
 7c9:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 7cc:	a1 28 0b 00 00       	mov    0xb28,%eax
 7d1:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7d4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 7d8:	75 23                	jne    7fd <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 7da:	c7 45 f0 20 0b 00 00 	movl   $0xb20,-0x10(%ebp)
 7e1:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7e4:	a3 28 0b 00 00       	mov    %eax,0xb28
 7e9:	a1 28 0b 00 00       	mov    0xb28,%eax
 7ee:	a3 20 0b 00 00       	mov    %eax,0xb20
    base.s.size = 0;
 7f3:	c7 05 24 0b 00 00 00 	movl   $0x0,0xb24
 7fa:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7fd:	8b 45 f0             	mov    -0x10(%ebp),%eax
 800:	8b 00                	mov    (%eax),%eax
 802:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 805:	8b 45 f4             	mov    -0xc(%ebp),%eax
 808:	8b 40 04             	mov    0x4(%eax),%eax
 80b:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 80e:	72 4d                	jb     85d <malloc+0xa6>
      if(p->s.size == nunits)
 810:	8b 45 f4             	mov    -0xc(%ebp),%eax
 813:	8b 40 04             	mov    0x4(%eax),%eax
 816:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 819:	75 0c                	jne    827 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 81b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 81e:	8b 10                	mov    (%eax),%edx
 820:	8b 45 f0             	mov    -0x10(%ebp),%eax
 823:	89 10                	mov    %edx,(%eax)
 825:	eb 26                	jmp    84d <malloc+0x96>
      else {
        p->s.size -= nunits;
 827:	8b 45 f4             	mov    -0xc(%ebp),%eax
 82a:	8b 40 04             	mov    0x4(%eax),%eax
 82d:	2b 45 ec             	sub    -0x14(%ebp),%eax
 830:	89 c2                	mov    %eax,%edx
 832:	8b 45 f4             	mov    -0xc(%ebp),%eax
 835:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 838:	8b 45 f4             	mov    -0xc(%ebp),%eax
 83b:	8b 40 04             	mov    0x4(%eax),%eax
 83e:	c1 e0 03             	shl    $0x3,%eax
 841:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 844:	8b 45 f4             	mov    -0xc(%ebp),%eax
 847:	8b 55 ec             	mov    -0x14(%ebp),%edx
 84a:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 84d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 850:	a3 28 0b 00 00       	mov    %eax,0xb28
      return (void*)(p + 1);
 855:	8b 45 f4             	mov    -0xc(%ebp),%eax
 858:	83 c0 08             	add    $0x8,%eax
 85b:	eb 38                	jmp    895 <malloc+0xde>
    }
    if(p == freep)
 85d:	a1 28 0b 00 00       	mov    0xb28,%eax
 862:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 865:	75 1b                	jne    882 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 867:	8b 45 ec             	mov    -0x14(%ebp),%eax
 86a:	89 04 24             	mov    %eax,(%esp)
 86d:	e8 ed fe ff ff       	call   75f <morecore>
 872:	89 45 f4             	mov    %eax,-0xc(%ebp)
 875:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 879:	75 07                	jne    882 <malloc+0xcb>
        return 0;
 87b:	b8 00 00 00 00       	mov    $0x0,%eax
 880:	eb 13                	jmp    895 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 882:	8b 45 f4             	mov    -0xc(%ebp),%eax
 885:	89 45 f0             	mov    %eax,-0x10(%ebp)
 888:	8b 45 f4             	mov    -0xc(%ebp),%eax
 88b:	8b 00                	mov    (%eax),%eax
 88d:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 890:	e9 70 ff ff ff       	jmp    805 <malloc+0x4e>
}
 895:	c9                   	leave  
 896:	c3                   	ret    
