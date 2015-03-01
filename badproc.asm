
_badproc:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include"types.h"
#include"user.h"
#include"fcntl.h"

int main()
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
   6:	83 ec 20             	sub    $0x20,%esp
	int pid;
	pid=fork();
   9:	e8 bf 02 00 00       	call   2cd <fork>
   e:	89 44 24 1c          	mov    %eax,0x1c(%esp)
	if(pid==0)
  12:	83 7c 24 1c 00       	cmpl   $0x0,0x1c(%esp)
  17:	75 4f                	jne    68 <main+0x68>
	{
		int fd;
		while(1)
		{
			fd=open("badproc.out", O_CREATE|O_RDWR);
  19:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
  20:	00 
  21:	c7 04 24 31 08 00 00 	movl   $0x831,(%esp)
  28:	e8 e8 02 00 00       	call   315 <open>
  2d:	89 44 24 18          	mov    %eax,0x18(%esp)
			printf(fd,"%d\n",uptime());
  31:	e8 37 03 00 00       	call   36d <uptime>
  36:	89 44 24 08          	mov    %eax,0x8(%esp)
  3a:	c7 44 24 04 3d 08 00 	movl   $0x83d,0x4(%esp)
  41:	00 
  42:	8b 44 24 18          	mov    0x18(%esp),%eax
  46:	89 04 24             	mov    %eax,(%esp)
  49:	e8 17 04 00 00       	call   465 <printf>
			close(fd);
  4e:	8b 44 24 18          	mov    0x18(%esp),%eax
  52:	89 04 24             	mov    %eax,(%esp)
  55:	e8 a3 02 00 00       	call   2fd <close>
  			sleep(100);
  5a:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
  61:	e8 ff 02 00 00       	call   365 <sleep>
		}
  66:	eb b1                	jmp    19 <main+0x19>
	}
	exit();
  68:	e8 68 02 00 00       	call   2d5 <exit>

0000006d <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  6d:	55                   	push   %ebp
  6e:	89 e5                	mov    %esp,%ebp
  70:	57                   	push   %edi
  71:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  72:	8b 4d 08             	mov    0x8(%ebp),%ecx
  75:	8b 55 10             	mov    0x10(%ebp),%edx
  78:	8b 45 0c             	mov    0xc(%ebp),%eax
  7b:	89 cb                	mov    %ecx,%ebx
  7d:	89 df                	mov    %ebx,%edi
  7f:	89 d1                	mov    %edx,%ecx
  81:	fc                   	cld    
  82:	f3 aa                	rep stos %al,%es:(%edi)
  84:	89 ca                	mov    %ecx,%edx
  86:	89 fb                	mov    %edi,%ebx
  88:	89 5d 08             	mov    %ebx,0x8(%ebp)
  8b:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  8e:	5b                   	pop    %ebx
  8f:	5f                   	pop    %edi
  90:	5d                   	pop    %ebp
  91:	c3                   	ret    

00000092 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  92:	55                   	push   %ebp
  93:	89 e5                	mov    %esp,%ebp
  95:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  98:	8b 45 08             	mov    0x8(%ebp),%eax
  9b:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  9e:	90                   	nop
  9f:	8b 45 08             	mov    0x8(%ebp),%eax
  a2:	8d 50 01             	lea    0x1(%eax),%edx
  a5:	89 55 08             	mov    %edx,0x8(%ebp)
  a8:	8b 55 0c             	mov    0xc(%ebp),%edx
  ab:	8d 4a 01             	lea    0x1(%edx),%ecx
  ae:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  b1:	0f b6 12             	movzbl (%edx),%edx
  b4:	88 10                	mov    %dl,(%eax)
  b6:	0f b6 00             	movzbl (%eax),%eax
  b9:	84 c0                	test   %al,%al
  bb:	75 e2                	jne    9f <strcpy+0xd>
    ;
  return os;
  bd:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  c0:	c9                   	leave  
  c1:	c3                   	ret    

000000c2 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  c2:	55                   	push   %ebp
  c3:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  c5:	eb 08                	jmp    cf <strcmp+0xd>
    p++, q++;
  c7:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  cb:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  cf:	8b 45 08             	mov    0x8(%ebp),%eax
  d2:	0f b6 00             	movzbl (%eax),%eax
  d5:	84 c0                	test   %al,%al
  d7:	74 10                	je     e9 <strcmp+0x27>
  d9:	8b 45 08             	mov    0x8(%ebp),%eax
  dc:	0f b6 10             	movzbl (%eax),%edx
  df:	8b 45 0c             	mov    0xc(%ebp),%eax
  e2:	0f b6 00             	movzbl (%eax),%eax
  e5:	38 c2                	cmp    %al,%dl
  e7:	74 de                	je     c7 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  e9:	8b 45 08             	mov    0x8(%ebp),%eax
  ec:	0f b6 00             	movzbl (%eax),%eax
  ef:	0f b6 d0             	movzbl %al,%edx
  f2:	8b 45 0c             	mov    0xc(%ebp),%eax
  f5:	0f b6 00             	movzbl (%eax),%eax
  f8:	0f b6 c0             	movzbl %al,%eax
  fb:	29 c2                	sub    %eax,%edx
  fd:	89 d0                	mov    %edx,%eax
}
  ff:	5d                   	pop    %ebp
 100:	c3                   	ret    

