
_myuptime:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
int (*old_func)(void);
//int (*f)(void);
int myuptime(void);

int main(void)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
   6:	83 ec 10             	sub    $0x10,%esp
	printf(1,"Uptime value is %d\n",uptime());
   9:	e8 70 03 00 00       	call   37e <uptime>
   e:	89 44 24 08          	mov    %eax,0x8(%esp)
  12:	c7 44 24 04 42 08 00 	movl   $0x842,0x4(%esp)
  19:	00 
  1a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  21:	e8 50 04 00 00       	call   476 <printf>
	if(!sysreplace(14,(int)myuptime,(int)&old_func))
  26:	ba fc 0a 00 00       	mov    $0xafc,%edx
  2b:	b8 6a 00 00 00       	mov    $0x6a,%eax
  30:	89 54 24 08          	mov    %edx,0x8(%esp)
  34:	89 44 24 04          	mov    %eax,0x4(%esp)
  38:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
  3f:	e8 4a 03 00 00       	call   38e <sysreplace>
  44:	85 c0                	test   %eax,%eax
  46:	75 1d                	jne    65 <main+0x65>
//	f=(void*)old_func;
//		printf(1,"Address of uptime is %x",(old_func));
	printf(1,"Value of uptime is now %d\n",uptime());
  48:	e8 31 03 00 00       	call   37e <uptime>
  4d:	89 44 24 08          	mov    %eax,0x8(%esp)
  51:	c7 44 24 04 56 08 00 	movl   $0x856,0x4(%esp)
  58:	00 
  59:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  60:	e8 11 04 00 00       	call   476 <printf>
	exit();
  65:	e8 7c 02 00 00       	call   2e6 <exit>

0000006a <myuptime>:
}

int myuptime(void) 
{
  6a:	55                   	push   %ebp
  6b:	89 e5                	mov    %esp,%ebp
  6d:	83 ec 08             	sub    $0x8,%esp
	return(old_func()+50000);
  70:	a1 fc 0a 00 00       	mov    0xafc,%eax
  75:	ff d0                	call   *%eax
  77:	05 50 c3 00 00       	add    $0xc350,%eax
}
  7c:	c9                   	leave  
  7d:	c3                   	ret    

0000007e <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  7e:	55                   	push   %ebp
  7f:	89 e5                	mov    %esp,%ebp
  81:	57                   	push   %edi
  82:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  83:	8b 4d 08             	mov    0x8(%ebp),%ecx
  86:	8b 55 10             	mov    0x10(%ebp),%edx
  89:	8b 45 0c             	mov    0xc(%ebp),%eax
  8c:	89 cb                	mov    %ecx,%ebx
  8e:	89 df                	mov    %ebx,%edi
  90:	89 d1                	mov    %edx,%ecx
  92:	fc                   	cld    
  93:	f3 aa                	rep stos %al,%es:(%edi)
  95:	89 ca                	mov    %ecx,%edx
  97:	89 fb                	mov    %edi,%ebx
  99:	89 5d 08             	mov    %ebx,0x8(%ebp)
  9c:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  9f:	5b                   	pop    %ebx
  a0:	5f                   	pop    %edi
  a1:	5d                   	pop    %ebp
  a2:	c3                   	ret    

000000a3 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  a3:	55                   	push   %ebp
  a4:	89 e5                	mov    %esp,%ebp
  a6:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  a9:	8b 45 08             	mov    0x8(%ebp),%eax
  ac:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  af:	90                   	nop
  b0:	8b 45 08             	mov    0x8(%ebp),%eax
  b3:	8d 50 01             	lea    0x1(%eax),%edx
  b6:	89 55 08             	mov    %edx,0x8(%ebp)
  b9:	8b 55 0c             	mov    0xc(%ebp),%edx
  bc:	8d 4a 01             	lea    0x1(%edx),%ecx
  bf:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  c2:	0f b6 12             	movzbl (%edx),%edx
  c5:	88 10                	mov    %dl,(%eax)
  c7:	0f b6 00             	movzbl (%eax),%eax
  ca:	84 c0                	test   %al,%al
  cc:	75 e2                	jne    b0 <strcpy+0xd>
    ;
  return os;
  ce:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  d1:	c9                   	leave  
  d2:	c3                   	ret    