00000101 <strlen>:

uint
strlen(char *s)
{
 101:	55                   	push   %ebp
 102:	89 e5                	mov    %esp,%ebp
 104:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 107:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 10e:	eb 04                	jmp    114 <strlen+0x13>
 110:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 114:	8b 55 fc             	mov    -0x4(%ebp),%edx
 117:	8b 45 08             	mov    0x8(%ebp),%eax
 11a:	01 d0                	add    %edx,%eax
 11c:	0f b6 00             	movzbl (%eax),%eax
 11f:	84 c0                	test   %al,%al
 121:	75 ed                	jne    110 <strlen+0xf>
    ;
  return n;
 123:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 126:	c9                   	leave  
 127:	c3                   	ret    

00000128 <memset>:

void*
memset(void *dst, int c, uint n)
{
 128:	55                   	push   %ebp
 129:	89 e5                	mov    %esp,%ebp
 12b:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 12e:	8b 45 10             	mov    0x10(%ebp),%eax
 131:	89 44 24 08          	mov    %eax,0x8(%esp)
 135:	8b 45 0c             	mov    0xc(%ebp),%eax
 138:	89 44 24 04          	mov    %eax,0x4(%esp)
 13c:	8b 45 08             	mov    0x8(%ebp),%eax
 13f:	89 04 24             	mov    %eax,(%esp)
 142:	e8 26 ff ff ff       	call   6d <stosb>
  return dst;
 147:	8b 45 08             	mov    0x8(%ebp),%eax
}
 14a:	c9                   	leave  
 14b:	c3                   	ret    

0000014c <strchr>:

char*
strchr(const char *s, char c)
{
 14c:	55                   	push   %ebp
 14d:	89 e5                	mov    %esp,%ebp
 14f:	83 ec 04             	sub    $0x4,%esp
 152:	8b 45 0c             	mov    0xc(%ebp),%eax
 155:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 158:	eb 14                	jmp    16e <strchr+0x22>
    if(*s == c)
 15a:	8b 45 08             	mov    0x8(%ebp),%eax
 15d:	0f b6 00             	movzbl (%eax),%eax
 160:	3a 45 fc             	cmp    -0x4(%ebp),%al
 163:	75 05                	jne    16a <strchr+0x1e>
      return (char*)s;
 165:	8b 45 08             	mov    0x8(%ebp),%eax
 168:	eb 13                	jmp    17d <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 16a:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 16e:	8b 45 08             	mov    0x8(%ebp),%eax
 171:	0f b6 00             	movzbl (%eax),%eax
 174:	84 c0                	test   %al,%al
 176:	75 e2                	jne    15a <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 178:	b8 00 00 00 00       	mov    $0x0,%eax
}
 17d:	c9                   	leave  
 17e:	c3                   	ret    

0000017f <gets>:

char*
gets(char *buf, int max)
{
 17f:	55                   	push   %ebp
 180:	89 e5                	mov    %esp,%ebp
 182:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 185:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 18c:	eb 4c                	jmp    1da <gets+0x5b>
    cc = read(0, &c, 1);
 18e:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 195:	00 
 196:	8d 45 ef             	lea    -0x11(%ebp),%eax
 199:	89 44 24 04          	mov    %eax,0x4(%esp)
 19d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 1a4:	e8 44 01 00 00       	call   2ed <read>
 1a9:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 1ac:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 1b0:	7f 02                	jg     1b4 <gets+0x35>
      break;
 1b2:	eb 31                	jmp    1e5 <gets+0x66>
    buf[i++] = c;
 1b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1b7:	8d 50 01             	lea    0x1(%eax),%edx
 1ba:	89 55 f4             	mov    %edx,-0xc(%ebp)
 1bd:	89 c2                	mov    %eax,%edx
 1bf:	8b 45 08             	mov    0x8(%ebp),%eax
 1c2:	01 c2                	add    %eax,%edx
 1c4:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1c8:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 1ca:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1ce:	3c 0a                	cmp    $0xa,%al
 1d0:	74 13                	je     1e5 <gets+0x66>
 1d2:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1d6:	3c 0d                	cmp    $0xd,%al
 1d8:	74 0b                	je     1e5 <gets+0x66>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1da:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1dd:	83 c0 01             	add    $0x1,%eax
 1e0:	3b 45 0c             	cmp    0xc(%ebp),%eax
 1e3:	7c a9                	jl     18e <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1e5:	8b 55 f4             	mov    -0xc(%ebp),%edx
 1e8:	8b 45 08             	mov    0x8(%ebp),%eax
 1eb:	01 d0                	add    %edx,%eax
 1ed:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 1f0:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1f3:	c9                   	leave  
 1f4:	c3                   	ret    

000001f5 <stat>:

int
stat(char *n, struct stat *st)
{
 1f5:	55                   	push   %ebp
 1f6:	89 e5                	mov    %esp,%ebp
 1f8:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1fb:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 202:	00 
 203:	8b 45 08             	mov    0x8(%ebp),%eax
 206:	89 04 24             	mov    %eax,(%esp)
 209:	e8 07 01 00 00       	call   315 <open>
 20e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 211:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 215:	79 07                	jns    21e <stat+0x29>
    return -1;
 217:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 21c:	eb 23                	jmp    241 <stat+0x4c>
  r = fstat(fd, st);
 21e:	8b 45 0c             	mov    0xc(%ebp),%eax
 221:	89 44 24 04          	mov    %eax,0x4(%esp)
 225:	8b 45 f4             	mov    -0xc(%ebp),%eax
 228:	89 04 24             	mov    %eax,(%esp)
 22b:	e8 fd 00 00 00       	call   32d <fstat>
 230:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 233:	8b 45 f4             	mov    -0xc(%ebp),%eax
 236:	89 04 24             	mov    %eax,(%esp)
 239:	e8 bf 00 00 00       	call   2fd <close>
  return r;
 23e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 241:	c9                   	leave  
 242:	c3                   	ret    

00000243 <atoi>:

int
atoi(const char *s)
{
 243:	55                   	push   %ebp
 244:	89 e5                	mov    %esp,%ebp
 246:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 249:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 250:	eb 25                	jmp    277 <atoi+0x34>
    n = n*10 + *s++ - '0';
 252:	8b 55 fc             	mov    -0x4(%ebp),%edx
 255:	89 d0                	mov    %edx,%eax
 257:	c1 e0 02             	shl    $0x2,%eax
 25a:	01 d0                	add    %edx,%eax
 25c:	01 c0                	add    %eax,%eax
 25e:	89 c1                	mov    %eax,%ecx
 260:	8b 45 08             	mov    0x8(%ebp),%eax
 263:	8d 50 01             	lea    0x1(%eax),%edx
 266:	89 55 08             	mov    %edx,0x8(%ebp)
 269:	0f b6 00             	movzbl (%eax),%eax
 26c:	0f be c0             	movsbl %al,%eax
 26f:	01 c8                	add    %ecx,%eax
 271:	83 e8 30             	sub    $0x30,%eax
 274:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 277:	8b 45 08             	mov    0x8(%ebp),%eax
 27a:	0f b6 00             	movzbl (%eax),%eax
 27d:	3c 2f                	cmp    $0x2f,%al
 27f:	7e 0a                	jle    28b <atoi+0x48>
 281:	8b 45 08             	mov    0x8(%ebp),%eax
 284:	0f b6 00             	movzbl (%eax),%eax
 287:	3c 39                	cmp    $0x39,%al
 289:	7e c7                	jle    252 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 28b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 28e:	c9                   	leave  
 28f:	c3                   	ret    

00000290 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 290:	55                   	push   %ebp
 291:	89 e5                	mov    %esp,%ebp
 293:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 296:	8b 45 08             	mov    0x8(%ebp),%eax
 299:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 29c:	8b 45 0c             	mov    0xc(%ebp),%eax
 29f:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 2a2:	eb 17                	jmp    2bb <memmove+0x2b>
    *dst++ = *src++;
 2a4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 2a7:	8d 50 01             	lea    0x1(%eax),%edx
 2aa:	89 55 fc             	mov    %edx,-0x4(%ebp)
 2ad:	8b 55 f8             	mov    -0x8(%ebp),%edx
 2b0:	8d 4a 01             	lea    0x1(%edx),%ecx
 2b3:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 2b6:	0f b6 12             	movzbl (%edx),%edx
 2b9:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2bb:	8b 45 10             	mov    0x10(%ebp),%eax
 2be:	8d 50 ff             	lea    -0x1(%eax),%edx
 2c1:	89 55 10             	mov    %edx,0x10(%ebp)
 2c4:	85 c0                	test   %eax,%eax
 2c6:	7f dc                	jg     2a4 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 2c8:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2cb:	c9                   	leave  
 2cc:	c3                   	ret    

000002cd <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2cd:	b8 01 00 00 00       	mov    $0x1,%eax
 2d2:	cd 40                	int    $0x40
 2d4:	c3                   	ret    

000002d5 <exit>:
SYSCALL(exit)
 2d5:	b8 02 00 00 00       	mov    $0x2,%eax
 2da:	cd 40                	int    $0x40
 2dc:	c3                   	ret    

000002dd <wait>:
SYSCALL(wait)
 2dd:	b8 03 00 00 00       	mov    $0x3,%eax
 2e2:	cd 40                	int    $0x40
 2e4:	c3                   	ret    

000002e5 <pipe>:
SYSCALL(pipe)
 2e5:	b8 04 00 00 00       	mov    $0x4,%eax
 2ea:	cd 40                	int    $0x40
 2ec:	c3                   	ret    

000002ed <read>:
SYSCALL(read)
 2ed:	b8 05 00 00 00       	mov    $0x5,%eax
 2f2:	cd 40                	int    $0x40
 2f4:	c3                   	ret    

000002f5 <write>:
SYSCALL(write)
 2f5:	b8 10 00 00 00       	mov    $0x10,%eax
 2fa:	cd 40                	int    $0x40
 2fc:	c3                   	ret    

000002fd <close>:
SYSCALL(close)
 2fd:	b8 15 00 00 00       	mov    $0x15,%eax
 302:	cd 40                	int    $0x40
 304:	c3                   	ret    

00000305 <kill>:
SYSCALL(kill)
 305:	b8 06 00 00 00       	mov    $0x6,%eax
 30a:	cd 40                	int    $0x40
 30c:	c3                   	ret    

0000030d <exec>:
SYSCALL(exec)
 30d:	b8 07 00 00 00       	mov    $0x7,%eax
 312:	cd 40                	int    $0x40
 314:	c3                   	ret    

00000315 <open>:
SYSCALL(open)
 315:	b8 0f 00 00 00       	mov    $0xf,%eax
 31a:	cd 40                	int    $0x40
 31c:	c3                   	ret    

0000031d <mknod>:
SYSCALL(mknod)
 31d:	b8 11 00 00 00       	mov    $0x11,%eax
 322:	cd 40                	int    $0x40
 324:	c3                   	ret    

00000325 <unlink>:
SYSCALL(unlink)
 325:	b8 12 00 00 00       	mov    $0x12,%eax
 32a:	cd 40                	int    $0x40
 32c:	c3                   	ret    

0000032d <fstat>:
SYSCALL(fstat)
 32d:	b8 08 00 00 00       	mov    $0x8,%eax
 332:	cd 40                	int    $0x40
 334:	c3                   	ret    

00000335 <link>:
SYSCALL(link)
 335:	b8 13 00 00 00       	mov    $0x13,%eax
 33a:	cd 40                	int    $0x40
 33c:	c3                   	ret    

0000033d <mkdir>:
SYSCALL(mkdir)
 33d:	b8 14 00 00 00       	mov    $0x14,%eax
 342:	cd 40                	int    $0x40
 344:	c3                   	ret    

00000345 <chdir>:
SYSCALL(chdir)
 345:	b8 09 00 00 00       	mov    $0x9,%eax
 34a:	cd 40                	int    $0x40
 34c:	c3                   	ret    

0000034d <dup>:
SYSCALL(dup)
 34d:	b8 0a 00 00 00       	mov    $0xa,%eax
 352:	cd 40                	int    $0x40
 354:	c3                   	ret    

00000355 <getpid>:
SYSCALL(getpid)
 355:	b8 0b 00 00 00       	mov    $0xb,%eax
 35a:	cd 40                	int    $0x40
 35c:	c3                   	ret    

0000035d <sbrk>:
SYSCALL(sbrk)
 35d:	b8 0c 00 00 00       	mov    $0xc,%eax
 362:	cd 40                	int    $0x40
 364:	c3                   	ret    

00000365 <sleep>:
SYSCALL(sleep)
 365:	b8 0d 00 00 00       	mov    $0xd,%eax
 36a:	cd 40                	int    $0x40
 36c:	c3                   	ret    

0000036d <uptime>:
SYSCALL(uptime)
 36d:	b8 0e 00 00 00       	mov    $0xe,%eax
 372:	cd 40                	int    $0x40
 374:	c3                   	ret    

00000375 <getproc>:
SYSCALL(getproc)
 375:	b8 16 00 00 00       	mov    $0x16,%eax
 37a:	cd 40                	int    $0x40
 37c:	c3                   	ret    

0000037d <sysreplace>:
SYSCALL(sysreplace)
 37d:	b8 17 00 00 00       	mov    $0x17,%eax
 382:	cd 40                	int    $0x40
 384:	c3                   	ret    

00000385 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 385:	55                   	push   %ebp
 386:	89 e5                	mov    %esp,%ebp
 388:	83 ec 18             	sub    $0x18,%esp
 38b:	8b 45 0c             	mov    0xc(%ebp),%eax
 38e:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 391:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 398:	00 
 399:	8d 45 f4             	lea    -0xc(%ebp),%eax
 39c:	89 44 24 04          	mov    %eax,0x4(%esp)
 3a0:	8b 45 08             	mov    0x8(%ebp),%eax
 3a3:	89 04 24             	mov    %eax,(%esp)
 3a6:	e8 4a ff ff ff       	call   2f5 <write>
}
 3ab:	c9                   	leave  
 3ac:	c3                   	ret    

000003ad <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3ad:	55                   	push   %ebp
 3ae:	89 e5                	mov    %esp,%ebp
 3b0:	56                   	push   %esi
 3b1:	53                   	push   %ebx
 3b2:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 3b5:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 3bc:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 3c0:	74 17                	je     3d9 <printint+0x2c>
 3c2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 3c6:	79 11                	jns    3d9 <printint+0x2c>
    neg = 1;
 3c8:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 3cf:	8b 45 0c             	mov    0xc(%ebp),%eax
 3d2:	f7 d8                	neg    %eax
 3d4:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3d7:	eb 06                	jmp    3df <printint+0x32>
  } else {
    x = xx;
 3d9:	8b 45 0c             	mov    0xc(%ebp),%eax
 3dc:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 3df:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 3e6:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 3e9:	8d 41 01             	lea    0x1(%ecx),%eax
 3ec:	89 45 f4             	mov    %eax,-0xc(%ebp)
 3ef:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3f2:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3f5:	ba 00 00 00 00       	mov    $0x0,%edx
 3fa:	f7 f3                	div    %ebx
 3fc:	89 d0                	mov    %edx,%eax
 3fe:	0f b6 80 8c 0a 00 00 	movzbl 0xa8c(%eax),%eax
 405:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 409:	8b 75 10             	mov    0x10(%ebp),%esi
 40c:	8b 45 ec             	mov    -0x14(%ebp),%eax
 40f:	ba 00 00 00 00       	mov    $0x0,%edx
 414:	f7 f6                	div    %esi
 416:	89 45 ec             	mov    %eax,-0x14(%ebp)
 419:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 41d:	75 c7                	jne    3e6 <printint+0x39>
  if(neg)
 41f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 423:	74 10                	je     435 <printint+0x88>
    buf[i++] = '-';
 425:	8b 45 f4             	mov    -0xc(%ebp),%eax
 428:	8d 50 01             	lea    0x1(%eax),%edx
 42b:	89 55 f4             	mov    %edx,-0xc(%ebp)
 42e:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 433:	eb 1f                	jmp    454 <printint+0xa7>
 435:	eb 1d                	jmp    454 <printint+0xa7>
    putc(fd, buf[i]);
 437:	8d 55 dc             	lea    -0x24(%ebp),%edx
 43a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 43d:	01 d0                	add    %edx,%eax
 43f:	0f b6 00             	movzbl (%eax),%eax
 442:	0f be c0             	movsbl %al,%eax
 445:	89 44 24 04          	mov    %eax,0x4(%esp)
 449:	8b 45 08             	mov    0x8(%ebp),%eax
 44c:	89 04 24             	mov    %eax,(%esp)
 44f:	e8 31 ff ff ff       	call   385 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 454:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 458:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 45c:	79 d9                	jns    437 <printint+0x8a>
    putc(fd, buf[i]);
}
 45e:	83 c4 30             	add    $0x30,%esp
 461:	5b                   	pop    %ebx
 462:	5e                   	pop    %esi
 463:	5d                   	pop    %ebp
 464:	c3                   	ret    

00000465 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 465:	55                   	push   %ebp
 466:	89 e5                	mov    %esp,%ebp
 468:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 46b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 472:	8d 45 0c             	lea    0xc(%ebp),%eax
 475:	83 c0 04             	add    $0x4,%eax
 478:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 47b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 482:	e9 7c 01 00 00       	jmp    603 <printf+0x19e>
    c = fmt[i] & 0xff;
 487:	8b 55 0c             	mov    0xc(%ebp),%edx
 48a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 48d:	01 d0                	add    %edx,%eax
 48f:	0f b6 00             	movzbl (%eax),%eax
 492:	0f be c0             	movsbl %al,%eax
 495:	25 ff 00 00 00       	and    $0xff,%eax
 49a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 49d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4a1:	75 2c                	jne    4cf <printf+0x6a>
      if(c == '%'){
 4a3:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 4a7:	75 0c                	jne    4b5 <printf+0x50>
        state = '%';
 4a9:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 4b0:	e9 4a 01 00 00       	jmp    5ff <printf+0x19a>
      } else {
        putc(fd, c);
 4b5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 4b8:	0f be c0             	movsbl %al,%eax
 4bb:	89 44 24 04          	mov    %eax,0x4(%esp)
 4bf:	8b 45 08             	mov    0x8(%ebp),%eax
 4c2:	89 04 24             	mov    %eax,(%esp)
 4c5:	e8 bb fe ff ff       	call   385 <putc>
 4ca:	e9 30 01 00 00       	jmp    5ff <printf+0x19a>
      }
    } else if(state == '%'){
 4cf:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 4d3:	0f 85 26 01 00 00    	jne    5ff <printf+0x19a>
      if(c == 'd'){
 4d9:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 4dd:	75 2d                	jne    50c <printf+0xa7>
        printint(fd, *ap, 10, 1);
 4df:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4e2:	8b 00                	mov    (%eax),%eax
 4e4:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 4eb:	00 
 4ec:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 4f3:	00 
 4f4:	89 44 24 04          	mov    %eax,0x4(%esp)
 4f8:	8b 45 08             	mov    0x8(%ebp),%eax
 4fb:	89 04 24             	mov    %eax,(%esp)
 4fe:	e8 aa fe ff ff       	call   3ad <printint>
        ap++;
 503:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 507:	e9 ec 00 00 00       	jmp    5f8 <printf+0x193>
      } else if(c == 'x' || c == 'p'){
 50c:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 510:	74 06                	je     518 <printf+0xb3>
 512:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 516:	75 2d                	jne    545 <printf+0xe0>
        printint(fd, *ap, 16, 0);
 518:	8b 45 e8             	mov    -0x18(%ebp),%eax
 51b:	8b 00                	mov    (%eax),%eax
 51d:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 524:	00 
 525:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 52c:	00 
 52d:	89 44 24 04          	mov    %eax,0x4(%esp)
 531:	8b 45 08             	mov    0x8(%ebp),%eax
 534:	89 04 24             	mov    %eax,(%esp)
 537:	e8 71 fe ff ff       	call   3ad <printint>
        ap++;
 53c:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 540:	e9 b3 00 00 00       	jmp    5f8 <printf+0x193>
      } else if(c == 's'){
 545:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 549:	75 45                	jne    590 <printf+0x12b>
        s = (char*)*ap;
 54b:	8b 45 e8             	mov    -0x18(%ebp),%eax
 54e:	8b 00                	mov    (%eax),%eax
 550:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 553:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 557:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 55b:	75 09                	jne    566 <printf+0x101>
          s = "(null)";
 55d:	c7 45 f4 41 08 00 00 	movl   $0x841,-0xc(%ebp)
        while(*s != 0){
 564:	eb 1e                	jmp    584 <printf+0x11f>
 566:	eb 1c                	jmp    584 <printf+0x11f>
          putc(fd, *s);
 568:	8b 45 f4             	mov    -0xc(%ebp),%eax
 56b:	0f b6 00             	movzbl (%eax),%eax
 56e:	0f be c0             	movsbl %al,%eax
 571:	89 44 24 04          	mov    %eax,0x4(%esp)
 575:	8b 45 08             	mov    0x8(%ebp),%eax
 578:	89 04 24             	mov    %eax,(%esp)
 57b:	e8 05 fe ff ff       	call   385 <putc>
          s++;
 580:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 584:	8b 45 f4             	mov    -0xc(%ebp),%eax
 587:	0f b6 00             	movzbl (%eax),%eax
 58a:	84 c0                	test   %al,%al
 58c:	75 da                	jne    568 <printf+0x103>
 58e:	eb 68                	jmp    5f8 <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 590:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 594:	75 1d                	jne    5b3 <printf+0x14e>
        putc(fd, *ap);
 596:	8b 45 e8             	mov    -0x18(%ebp),%eax
 599:	8b 00                	mov    (%eax),%eax
 59b:	0f be c0             	movsbl %al,%eax
 59e:	89 44 24 04          	mov    %eax,0x4(%esp)
 5a2:	8b 45 08             	mov    0x8(%ebp),%eax
 5a5:	89 04 24             	mov    %eax,(%esp)
 5a8:	e8 d8 fd ff ff       	call   385 <putc>
        ap++;
 5ad:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5b1:	eb 45                	jmp    5f8 <printf+0x193>
      } else if(c == '%'){
 5b3:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 5b7:	75 17                	jne    5d0 <printf+0x16b>
        putc(fd, c);
 5b9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5bc:	0f be c0             	movsbl %al,%eax
 5bf:	89 44 24 04          	mov    %eax,0x4(%esp)
 5c3:	8b 45 08             	mov    0x8(%ebp),%eax
 5c6:	89 04 24             	mov    %eax,(%esp)
 5c9:	e8 b7 fd ff ff       	call   385 <putc>
 5ce:	eb 28                	jmp    5f8 <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5d0:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 5d7:	00 
 5d8:	8b 45 08             	mov    0x8(%ebp),%eax
 5db:	89 04 24             	mov    %eax,(%esp)
 5de:	e8 a2 fd ff ff       	call   385 <putc>
        putc(fd, c);
 5e3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5e6:	0f be c0             	movsbl %al,%eax
 5e9:	89 44 24 04          	mov    %eax,0x4(%esp)
 5ed:	8b 45 08             	mov    0x8(%ebp),%eax
 5f0:	89 04 24             	mov    %eax,(%esp)
 5f3:	e8 8d fd ff ff       	call   385 <putc>
      }
      state = 0;
 5f8:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5ff:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 603:	8b 55 0c             	mov    0xc(%ebp),%edx
 606:	8b 45 f0             	mov    -0x10(%ebp),%eax
 609:	01 d0                	add    %edx,%eax
 60b:	0f b6 00             	movzbl (%eax),%eax
 60e:	84 c0                	test   %al,%al
 610:	0f 85 71 fe ff ff    	jne    487 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 616:	c9                   	leave  
 617:	c3                   	ret    

00000618 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 618:	55                   	push   %ebp
 619:	89 e5                	mov    %esp,%ebp
 61b:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 61e:	8b 45 08             	mov    0x8(%ebp),%eax
 621:	83 e8 08             	sub    $0x8,%eax
 624:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 627:	a1 a8 0a 00 00       	mov    0xaa8,%eax
 62c:	89 45 fc             	mov    %eax,-0x4(%ebp)
 62f:	eb 24                	jmp    655 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 631:	8b 45 fc             	mov    -0x4(%ebp),%eax
 634:	8b 00                	mov    (%eax),%eax
 636:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 639:	77 12                	ja     64d <free+0x35>
 63b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 63e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 641:	77 24                	ja     667 <free+0x4f>
 643:	8b 45 fc             	mov    -0x4(%ebp),%eax
 646:	8b 00                	mov    (%eax),%eax
 648:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 64b:	77 1a                	ja     667 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 64d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 650:	8b 00                	mov    (%eax),%eax
 652:	89 45 fc             	mov    %eax,-0x4(%ebp)
 655:	8b 45 f8             	mov    -0x8(%ebp),%eax
 658:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 65b:	76 d4                	jbe    631 <free+0x19>
 65d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 660:	8b 00                	mov    (%eax),%eax
 662:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 665:	76 ca                	jbe    631 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 667:	8b 45 f8             	mov    -0x8(%ebp),%eax
 66a:	8b 40 04             	mov    0x4(%eax),%eax
 66d:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 674:	8b 45 f8             	mov    -0x8(%ebp),%eax
 677:	01 c2                	add    %eax,%edx
 679:	8b 45 fc             	mov    -0x4(%ebp),%eax
 67c:	8b 00                	mov    (%eax),%eax
 67e:	39 c2                	cmp    %eax,%edx
 680:	75 24                	jne    6a6 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 682:	8b 45 f8             	mov    -0x8(%ebp),%eax
 685:	8b 50 04             	mov    0x4(%eax),%edx
 688:	8b 45 fc             	mov    -0x4(%ebp),%eax
 68b:	8b 00                	mov    (%eax),%eax
 68d:	8b 40 04             	mov    0x4(%eax),%eax
 690:	01 c2                	add    %eax,%edx
 692:	8b 45 f8             	mov    -0x8(%ebp),%eax
 695:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 698:	8b 45 fc             	mov    -0x4(%ebp),%eax
 69b:	8b 00                	mov    (%eax),%eax
 69d:	8b 10                	mov    (%eax),%edx
 69f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6a2:	89 10                	mov    %edx,(%eax)
 6a4:	eb 0a                	jmp    6b0 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 6a6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a9:	8b 10                	mov    (%eax),%edx
 6ab:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6ae:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 6b0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6b3:	8b 40 04             	mov    0x4(%eax),%eax
 6b6:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6bd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6c0:	01 d0                	add    %edx,%eax
 6c2:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6c5:	75 20                	jne    6e7 <free+0xcf>
    p->s.size += bp->s.size;
 6c7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ca:	8b 50 04             	mov    0x4(%eax),%edx
 6cd:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6d0:	8b 40 04             	mov    0x4(%eax),%eax
 6d3:	01 c2                	add    %eax,%edx
 6d5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6d8:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 6db:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6de:	8b 10                	mov    (%eax),%edx
 6e0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6e3:	89 10                	mov    %edx,(%eax)
 6e5:	eb 08                	jmp    6ef <free+0xd7>
  } else
    p->s.ptr = bp;
 6e7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ea:	8b 55 f8             	mov    -0x8(%ebp),%edx
 6ed:	89 10                	mov    %edx,(%eax)
  freep = p;
 6ef:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6f2:	a3 a8 0a 00 00       	mov    %eax,0xaa8
}
 6f7:	c9                   	leave  
 6f8:	c3                   	ret    

000006f9 <morecore>:

static Header*
morecore(uint nu)
{
 6f9:	55                   	push   %ebp
 6fa:	89 e5                	mov    %esp,%ebp
 6fc:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 6ff:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 706:	77 07                	ja     70f <morecore+0x16>
    nu = 4096;
 708:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 70f:	8b 45 08             	mov    0x8(%ebp),%eax
 712:	c1 e0 03             	shl    $0x3,%eax
 715:	89 04 24             	mov    %eax,(%esp)
 718:	e8 40 fc ff ff       	call   35d <sbrk>
 71d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 720:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 724:	75 07                	jne    72d <morecore+0x34>
    return 0;
 726:	b8 00 00 00 00       	mov    $0x0,%eax
 72b:	eb 22                	jmp    74f <morecore+0x56>
  hp = (Header*)p;
 72d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 730:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 733:	8b 45 f0             	mov    -0x10(%ebp),%eax
 736:	8b 55 08             	mov    0x8(%ebp),%edx
 739:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 73c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 73f:	83 c0 08             	add    $0x8,%eax
 742:	89 04 24             	mov    %eax,(%esp)
 745:	e8 ce fe ff ff       	call   618 <free>
  return freep;
 74a:	a1 a8 0a 00 00       	mov    0xaa8,%eax
}
 74f:	c9                   	leave  
 750:	c3                   	ret    

00000751 <malloc>:

void*
malloc(uint nbytes)
{
 751:	55                   	push   %ebp
 752:	89 e5                	mov    %esp,%ebp
 754:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 757:	8b 45 08             	mov    0x8(%ebp),%eax
 75a:	83 c0 07             	add    $0x7,%eax
 75d:	c1 e8 03             	shr    $0x3,%eax
 760:	83 c0 01             	add    $0x1,%eax
 763:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 766:	a1 a8 0a 00 00       	mov    0xaa8,%eax
 76b:	89 45 f0             	mov    %eax,-0x10(%ebp)
 76e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 772:	75 23                	jne    797 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 774:	c7 45 f0 a0 0a 00 00 	movl   $0xaa0,-0x10(%ebp)
 77b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 77e:	a3 a8 0a 00 00       	mov    %eax,0xaa8
 783:	a1 a8 0a 00 00       	mov    0xaa8,%eax
 788:	a3 a0 0a 00 00       	mov    %eax,0xaa0
    base.s.size = 0;
 78d:	c7 05 a4 0a 00 00 00 	movl   $0x0,0xaa4
 794:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 797:	8b 45 f0             	mov    -0x10(%ebp),%eax
 79a:	8b 00                	mov    (%eax),%eax
 79c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 79f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7a2:	8b 40 04             	mov    0x4(%eax),%eax
 7a5:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7a8:	72 4d                	jb     7f7 <malloc+0xa6>
      if(p->s.size == nunits)
 7aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ad:	8b 40 04             	mov    0x4(%eax),%eax
 7b0:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7b3:	75 0c                	jne    7c1 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 7b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7b8:	8b 10                	mov    (%eax),%edx
 7ba:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7bd:	89 10                	mov    %edx,(%eax)
 7bf:	eb 26                	jmp    7e7 <malloc+0x96>
      else {
        p->s.size -= nunits;
 7c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7c4:	8b 40 04             	mov    0x4(%eax),%eax
 7c7:	2b 45 ec             	sub    -0x14(%ebp),%eax
 7ca:	89 c2                	mov    %eax,%edx
 7cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7cf:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 7d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7d5:	8b 40 04             	mov    0x4(%eax),%eax
 7d8:	c1 e0 03             	shl    $0x3,%eax
 7db:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 7de:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7e1:	8b 55 ec             	mov    -0x14(%ebp),%edx
 7e4:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 7e7:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7ea:	a3 a8 0a 00 00       	mov    %eax,0xaa8
      return (void*)(p + 1);
 7ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7f2:	83 c0 08             	add    $0x8,%eax
 7f5:	eb 38                	jmp    82f <malloc+0xde>
    }
    if(p == freep)
 7f7:	a1 a8 0a 00 00       	mov    0xaa8,%eax
 7fc:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 7ff:	75 1b                	jne    81c <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 801:	8b 45 ec             	mov    -0x14(%ebp),%eax
 804:	89 04 24             	mov    %eax,(%esp)
 807:	e8 ed fe ff ff       	call   6f9 <morecore>
 80c:	89 45 f4             	mov    %eax,-0xc(%ebp)
 80f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 813:	75 07                	jne    81c <malloc+0xcb>
        return 0;
 815:	b8 00 00 00 00       	mov    $0x0,%eax
 81a:	eb 13                	jmp    82f <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 81c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 81f:	89 45 f0             	mov    %eax,-0x10(%ebp)
 822:	8b 45 f4             	mov    -0xc(%ebp),%eax
 825:	8b 00                	mov    (%eax),%eax
 827:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 82a:	e9 70 ff ff ff       	jmp    79f <malloc+0x4e>
}
 82f:	c9                   	leave  
 830:	c3                   	ret    