000000d3 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  d3:	55                   	push   %ebp
  d4:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  d6:	eb 08                	jmp    e0 <strcmp+0xd>
    p++, q++;
  d8:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  dc:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  e0:	8b 45 08             	mov    0x8(%ebp),%eax
  e3:	0f b6 00             	movzbl (%eax),%eax
  e6:	84 c0                	test   %al,%al
  e8:	74 10                	je     fa <strcmp+0x27>
  ea:	8b 45 08             	mov    0x8(%ebp),%eax
  ed:	0f b6 10             	movzbl (%eax),%edx
  f0:	8b 45 0c             	mov    0xc(%ebp),%eax
  f3:	0f b6 00             	movzbl (%eax),%eax
  f6:	38 c2                	cmp    %al,%dl
  f8:	74 de                	je     d8 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  fa:	8b 45 08             	mov    0x8(%ebp),%eax
  fd:	0f b6 00             	movzbl (%eax),%eax
 100:	0f b6 d0             	movzbl %al,%edx
 103:	8b 45 0c             	mov    0xc(%ebp),%eax
 106:	0f b6 00             	movzbl (%eax),%eax
 109:	0f b6 c0             	movzbl %al,%eax
 10c:	29 c2                	sub    %eax,%edx
 10e:	89 d0                	mov    %edx,%eax
}
 110:	5d                   	pop    %ebp
 111:	c3                   	ret    

00000112 <strlen>:

uint
strlen(char *s)
{
 112:	55                   	push   %ebp
 113:	89 e5                	mov    %esp,%ebp
 115:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 118:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 11f:	eb 04                	jmp    125 <strlen+0x13>
 121:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 125:	8b 55 fc             	mov    -0x4(%ebp),%edx
 128:	8b 45 08             	mov    0x8(%ebp),%eax
 12b:	01 d0                	add    %edx,%eax
 12d:	0f b6 00             	movzbl (%eax),%eax
 130:	84 c0                	test   %al,%al
 132:	75 ed                	jne    121 <strlen+0xf>
    ;
  return n;
 134:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 137:	c9                   	leave  
 138:	c3                   	ret    

00000139 <memset>:

void*
memset(void *dst, int c, uint n)
{
 139:	55                   	push   %ebp
 13a:	89 e5                	mov    %esp,%ebp
 13c:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 13f:	8b 45 10             	mov    0x10(%ebp),%eax
 142:	89 44 24 08          	mov    %eax,0x8(%esp)
 146:	8b 45 0c             	mov    0xc(%ebp),%eax
 149:	89 44 24 04          	mov    %eax,0x4(%esp)
 14d:	8b 45 08             	mov    0x8(%ebp),%eax
 150:	89 04 24             	mov    %eax,(%esp)
 153:	e8 26 ff ff ff       	call   7e <stosb>
  return dst;
 158:	8b 45 08             	mov    0x8(%ebp),%eax
}
 15b:	c9                   	leave  
 15c:	c3                   	ret    

0000015d <strchr>:

char*
strchr(const char *s, char c)
{
 15d:	55                   	push   %ebp
 15e:	89 e5                	mov    %esp,%ebp
 160:	83 ec 04             	sub    $0x4,%esp
 163:	8b 45 0c             	mov    0xc(%ebp),%eax
 166:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 169:	eb 14                	jmp    17f <strchr+0x22>
    if(*s == c)
 16b:	8b 45 08             	mov    0x8(%ebp),%eax
 16e:	0f b6 00             	movzbl (%eax),%eax
 171:	3a 45 fc             	cmp    -0x4(%ebp),%al
 174:	75 05                	jne    17b <strchr+0x1e>
      return (char*)s;
 176:	8b 45 08             	mov    0x8(%ebp),%eax
 179:	eb 13                	jmp    18e <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 17b:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 17f:	8b 45 08             	mov    0x8(%ebp),%eax
 182:	0f b6 00             	movzbl (%eax),%eax
 185:	84 c0                	test   %al,%al
 187:	75 e2                	jne    16b <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 189:	b8 00 00 00 00       	mov    $0x0,%eax
}
 18e:	c9                   	leave  
 18f:	c3                   	ret    

00000190 <gets>:

char*
gets(char *buf, int max)
{
 190:	55                   	push   %ebp
 191:	89 e5                	mov    %esp,%ebp
 193:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 196:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 19d:	eb 4c                	jmp    1eb <gets+0x5b>
    cc = read(0, &c, 1);
 19f:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 1a6:	00 
 1a7:	8d 45 ef             	lea    -0x11(%ebp),%eax
 1aa:	89 44 24 04          	mov    %eax,0x4(%esp)
 1ae:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 1b5:	e8 44 01 00 00       	call   2fe <read>
 1ba:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 1bd:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 1c1:	7f 02                	jg     1c5 <gets+0x35>
      break;
 1c3:	eb 31                	jmp    1f6 <gets+0x66>
    buf[i++] = c;
 1c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1c8:	8d 50 01             	lea    0x1(%eax),%edx
 1cb:	89 55 f4             	mov    %edx,-0xc(%ebp)
 1ce:	89 c2                	mov    %eax,%edx
 1d0:	8b 45 08             	mov    0x8(%ebp),%eax
 1d3:	01 c2                	add    %eax,%edx
 1d5:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1d9:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 1db:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1df:	3c 0a                	cmp    $0xa,%al
 1e1:	74 13                	je     1f6 <gets+0x66>
 1e3:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1e7:	3c 0d                	cmp    $0xd,%al
 1e9:	74 0b                	je     1f6 <gets+0x66>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1ee:	83 c0 01             	add    $0x1,%eax
 1f1:	3b 45 0c             	cmp    0xc(%ebp),%eax
 1f4:	7c a9                	jl     19f <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1f6:	8b 55 f4             	mov    -0xc(%ebp),%edx
 1f9:	8b 45 08             	mov    0x8(%ebp),%eax
 1fc:	01 d0                	add    %edx,%eax
 1fe:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 201:	8b 45 08             	mov    0x8(%ebp),%eax
}
 204:	c9                   	leave  
 205:	c3                   	ret    

00000206 <stat>:

int
stat(char *n, struct stat *st)
{
 206:	55                   	push   %ebp
 207:	89 e5                	mov    %esp,%ebp
 209:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 20c:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 213:	00 
 214:	8b 45 08             	mov    0x8(%ebp),%eax
 217:	89 04 24             	mov    %eax,(%esp)
 21a:	e8 07 01 00 00       	call   326 <open>
 21f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 222:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 226:	79 07                	jns    22f <stat+0x29>
    return -1;
 228:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 22d:	eb 23                	jmp    252 <stat+0x4c>
  r = fstat(fd, st);
 22f:	8b 45 0c             	mov    0xc(%ebp),%eax
 232:	89 44 24 04          	mov    %eax,0x4(%esp)
 236:	8b 45 f4             	mov    -0xc(%ebp),%eax
 239:	89 04 24             	mov    %eax,(%esp)
 23c:	e8 fd 00 00 00       	call   33e <fstat>
 241:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 244:	8b 45 f4             	mov    -0xc(%ebp),%eax
 247:	89 04 24             	mov    %eax,(%esp)
 24a:	e8 bf 00 00 00       	call   30e <close>
  return r;
 24f:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 252:	c9                   	leave  
 253:	c3                   	ret    

00000254 <atoi>:

int
atoi(const char *s)
{
 254:	55                   	push   %ebp
 255:	89 e5                	mov    %esp,%ebp
 257:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 25a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 261:	eb 25                	jmp    288 <atoi+0x34>
    n = n*10 + *s++ - '0';
 263:	8b 55 fc             	mov    -0x4(%ebp),%edx
 266:	89 d0                	mov    %edx,%eax
 268:	c1 e0 02             	shl    $0x2,%eax
 26b:	01 d0                	add    %edx,%eax
 26d:	01 c0                	add    %eax,%eax
 26f:	89 c1                	mov    %eax,%ecx
 271:	8b 45 08             	mov    0x8(%ebp),%eax
 274:	8d 50 01             	lea    0x1(%eax),%edx
 277:	89 55 08             	mov    %edx,0x8(%ebp)
 27a:	0f b6 00             	movzbl (%eax),%eax
 27d:	0f be c0             	movsbl %al,%eax
 280:	01 c8                	add    %ecx,%eax
 282:	83 e8 30             	sub    $0x30,%eax
 285:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 288:	8b 45 08             	mov    0x8(%ebp),%eax
 28b:	0f b6 00             	movzbl (%eax),%eax
 28e:	3c 2f                	cmp    $0x2f,%al
 290:	7e 0a                	jle    29c <atoi+0x48>
 292:	8b 45 08             	mov    0x8(%ebp),%eax
 295:	0f b6 00             	movzbl (%eax),%eax
 298:	3c 39                	cmp    $0x39,%al
 29a:	7e c7                	jle    263 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 29c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 29f:	c9                   	leave  
 2a0:	c3                   	ret    

000002a1 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 2a1:	55                   	push   %ebp
 2a2:	89 e5                	mov    %esp,%ebp
 2a4:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 2a7:	8b 45 08             	mov    0x8(%ebp),%eax
 2aa:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 2ad:	8b 45 0c             	mov    0xc(%ebp),%eax
 2b0:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 2b3:	eb 17                	jmp    2cc <memmove+0x2b>
    *dst++ = *src++;
 2b5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 2b8:	8d 50 01             	lea    0x1(%eax),%edx
 2bb:	89 55 fc             	mov    %edx,-0x4(%ebp)
 2be:	8b 55 f8             	mov    -0x8(%ebp),%edx
 2c1:	8d 4a 01             	lea    0x1(%edx),%ecx
 2c4:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 2c7:	0f b6 12             	movzbl (%edx),%edx
 2ca:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2cc:	8b 45 10             	mov    0x10(%ebp),%eax
 2cf:	8d 50 ff             	lea    -0x1(%eax),%edx
 2d2:	89 55 10             	mov    %edx,0x10(%ebp)
 2d5:	85 c0                	test   %eax,%eax
 2d7:	7f dc                	jg     2b5 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 2d9:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2dc:	c9                   	leave  
 2dd:	c3                   	ret    

000002de <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2de:	b8 01 00 00 00       	mov    $0x1,%eax
 2e3:	cd 40                	int    $0x40
 2e5:	c3                   	ret    

000002e6 <exit>:
SYSCALL(exit)
 2e6:	b8 02 00 00 00       	mov    $0x2,%eax
 2eb:	cd 40                	int    $0x40
 2ed:	c3                   	ret    

000002ee <wait>:
SYSCALL(wait)
 2ee:	b8 03 00 00 00       	mov    $0x3,%eax
 2f3:	cd 40                	int    $0x40
 2f5:	c3                   	ret    

000002f6 <pipe>:
SYSCALL(pipe)
 2f6:	b8 04 00 00 00       	mov    $0x4,%eax
 2fb:	cd 40                	int    $0x40
 2fd:	c3                   	ret    

000002fe <read>:
SYSCALL(read)
 2fe:	b8 05 00 00 00       	mov    $0x5,%eax
 303:	cd 40                	int    $0x40
 305:	c3                   	ret    

00000306 <write>:
SYSCALL(write)
 306:	b8 10 00 00 00       	mov    $0x10,%eax
 30b:	cd 40                	int    $0x40
 30d:	c3                   	ret    

0000030e <close>:
SYSCALL(close)
 30e:	b8 15 00 00 00       	mov    $0x15,%eax
 313:	cd 40                	int    $0x40
 315:	c3                   	ret    

00000316 <kill>:
SYSCALL(kill)
 316:	b8 06 00 00 00       	mov    $0x6,%eax
 31b:	cd 40                	int    $0x40
 31d:	c3                   	ret    

0000031e <exec>:
SYSCALL(exec)
 31e:	b8 07 00 00 00       	mov    $0x7,%eax
 323:	cd 40                	int    $0x40
 325:	c3                   	ret    

00000326 <open>:
SYSCALL(open)
 326:	b8 0f 00 00 00       	mov    $0xf,%eax
 32b:	cd 40                	int    $0x40
 32d:	c3                   	ret    

0000032e <mknod>:
SYSCALL(mknod)
 32e:	b8 11 00 00 00       	mov    $0x11,%eax
 333:	cd 40                	int    $0x40
 335:	c3                   	ret    

00000336 <unlink>:
SYSCALL(unlink)
 336:	b8 12 00 00 00       	mov    $0x12,%eax
 33b:	cd 40                	int    $0x40
 33d:	c3                   	ret    

0000033e <fstat>:
SYSCALL(fstat)
 33e:	b8 08 00 00 00       	mov    $0x8,%eax
 343:	cd 40                	int    $0x40
 345:	c3                   	ret    

00000346 <link>:
SYSCALL(link)
 346:	b8 13 00 00 00       	mov    $0x13,%eax
 34b:	cd 40                	int    $0x40
 34d:	c3                   	ret    

0000034e <mkdir>:
SYSCALL(mkdir)
 34e:	b8 14 00 00 00       	mov    $0x14,%eax
 353:	cd 40                	int    $0x40
 355:	c3                   	ret    

00000356 <chdir>:
SYSCALL(chdir)
 356:	b8 09 00 00 00       	mov    $0x9,%eax
 35b:	cd 40                	int    $0x40
 35d:	c3                   	ret    

0000035e <dup>:
SYSCALL(dup)
 35e:	b8 0a 00 00 00       	mov    $0xa,%eax
 363:	cd 40                	int    $0x40
 365:	c3                   	ret    

00000366 <getpid>:
SYSCALL(getpid)
 366:	b8 0b 00 00 00       	mov    $0xb,%eax
 36b:	cd 40                	int    $0x40
 36d:	c3                   	ret    

0000036e <sbrk>:
SYSCALL(sbrk)
 36e:	b8 0c 00 00 00       	mov    $0xc,%eax
 373:	cd 40                	int    $0x40
 375:	c3                   	ret    

00000376 <sleep>:
SYSCALL(sleep)
 376:	b8 0d 00 00 00       	mov    $0xd,%eax
 37b:	cd 40                	int    $0x40
 37d:	c3                   	ret    

0000037e <uptime>:
SYSCALL(uptime)
 37e:	b8 0e 00 00 00       	mov    $0xe,%eax
 383:	cd 40                	int    $0x40
 385:	c3                   	ret    

00000386 <getproc>:
SYSCALL(getproc)
 386:	b8 16 00 00 00       	mov    $0x16,%eax
 38b:	cd 40                	int    $0x40
 38d:	c3                   	ret    

0000038e <sysreplace>:
SYSCALL(sysreplace)
 38e:	b8 17 00 00 00       	mov    $0x17,%eax
 393:	cd 40                	int    $0x40
 395:	c3                   	ret    

00000396 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 396:	55                   	push   %ebp
 397:	89 e5                	mov    %esp,%ebp
 399:	83 ec 18             	sub    $0x18,%esp
 39c:	8b 45 0c             	mov    0xc(%ebp),%eax
 39f:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 3a2:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 3a9:	00 
 3aa:	8d 45 f4             	lea    -0xc(%ebp),%eax
 3ad:	89 44 24 04          	mov    %eax,0x4(%esp)
 3b1:	8b 45 08             	mov    0x8(%ebp),%eax
 3b4:	89 04 24             	mov    %eax,(%esp)
 3b7:	e8 4a ff ff ff       	call   306 <write>
}
 3bc:	c9                   	leave  
 3bd:	c3                   	ret    

000003be <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3be:	55                   	push   %ebp
 3bf:	89 e5                	mov    %esp,%ebp
 3c1:	56                   	push   %esi
 3c2:	53                   	push   %ebx
 3c3:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 3c6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 3cd:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 3d1:	74 17                	je     3ea <printint+0x2c>
 3d3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 3d7:	79 11                	jns    3ea <printint+0x2c>
    neg = 1;
 3d9:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 3e0:	8b 45 0c             	mov    0xc(%ebp),%eax
 3e3:	f7 d8                	neg    %eax
 3e5:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3e8:	eb 06                	jmp    3f0 <printint+0x32>
  } else {
    x = xx;
 3ea:	8b 45 0c             	mov    0xc(%ebp),%eax
 3ed:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 3f0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 3f7:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 3fa:	8d 41 01             	lea    0x1(%ecx),%eax
 3fd:	89 45 f4             	mov    %eax,-0xc(%ebp)
 400:	8b 5d 10             	mov    0x10(%ebp),%ebx
 403:	8b 45 ec             	mov    -0x14(%ebp),%eax
 406:	ba 00 00 00 00       	mov    $0x0,%edx
 40b:	f7 f3                	div    %ebx
 40d:	89 d0                	mov    %edx,%eax
 40f:	0f b6 80 dc 0a 00 00 	movzbl 0xadc(%eax),%eax
 416:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 41a:	8b 75 10             	mov    0x10(%ebp),%esi
 41d:	8b 45 ec             	mov    -0x14(%ebp),%eax
 420:	ba 00 00 00 00       	mov    $0x0,%edx
 425:	f7 f6                	div    %esi
 427:	89 45 ec             	mov    %eax,-0x14(%ebp)
 42a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 42e:	75 c7                	jne    3f7 <printint+0x39>
  if(neg)
 430:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 434:	74 10                	je     446 <printint+0x88>
    buf[i++] = '-';
 436:	8b 45 f4             	mov    -0xc(%ebp),%eax
 439:	8d 50 01             	lea    0x1(%eax),%edx
 43c:	89 55 f4             	mov    %edx,-0xc(%ebp)
 43f:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 444:	eb 1f                	jmp    465 <printint+0xa7>
 446:	eb 1d                	jmp    465 <printint+0xa7>
    putc(fd, buf[i]);
 448:	8d 55 dc             	lea    -0x24(%ebp),%edx
 44b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 44e:	01 d0                	add    %edx,%eax
 450:	0f b6 00             	movzbl (%eax),%eax
 453:	0f be c0             	movsbl %al,%eax
 456:	89 44 24 04          	mov    %eax,0x4(%esp)
 45a:	8b 45 08             	mov    0x8(%ebp),%eax
 45d:	89 04 24             	mov    %eax,(%esp)
 460:	e8 31 ff ff ff       	call   396 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 465:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 469:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 46d:	79 d9                	jns    448 <printint+0x8a>
    putc(fd, buf[i]);
}
 46f:	83 c4 30             	add    $0x30,%esp
 472:	5b                   	pop    %ebx
 473:	5e                   	pop    %esi
 474:	5d                   	pop    %ebp
 475:	c3                   	ret    

00000476 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 476:	55                   	push   %ebp
 477:	89 e5                	mov    %esp,%ebp
 479:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 47c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 483:	8d 45 0c             	lea    0xc(%ebp),%eax
 486:	83 c0 04             	add    $0x4,%eax
 489:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 48c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 493:	e9 7c 01 00 00       	jmp    614 <printf+0x19e>
    c = fmt[i] & 0xff;
 498:	8b 55 0c             	mov    0xc(%ebp),%edx
 49b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 49e:	01 d0                	add    %edx,%eax
 4a0:	0f b6 00             	movzbl (%eax),%eax
 4a3:	0f be c0             	movsbl %al,%eax
 4a6:	25 ff 00 00 00       	and    $0xff,%eax
 4ab:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 4ae:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4b2:	75 2c                	jne    4e0 <printf+0x6a>
      if(c == '%'){
 4b4:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 4b8:	75 0c                	jne    4c6 <printf+0x50>
        state = '%';
 4ba:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 4c1:	e9 4a 01 00 00       	jmp    610 <printf+0x19a>
      } else {
        putc(fd, c);
 4c6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 4c9:	0f be c0             	movsbl %al,%eax
 4cc:	89 44 24 04          	mov    %eax,0x4(%esp)
 4d0:	8b 45 08             	mov    0x8(%ebp),%eax
 4d3:	89 04 24             	mov    %eax,(%esp)
 4d6:	e8 bb fe ff ff       	call   396 <putc>
 4db:	e9 30 01 00 00       	jmp    610 <printf+0x19a>
      }
    } else if(state == '%'){
 4e0:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 4e4:	0f 85 26 01 00 00    	jne    610 <printf+0x19a>
      if(c == 'd'){
 4ea:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 4ee:	75 2d                	jne    51d <printf+0xa7>
        printint(fd, *ap, 10, 1);
 4f0:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4f3:	8b 00                	mov    (%eax),%eax
 4f5:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 4fc:	00 
 4fd:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 504:	00 
 505:	89 44 24 04          	mov    %eax,0x4(%esp)
 509:	8b 45 08             	mov    0x8(%ebp),%eax
 50c:	89 04 24             	mov    %eax,(%esp)
 50f:	e8 aa fe ff ff       	call   3be <printint>
        ap++;
 514:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 518:	e9 ec 00 00 00       	jmp    609 <printf+0x193>
      } else if(c == 'x' || c == 'p'){
 51d:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 521:	74 06                	je     529 <printf+0xb3>
 523:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 527:	75 2d                	jne    556 <printf+0xe0>
        printint(fd, *ap, 16, 0);
 529:	8b 45 e8             	mov    -0x18(%ebp),%eax
 52c:	8b 00                	mov    (%eax),%eax
 52e:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 535:	00 
 536:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 53d:	00 
 53e:	89 44 24 04          	mov    %eax,0x4(%esp)
 542:	8b 45 08             	mov    0x8(%ebp),%eax
 545:	89 04 24             	mov    %eax,(%esp)
 548:	e8 71 fe ff ff       	call   3be <printint>
        ap++;
 54d:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 551:	e9 b3 00 00 00       	jmp    609 <printf+0x193>
      } else if(c == 's'){
 556:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 55a:	75 45                	jne    5a1 <printf+0x12b>
        s = (char*)*ap;
 55c:	8b 45 e8             	mov    -0x18(%ebp),%eax
 55f:	8b 00                	mov    (%eax),%eax
 561:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 564:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 568:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 56c:	75 09                	jne    577 <printf+0x101>
          s = "(null)";
 56e:	c7 45 f4 71 08 00 00 	movl   $0x871,-0xc(%ebp)
        while(*s != 0){
 575:	eb 1e                	jmp    595 <printf+0x11f>
 577:	eb 1c                	jmp    595 <printf+0x11f>
          putc(fd, *s);
 579:	8b 45 f4             	mov    -0xc(%ebp),%eax
 57c:	0f b6 00             	movzbl (%eax),%eax
 57f:	0f be c0             	movsbl %al,%eax
 582:	89 44 24 04          	mov    %eax,0x4(%esp)
 586:	8b 45 08             	mov    0x8(%ebp),%eax
 589:	89 04 24             	mov    %eax,(%esp)
 58c:	e8 05 fe ff ff       	call   396 <putc>
          s++;
 591:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 595:	8b 45 f4             	mov    -0xc(%ebp),%eax
 598:	0f b6 00             	movzbl (%eax),%eax
 59b:	84 c0                	test   %al,%al
 59d:	75 da                	jne    579 <printf+0x103>
 59f:	eb 68                	jmp    609 <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5a1:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 5a5:	75 1d                	jne    5c4 <printf+0x14e>
        putc(fd, *ap);
 5a7:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5aa:	8b 00                	mov    (%eax),%eax
 5ac:	0f be c0             	movsbl %al,%eax
 5af:	89 44 24 04          	mov    %eax,0x4(%esp)
 5b3:	8b 45 08             	mov    0x8(%ebp),%eax
 5b6:	89 04 24             	mov    %eax,(%esp)
 5b9:	e8 d8 fd ff ff       	call   396 <putc>
        ap++;
 5be:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5c2:	eb 45                	jmp    609 <printf+0x193>
      } else if(c == '%'){
 5c4:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 5c8:	75 17                	jne    5e1 <printf+0x16b>
        putc(fd, c);
 5ca:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5cd:	0f be c0             	movsbl %al,%eax
 5d0:	89 44 24 04          	mov    %eax,0x4(%esp)
 5d4:	8b 45 08             	mov    0x8(%ebp),%eax
 5d7:	89 04 24             	mov    %eax,(%esp)
 5da:	e8 b7 fd ff ff       	call   396 <putc>
 5df:	eb 28                	jmp    609 <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5e1:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 5e8:	00 
 5e9:	8b 45 08             	mov    0x8(%ebp),%eax
 5ec:	89 04 24             	mov    %eax,(%esp)
 5ef:	e8 a2 fd ff ff       	call   396 <putc>
        putc(fd, c);
 5f4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5f7:	0f be c0             	movsbl %al,%eax
 5fa:	89 44 24 04          	mov    %eax,0x4(%esp)
 5fe:	8b 45 08             	mov    0x8(%ebp),%eax
 601:	89 04 24             	mov    %eax,(%esp)
 604:	e8 8d fd ff ff       	call   396 <putc>
      }
      state = 0;
 609:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 610:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 614:	8b 55 0c             	mov    0xc(%ebp),%edx
 617:	8b 45 f0             	mov    -0x10(%ebp),%eax
 61a:	01 d0                	add    %edx,%eax
 61c:	0f b6 00             	movzbl (%eax),%eax
 61f:	84 c0                	test   %al,%al
 621:	0f 85 71 fe ff ff    	jne    498 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 627:	c9                   	leave  
 628:	c3                   	ret    

00000629 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 629:	55                   	push   %ebp
 62a:	89 e5                	mov    %esp,%ebp
 62c:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 62f:	8b 45 08             	mov    0x8(%ebp),%eax
 632:	83 e8 08             	sub    $0x8,%eax
 635:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 638:	a1 f8 0a 00 00       	mov    0xaf8,%eax
 63d:	89 45 fc             	mov    %eax,-0x4(%ebp)
 640:	eb 24                	jmp    666 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 642:	8b 45 fc             	mov    -0x4(%ebp),%eax
 645:	8b 00                	mov    (%eax),%eax
 647:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 64a:	77 12                	ja     65e <free+0x35>
 64c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 64f:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 652:	77 24                	ja     678 <free+0x4f>
 654:	8b 45 fc             	mov    -0x4(%ebp),%eax
 657:	8b 00                	mov    (%eax),%eax
 659:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 65c:	77 1a                	ja     678 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 65e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 661:	8b 00                	mov    (%eax),%eax
 663:	89 45 fc             	mov    %eax,-0x4(%ebp)
 666:	8b 45 f8             	mov    -0x8(%ebp),%eax
 669:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 66c:	76 d4                	jbe    642 <free+0x19>
 66e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 671:	8b 00                	mov    (%eax),%eax
 673:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 676:	76 ca                	jbe    642 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 678:	8b 45 f8             	mov    -0x8(%ebp),%eax
 67b:	8b 40 04             	mov    0x4(%eax),%eax
 67e:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 685:	8b 45 f8             	mov    -0x8(%ebp),%eax
 688:	01 c2                	add    %eax,%edx
 68a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 68d:	8b 00                	mov    (%eax),%eax
 68f:	39 c2                	cmp    %eax,%edx
 691:	75 24                	jne    6b7 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 693:	8b 45 f8             	mov    -0x8(%ebp),%eax
 696:	8b 50 04             	mov    0x4(%eax),%edx
 699:	8b 45 fc             	mov    -0x4(%ebp),%eax
 69c:	8b 00                	mov    (%eax),%eax
 69e:	8b 40 04             	mov    0x4(%eax),%eax
 6a1:	01 c2                	add    %eax,%edx
 6a3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6a6:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 6a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ac:	8b 00                	mov    (%eax),%eax
 6ae:	8b 10                	mov    (%eax),%edx
 6b0:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6b3:	89 10                	mov    %edx,(%eax)
 6b5:	eb 0a                	jmp    6c1 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 6b7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ba:	8b 10                	mov    (%eax),%edx
 6bc:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6bf:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 6c1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6c4:	8b 40 04             	mov    0x4(%eax),%eax
 6c7:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6ce:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6d1:	01 d0                	add    %edx,%eax
 6d3:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6d6:	75 20                	jne    6f8 <free+0xcf>
    p->s.size += bp->s.size;
 6d8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6db:	8b 50 04             	mov    0x4(%eax),%edx
 6de:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6e1:	8b 40 04             	mov    0x4(%eax),%eax
 6e4:	01 c2                	add    %eax,%edx
 6e6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6e9:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 6ec:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6ef:	8b 10                	mov    (%eax),%edx
 6f1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6f4:	89 10                	mov    %edx,(%eax)
 6f6:	eb 08                	jmp    700 <free+0xd7>
  } else
    p->s.ptr = bp;
 6f8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6fb:	8b 55 f8             	mov    -0x8(%ebp),%edx
 6fe:	89 10                	mov    %edx,(%eax)
  freep = p;
 700:	8b 45 fc             	mov    -0x4(%ebp),%eax
 703:	a3 f8 0a 00 00       	mov    %eax,0xaf8
}
 708:	c9                   	leave  
 709:	c3                   	ret    

0000070a <morecore>:

static Header*
morecore(uint nu)
{
 70a:	55                   	push   %ebp
 70b:	89 e5                	mov    %esp,%ebp
 70d:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 710:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 717:	77 07                	ja     720 <morecore+0x16>
    nu = 4096;
 719:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 720:	8b 45 08             	mov    0x8(%ebp),%eax
 723:	c1 e0 03             	shl    $0x3,%eax
 726:	89 04 24             	mov    %eax,(%esp)
 729:	e8 40 fc ff ff       	call   36e <sbrk>
 72e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 731:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 735:	75 07                	jne    73e <morecore+0x34>
    return 0;
 737:	b8 00 00 00 00       	mov    $0x0,%eax
 73c:	eb 22                	jmp    760 <morecore+0x56>
  hp = (Header*)p;
 73e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 741:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 744:	8b 45 f0             	mov    -0x10(%ebp),%eax
 747:	8b 55 08             	mov    0x8(%ebp),%edx
 74a:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 74d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 750:	83 c0 08             	add    $0x8,%eax
 753:	89 04 24             	mov    %eax,(%esp)
 756:	e8 ce fe ff ff       	call   629 <free>
  return freep;
 75b:	a1 f8 0a 00 00       	mov    0xaf8,%eax
}
 760:	c9                   	leave  
 761:	c3                   	ret    

00000762 <malloc>:

void*
malloc(uint nbytes)
{
 762:	55                   	push   %ebp
 763:	89 e5                	mov    %esp,%ebp
 765:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 768:	8b 45 08             	mov    0x8(%ebp),%eax
 76b:	83 c0 07             	add    $0x7,%eax
 76e:	c1 e8 03             	shr    $0x3,%eax
 771:	83 c0 01             	add    $0x1,%eax
 774:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 777:	a1 f8 0a 00 00       	mov    0xaf8,%eax
 77c:	89 45 f0             	mov    %eax,-0x10(%ebp)
 77f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 783:	75 23                	jne    7a8 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 785:	c7 45 f0 f0 0a 00 00 	movl   $0xaf0,-0x10(%ebp)
 78c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 78f:	a3 f8 0a 00 00       	mov    %eax,0xaf8
 794:	a1 f8 0a 00 00       	mov    0xaf8,%eax
 799:	a3 f0 0a 00 00       	mov    %eax,0xaf0
    base.s.size = 0;
 79e:	c7 05 f4 0a 00 00 00 	movl   $0x0,0xaf4
 7a5:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7a8:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7ab:	8b 00                	mov    (%eax),%eax
 7ad:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 7b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7b3:	8b 40 04             	mov    0x4(%eax),%eax
 7b6:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7b9:	72 4d                	jb     808 <malloc+0xa6>
      if(p->s.size == nunits)
 7bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7be:	8b 40 04             	mov    0x4(%eax),%eax
 7c1:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7c4:	75 0c                	jne    7d2 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 7c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7c9:	8b 10                	mov    (%eax),%edx
 7cb:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7ce:	89 10                	mov    %edx,(%eax)
 7d0:	eb 26                	jmp    7f8 <malloc+0x96>
      else {
        p->s.size -= nunits;
 7d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7d5:	8b 40 04             	mov    0x4(%eax),%eax
 7d8:	2b 45 ec             	sub    -0x14(%ebp),%eax
 7db:	89 c2                	mov    %eax,%edx
 7dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7e0:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 7e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7e6:	8b 40 04             	mov    0x4(%eax),%eax
 7e9:	c1 e0 03             	shl    $0x3,%eax
 7ec:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 7ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7f2:	8b 55 ec             	mov    -0x14(%ebp),%edx
 7f5:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 7f8:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7fb:	a3 f8 0a 00 00       	mov    %eax,0xaf8
      return (void*)(p + 1);
 800:	8b 45 f4             	mov    -0xc(%ebp),%eax
 803:	83 c0 08             	add    $0x8,%eax
 806:	eb 38                	jmp    840 <malloc+0xde>
    }
    if(p == freep)
 808:	a1 f8 0a 00 00       	mov    0xaf8,%eax
 80d:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 810:	75 1b                	jne    82d <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 812:	8b 45 ec             	mov    -0x14(%ebp),%eax
 815:	89 04 24             	mov    %eax,(%esp)
 818:	e8 ed fe ff ff       	call   70a <morecore>
 81d:	89 45 f4             	mov    %eax,-0xc(%ebp)
 820:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 824:	75 07                	jne    82d <malloc+0xcb>
        return 0;
 826:	b8 00 00 00 00       	mov    $0x0,%eax
 82b:	eb 13                	jmp    840 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 82d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 830:	89 45 f0             	mov    %eax,-0x10(%ebp)
 833:	8b 45 f4             	mov    -0xc(%ebp),%eax
 836:	8b 00                	mov    (%eax),%eax
 838:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 83b:	e9 70 ff ff ff       	jmp    7b0 <malloc+0x4e>
}
 840:	c9                   	leave  
 841:	c3                   	ret    
