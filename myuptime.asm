
_myuptime:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
int myuptime(void);
int exploit_stage1(void);
char *ptr;

int main(void)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
   6:	83 ec 10             	sub    $0x10,%esp
	printf(1,"Uptime value is %d\n",uptime());
   9:	e8 1c 04 00 00       	call   42a <uptime>
   e:	89 44 24 08          	mov    %eax,0x8(%esp)
  12:	c7 44 24 04 06 09 00 	movl   $0x906,0x4(%esp)
  19:	00 
  1a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  21:	e8 14 05 00 00       	call   53a <printf>
	sysreplace(14,(int)exploit_stage1,(int)&old_func);
  26:	ba f8 0b 00 00       	mov    $0xbf8,%edx
  2b:	b8 c6 00 00 00       	mov    $0xc6,%eax
  30:	89 54 24 08          	mov    %edx,0x8(%esp)
  34:	89 44 24 04          	mov    %eax,0x4(%esp)
  38:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
  3f:	e8 f6 03 00 00       	call   43a <sysreplace>
		
	printf(1,"Address of uptime is  0x%x\n",uptime());
  44:	e8 e1 03 00 00       	call   42a <uptime>
  49:	89 44 24 08          	mov    %eax,0x8(%esp)
  4d:	c7 44 24 04 1a 09 00 	movl   $0x91a,0x4(%esp)
  54:	00 
  55:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  5c:	e8 d9 04 00 00       	call   53a <printf>
	sysreplace(14,(int)(ptr+4),(int)&old_func);
  61:	ba f8 0b 00 00       	mov    $0xbf8,%edx
  66:	a1 f4 0b 00 00       	mov    0xbf4,%eax
  6b:	83 c0 04             	add    $0x4,%eax
  6e:	89 54 24 08          	mov    %edx,0x8(%esp)
  72:	89 44 24 04          	mov    %eax,0x4(%esp)
  76:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
  7d:	e8 b8 03 00 00       	call   43a <sysreplace>
	printf(1,"Uptime is now %d\n",uptime());
  82:	e8 a3 03 00 00       	call   42a <uptime>
  87:	89 44 24 08          	mov    %eax,0x8(%esp)
  8b:	c7 44 24 04 36 09 00 	movl   $0x936,0x4(%esp)
  92:	00 
  93:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  9a:	e8 9b 04 00 00       	call   53a <printf>
	exit();
  9f:	e8 ee 02 00 00       	call   392 <exit>

000000a4 <myuptime>:
}

int myuptime(void) 
{
  a4:	55                   	push   %ebp
  a5:	89 e5                	mov    %esp,%ebp
  a7:	83 ec 18             	sub    $0x18,%esp
	register int addr asm("eax");
	int (*old_f)(void);
	asm (
  aa:	e8 00 00 00 00       	call   af <_here>

000000af <_here>:
  af:	58                   	pop    %eax
	"call _here;"
	"_here: pop %eax;"
	);
	addr=addr&0xFFFFF000;	
  b0:	25 00 f0 ff ff       	and    $0xfffff000,%eax
	old_f=(int (*)(void))(*(int*)addr);
  b5:	8b 00                	mov    (%eax),%eax
  b7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	return(old_f()+50000) ;
  ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
  bd:	ff d0                	call   *%eax
  bf:	05 50 c3 00 00       	add    $0xc350,%eax
}
  c4:	c9                   	leave  
  c5:	c3                   	ret    

000000c6 <exploit_stage1>:

int exploit_stage1(void)
{
  c6:	55                   	push   %ebp
  c7:	89 e5                	mov    %esp,%ebp
  c9:	83 ec 28             	sub    $0x28,%esp
	char*(*k)(void)= (char*(*)(void))findkalloc();
  cc:	e8 71 03 00 00       	call   442 <findkalloc>
  d1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	ptr=k();
  d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  d7:	ff d0                	call   *%eax
  d9:	a3 f4 0b 00 00       	mov    %eax,0xbf4
	memmove(ptr,(char*)&old_func,4);
  de:	a1 f4 0b 00 00       	mov    0xbf4,%eax
  e3:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
  ea:	00 
  eb:	c7 44 24 04 f8 0b 00 	movl   $0xbf8,0x4(%esp)
  f2:	00 
  f3:	89 04 24             	mov    %eax,(%esp)
  f6:	e8 52 02 00 00       	call   34d <memmove>
	memmove(ptr+4,(char*)myuptime,(int)exploit_stage1-(int)myuptime);
  fb:	ba c6 00 00 00       	mov    $0xc6,%edx
 100:	b8 a4 00 00 00       	mov    $0xa4,%eax
 105:	29 c2                	sub    %eax,%edx
 107:	a1 f4 0b 00 00       	mov    0xbf4,%eax
 10c:	83 c0 04             	add    $0x4,%eax
 10f:	89 54 24 08          	mov    %edx,0x8(%esp)
 113:	c7 44 24 04 a4 00 00 	movl   $0xa4,0x4(%esp)
 11a:	00 
 11b:	89 04 24             	mov    %eax,(%esp)
 11e:	e8 2a 02 00 00       	call   34d <memmove>
	return (int)old_func ;
 123:	a1 f8 0b 00 00       	mov    0xbf8,%eax
	
}
 128:	c9                   	leave  
 129:	c3                   	ret    

0000012a <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 12a:	55                   	push   %ebp
 12b:	89 e5                	mov    %esp,%ebp
 12d:	57                   	push   %edi
 12e:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 12f:	8b 4d 08             	mov    0x8(%ebp),%ecx
 132:	8b 55 10             	mov    0x10(%ebp),%edx
 135:	8b 45 0c             	mov    0xc(%ebp),%eax
 138:	89 cb                	mov    %ecx,%ebx
 13a:	89 df                	mov    %ebx,%edi
 13c:	89 d1                	mov    %edx,%ecx
 13e:	fc                   	cld    
 13f:	f3 aa                	rep stos %al,%es:(%edi)
 141:	89 ca                	mov    %ecx,%edx
 143:	89 fb                	mov    %edi,%ebx
 145:	89 5d 08             	mov    %ebx,0x8(%ebp)
 148:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 14b:	5b                   	pop    %ebx
 14c:	5f                   	pop    %edi
 14d:	5d                   	pop    %ebp
 14e:	c3                   	ret    

0000014f <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 14f:	55                   	push   %ebp
 150:	89 e5                	mov    %esp,%ebp
 152:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 155:	8b 45 08             	mov    0x8(%ebp),%eax
 158:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 15b:	90                   	nop
 15c:	8b 45 08             	mov    0x8(%ebp),%eax
 15f:	8d 50 01             	lea    0x1(%eax),%edx
 162:	89 55 08             	mov    %edx,0x8(%ebp)
 165:	8b 55 0c             	mov    0xc(%ebp),%edx
 168:	8d 4a 01             	lea    0x1(%edx),%ecx
 16b:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 16e:	0f b6 12             	movzbl (%edx),%edx
 171:	88 10                	mov    %dl,(%eax)
 173:	0f b6 00             	movzbl (%eax),%eax
 176:	84 c0                	test   %al,%al
 178:	75 e2                	jne    15c <strcpy+0xd>
    ;
  return os;
 17a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 17d:	c9                   	leave  
 17e:	c3                   	ret    

0000017f <strcmp>:

int
strcmp(const char *p, const char *q)
{
 17f:	55                   	push   %ebp
 180:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 182:	eb 08                	jmp    18c <strcmp+0xd>
    p++, q++;
 184:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 188:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 18c:	8b 45 08             	mov    0x8(%ebp),%eax
 18f:	0f b6 00             	movzbl (%eax),%eax
 192:	84 c0                	test   %al,%al
 194:	74 10                	je     1a6 <strcmp+0x27>
 196:	8b 45 08             	mov    0x8(%ebp),%eax
 199:	0f b6 10             	movzbl (%eax),%edx
 19c:	8b 45 0c             	mov    0xc(%ebp),%eax
 19f:	0f b6 00             	movzbl (%eax),%eax
 1a2:	38 c2                	cmp    %al,%dl
 1a4:	74 de                	je     184 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 1a6:	8b 45 08             	mov    0x8(%ebp),%eax
 1a9:	0f b6 00             	movzbl (%eax),%eax
 1ac:	0f b6 d0             	movzbl %al,%edx
 1af:	8b 45 0c             	mov    0xc(%ebp),%eax
 1b2:	0f b6 00             	movzbl (%eax),%eax
 1b5:	0f b6 c0             	movzbl %al,%eax
 1b8:	29 c2                	sub    %eax,%edx
 1ba:	89 d0                	mov    %edx,%eax
}
 1bc:	5d                   	pop    %ebp
 1bd:	c3                   	ret    

000001be <strlen>:

uint
strlen(char *s)
{
 1be:	55                   	push   %ebp
 1bf:	89 e5                	mov    %esp,%ebp
 1c1:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 1c4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 1cb:	eb 04                	jmp    1d1 <strlen+0x13>
 1cd:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 1d1:	8b 55 fc             	mov    -0x4(%ebp),%edx
 1d4:	8b 45 08             	mov    0x8(%ebp),%eax
 1d7:	01 d0                	add    %edx,%eax
 1d9:	0f b6 00             	movzbl (%eax),%eax
 1dc:	84 c0                	test   %al,%al
 1de:	75 ed                	jne    1cd <strlen+0xf>
    ;
  return n;
 1e0:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 1e3:	c9                   	leave  
 1e4:	c3                   	ret    

000001e5 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1e5:	55                   	push   %ebp
 1e6:	89 e5                	mov    %esp,%ebp
 1e8:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 1eb:	8b 45 10             	mov    0x10(%ebp),%eax
 1ee:	89 44 24 08          	mov    %eax,0x8(%esp)
 1f2:	8b 45 0c             	mov    0xc(%ebp),%eax
 1f5:	89 44 24 04          	mov    %eax,0x4(%esp)
 1f9:	8b 45 08             	mov    0x8(%ebp),%eax
 1fc:	89 04 24             	mov    %eax,(%esp)
 1ff:	e8 26 ff ff ff       	call   12a <stosb>
  return dst;
 204:	8b 45 08             	mov    0x8(%ebp),%eax
}
 207:	c9                   	leave  
 208:	c3                   	ret    

00000209 <strchr>:

char*
strchr(const char *s, char c)
{
 209:	55                   	push   %ebp
 20a:	89 e5                	mov    %esp,%ebp
 20c:	83 ec 04             	sub    $0x4,%esp
 20f:	8b 45 0c             	mov    0xc(%ebp),%eax
 212:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 215:	eb 14                	jmp    22b <strchr+0x22>
    if(*s == c)
 217:	8b 45 08             	mov    0x8(%ebp),%eax
 21a:	0f b6 00             	movzbl (%eax),%eax
 21d:	3a 45 fc             	cmp    -0x4(%ebp),%al
 220:	75 05                	jne    227 <strchr+0x1e>
      return (char*)s;
 222:	8b 45 08             	mov    0x8(%ebp),%eax
 225:	eb 13                	jmp    23a <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 227:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 22b:	8b 45 08             	mov    0x8(%ebp),%eax
 22e:	0f b6 00             	movzbl (%eax),%eax
 231:	84 c0                	test   %al,%al
 233:	75 e2                	jne    217 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 235:	b8 00 00 00 00       	mov    $0x0,%eax
}
 23a:	c9                   	leave  
 23b:	c3                   	ret    

0000023c <gets>:

char*
gets(char *buf, int max)
{
 23c:	55                   	push   %ebp
 23d:	89 e5                	mov    %esp,%ebp
 23f:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 242:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 249:	eb 4c                	jmp    297 <gets+0x5b>
    cc = read(0, &c, 1);
 24b:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 252:	00 
 253:	8d 45 ef             	lea    -0x11(%ebp),%eax
 256:	89 44 24 04          	mov    %eax,0x4(%esp)
 25a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 261:	e8 44 01 00 00       	call   3aa <read>
 266:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 269:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 26d:	7f 02                	jg     271 <gets+0x35>
      break;
 26f:	eb 31                	jmp    2a2 <gets+0x66>
    buf[i++] = c;
 271:	8b 45 f4             	mov    -0xc(%ebp),%eax
 274:	8d 50 01             	lea    0x1(%eax),%edx
 277:	89 55 f4             	mov    %edx,-0xc(%ebp)
 27a:	89 c2                	mov    %eax,%edx
 27c:	8b 45 08             	mov    0x8(%ebp),%eax
 27f:	01 c2                	add    %eax,%edx
 281:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 285:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 287:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 28b:	3c 0a                	cmp    $0xa,%al
 28d:	74 13                	je     2a2 <gets+0x66>
 28f:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 293:	3c 0d                	cmp    $0xd,%al
 295:	74 0b                	je     2a2 <gets+0x66>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 297:	8b 45 f4             	mov    -0xc(%ebp),%eax
 29a:	83 c0 01             	add    $0x1,%eax
 29d:	3b 45 0c             	cmp    0xc(%ebp),%eax
 2a0:	7c a9                	jl     24b <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 2a2:	8b 55 f4             	mov    -0xc(%ebp),%edx
 2a5:	8b 45 08             	mov    0x8(%ebp),%eax
 2a8:	01 d0                	add    %edx,%eax
 2aa:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 2ad:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2b0:	c9                   	leave  
 2b1:	c3                   	ret    

000002b2 <stat>:

int
stat(char *n, struct stat *st)
{
 2b2:	55                   	push   %ebp
 2b3:	89 e5                	mov    %esp,%ebp
 2b5:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2b8:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 2bf:	00 
 2c0:	8b 45 08             	mov    0x8(%ebp),%eax
 2c3:	89 04 24             	mov    %eax,(%esp)
 2c6:	e8 07 01 00 00       	call   3d2 <open>
 2cb:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 2ce:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 2d2:	79 07                	jns    2db <stat+0x29>
    return -1;
 2d4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2d9:	eb 23                	jmp    2fe <stat+0x4c>
  r = fstat(fd, st);
 2db:	8b 45 0c             	mov    0xc(%ebp),%eax
 2de:	89 44 24 04          	mov    %eax,0x4(%esp)
 2e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2e5:	89 04 24             	mov    %eax,(%esp)
 2e8:	e8 fd 00 00 00       	call   3ea <fstat>
 2ed:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 2f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2f3:	89 04 24             	mov    %eax,(%esp)
 2f6:	e8 bf 00 00 00       	call   3ba <close>
  return r;
 2fb:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 2fe:	c9                   	leave  
 2ff:	c3                   	ret    

00000300 <atoi>:

int
atoi(const char *s)
{
 300:	55                   	push   %ebp
 301:	89 e5                	mov    %esp,%ebp
 303:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 306:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 30d:	eb 25                	jmp    334 <atoi+0x34>
    n = n*10 + *s++ - '0';
 30f:	8b 55 fc             	mov    -0x4(%ebp),%edx
 312:	89 d0                	mov    %edx,%eax
 314:	c1 e0 02             	shl    $0x2,%eax
 317:	01 d0                	add    %edx,%eax
 319:	01 c0                	add    %eax,%eax
 31b:	89 c1                	mov    %eax,%ecx
 31d:	8b 45 08             	mov    0x8(%ebp),%eax
 320:	8d 50 01             	lea    0x1(%eax),%edx
 323:	89 55 08             	mov    %edx,0x8(%ebp)
 326:	0f b6 00             	movzbl (%eax),%eax
 329:	0f be c0             	movsbl %al,%eax
 32c:	01 c8                	add    %ecx,%eax
 32e:	83 e8 30             	sub    $0x30,%eax
 331:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 334:	8b 45 08             	mov    0x8(%ebp),%eax
 337:	0f b6 00             	movzbl (%eax),%eax
 33a:	3c 2f                	cmp    $0x2f,%al
 33c:	7e 0a                	jle    348 <atoi+0x48>
 33e:	8b 45 08             	mov    0x8(%ebp),%eax
 341:	0f b6 00             	movzbl (%eax),%eax
 344:	3c 39                	cmp    $0x39,%al
 346:	7e c7                	jle    30f <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 348:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 34b:	c9                   	leave  
 34c:	c3                   	ret    

0000034d <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 34d:	55                   	push   %ebp
 34e:	89 e5                	mov    %esp,%ebp
 350:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 353:	8b 45 08             	mov    0x8(%ebp),%eax
 356:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 359:	8b 45 0c             	mov    0xc(%ebp),%eax
 35c:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 35f:	eb 17                	jmp    378 <memmove+0x2b>
    *dst++ = *src++;
 361:	8b 45 fc             	mov    -0x4(%ebp),%eax
 364:	8d 50 01             	lea    0x1(%eax),%edx
 367:	89 55 fc             	mov    %edx,-0x4(%ebp)
 36a:	8b 55 f8             	mov    -0x8(%ebp),%edx
 36d:	8d 4a 01             	lea    0x1(%edx),%ecx
 370:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 373:	0f b6 12             	movzbl (%edx),%edx
 376:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 378:	8b 45 10             	mov    0x10(%ebp),%eax
 37b:	8d 50 ff             	lea    -0x1(%eax),%edx
 37e:	89 55 10             	mov    %edx,0x10(%ebp)
 381:	85 c0                	test   %eax,%eax
 383:	7f dc                	jg     361 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 385:	8b 45 08             	mov    0x8(%ebp),%eax
}
 388:	c9                   	leave  
 389:	c3                   	ret    

0000038a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 38a:	b8 01 00 00 00       	mov    $0x1,%eax
 38f:	cd 40                	int    $0x40
 391:	c3                   	ret    

00000392 <exit>:
SYSCALL(exit)
 392:	b8 02 00 00 00       	mov    $0x2,%eax
 397:	cd 40                	int    $0x40
 399:	c3                   	ret    

0000039a <wait>:
SYSCALL(wait)
 39a:	b8 03 00 00 00       	mov    $0x3,%eax
 39f:	cd 40                	int    $0x40
 3a1:	c3                   	ret    

000003a2 <pipe>:
SYSCALL(pipe)
 3a2:	b8 04 00 00 00       	mov    $0x4,%eax
 3a7:	cd 40                	int    $0x40
 3a9:	c3                   	ret    

000003aa <read>:
SYSCALL(read)
 3aa:	b8 05 00 00 00       	mov    $0x5,%eax
 3af:	cd 40                	int    $0x40
 3b1:	c3                   	ret    

000003b2 <write>:
SYSCALL(write)
 3b2:	b8 10 00 00 00       	mov    $0x10,%eax
 3b7:	cd 40                	int    $0x40
 3b9:	c3                   	ret    

000003ba <close>:
SYSCALL(close)
 3ba:	b8 15 00 00 00       	mov    $0x15,%eax
 3bf:	cd 40                	int    $0x40
 3c1:	c3                   	ret    

000003c2 <kill>:
SYSCALL(kill)
 3c2:	b8 06 00 00 00       	mov    $0x6,%eax
 3c7:	cd 40                	int    $0x40
 3c9:	c3                   	ret    

000003ca <exec>:
SYSCALL(exec)
 3ca:	b8 07 00 00 00       	mov    $0x7,%eax
 3cf:	cd 40                	int    $0x40
 3d1:	c3                   	ret    

000003d2 <open>:
SYSCALL(open)
 3d2:	b8 0f 00 00 00       	mov    $0xf,%eax
 3d7:	cd 40                	int    $0x40
 3d9:	c3                   	ret    

000003da <mknod>:
SYSCALL(mknod)
 3da:	b8 11 00 00 00       	mov    $0x11,%eax
 3df:	cd 40                	int    $0x40
 3e1:	c3                   	ret    

000003e2 <unlink>:
SYSCALL(unlink)
 3e2:	b8 12 00 00 00       	mov    $0x12,%eax
 3e7:	cd 40                	int    $0x40
 3e9:	c3                   	ret    

000003ea <fstat>:
SYSCALL(fstat)
 3ea:	b8 08 00 00 00       	mov    $0x8,%eax
 3ef:	cd 40                	int    $0x40
 3f1:	c3                   	ret    

000003f2 <link>:
SYSCALL(link)
 3f2:	b8 13 00 00 00       	mov    $0x13,%eax
 3f7:	cd 40                	int    $0x40
 3f9:	c3                   	ret    

000003fa <mkdir>:
SYSCALL(mkdir)
 3fa:	b8 14 00 00 00       	mov    $0x14,%eax
 3ff:	cd 40                	int    $0x40
 401:	c3                   	ret    

00000402 <chdir>:
SYSCALL(chdir)
 402:	b8 09 00 00 00       	mov    $0x9,%eax
 407:	cd 40                	int    $0x40
 409:	c3                   	ret    

0000040a <dup>:
SYSCALL(dup)
 40a:	b8 0a 00 00 00       	mov    $0xa,%eax
 40f:	cd 40                	int    $0x40
 411:	c3                   	ret    

00000412 <getpid>:
SYSCALL(getpid)
 412:	b8 0b 00 00 00       	mov    $0xb,%eax
 417:	cd 40                	int    $0x40
 419:	c3                   	ret    

0000041a <sbrk>:
SYSCALL(sbrk)
 41a:	b8 0c 00 00 00       	mov    $0xc,%eax
 41f:	cd 40                	int    $0x40
 421:	c3                   	ret    

00000422 <sleep>:
SYSCALL(sleep)
 422:	b8 0d 00 00 00       	mov    $0xd,%eax
 427:	cd 40                	int    $0x40
 429:	c3                   	ret    

0000042a <uptime>:
SYSCALL(uptime)
 42a:	b8 0e 00 00 00       	mov    $0xe,%eax
 42f:	cd 40                	int    $0x40
 431:	c3                   	ret    

00000432 <getproc>:
SYSCALL(getproc)
 432:	b8 16 00 00 00       	mov    $0x16,%eax
 437:	cd 40                	int    $0x40
 439:	c3                   	ret    

0000043a <sysreplace>:
SYSCALL(sysreplace)
 43a:	b8 17 00 00 00       	mov    $0x17,%eax
 43f:	cd 40                	int    $0x40
 441:	c3                   	ret    

00000442 <findkalloc>:
SYSCALL(findkalloc)
 442:	b8 18 00 00 00       	mov    $0x18,%eax
 447:	cd 40                	int    $0x40
 449:	c3                   	ret    

0000044a <signal>:
SYSCALL(signal)
 44a:	b8 19 00 00 00       	mov    $0x19,%eax
 44f:	cd 40                	int    $0x40
 451:	c3                   	ret    

00000452 <alarm>:
SYSCALL(alarm)
 452:	b8 1a 00 00 00       	mov    $0x1a,%eax
 457:	cd 40                	int    $0x40
 459:	c3                   	ret    

0000045a <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 45a:	55                   	push   %ebp
 45b:	89 e5                	mov    %esp,%ebp
 45d:	83 ec 18             	sub    $0x18,%esp
 460:	8b 45 0c             	mov    0xc(%ebp),%eax
 463:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 466:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 46d:	00 
 46e:	8d 45 f4             	lea    -0xc(%ebp),%eax
 471:	89 44 24 04          	mov    %eax,0x4(%esp)
 475:	8b 45 08             	mov    0x8(%ebp),%eax
 478:	89 04 24             	mov    %eax,(%esp)
 47b:	e8 32 ff ff ff       	call   3b2 <write>
}
 480:	c9                   	leave  
 481:	c3                   	ret    

00000482 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 482:	55                   	push   %ebp
 483:	89 e5                	mov    %esp,%ebp
 485:	56                   	push   %esi
 486:	53                   	push   %ebx
 487:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 48a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 491:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 495:	74 17                	je     4ae <printint+0x2c>
 497:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 49b:	79 11                	jns    4ae <printint+0x2c>
    neg = 1;
 49d:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 4a4:	8b 45 0c             	mov    0xc(%ebp),%eax
 4a7:	f7 d8                	neg    %eax
 4a9:	89 45 ec             	mov    %eax,-0x14(%ebp)
 4ac:	eb 06                	jmp    4b4 <printint+0x32>
  } else {
    x = xx;
 4ae:	8b 45 0c             	mov    0xc(%ebp),%eax
 4b1:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 4b4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 4bb:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 4be:	8d 41 01             	lea    0x1(%ecx),%eax
 4c1:	89 45 f4             	mov    %eax,-0xc(%ebp)
 4c4:	8b 5d 10             	mov    0x10(%ebp),%ebx
 4c7:	8b 45 ec             	mov    -0x14(%ebp),%eax
 4ca:	ba 00 00 00 00       	mov    $0x0,%edx
 4cf:	f7 f3                	div    %ebx
 4d1:	89 d0                	mov    %edx,%eax
 4d3:	0f b6 80 d4 0b 00 00 	movzbl 0xbd4(%eax),%eax
 4da:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 4de:	8b 75 10             	mov    0x10(%ebp),%esi
 4e1:	8b 45 ec             	mov    -0x14(%ebp),%eax
 4e4:	ba 00 00 00 00       	mov    $0x0,%edx
 4e9:	f7 f6                	div    %esi
 4eb:	89 45 ec             	mov    %eax,-0x14(%ebp)
 4ee:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4f2:	75 c7                	jne    4bb <printint+0x39>
  if(neg)
 4f4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 4f8:	74 10                	je     50a <printint+0x88>
    buf[i++] = '-';
 4fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4fd:	8d 50 01             	lea    0x1(%eax),%edx
 500:	89 55 f4             	mov    %edx,-0xc(%ebp)
 503:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 508:	eb 1f                	jmp    529 <printint+0xa7>
 50a:	eb 1d                	jmp    529 <printint+0xa7>
    putc(fd, buf[i]);
 50c:	8d 55 dc             	lea    -0x24(%ebp),%edx
 50f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 512:	01 d0                	add    %edx,%eax
 514:	0f b6 00             	movzbl (%eax),%eax
 517:	0f be c0             	movsbl %al,%eax
 51a:	89 44 24 04          	mov    %eax,0x4(%esp)
 51e:	8b 45 08             	mov    0x8(%ebp),%eax
 521:	89 04 24             	mov    %eax,(%esp)
 524:	e8 31 ff ff ff       	call   45a <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 529:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 52d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 531:	79 d9                	jns    50c <printint+0x8a>
    putc(fd, buf[i]);
}
 533:	83 c4 30             	add    $0x30,%esp
 536:	5b                   	pop    %ebx
 537:	5e                   	pop    %esi
 538:	5d                   	pop    %ebp
 539:	c3                   	ret    

0000053a <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 53a:	55                   	push   %ebp
 53b:	89 e5                	mov    %esp,%ebp
 53d:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 540:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 547:	8d 45 0c             	lea    0xc(%ebp),%eax
 54a:	83 c0 04             	add    $0x4,%eax
 54d:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 550:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 557:	e9 7c 01 00 00       	jmp    6d8 <printf+0x19e>
    c = fmt[i] & 0xff;
 55c:	8b 55 0c             	mov    0xc(%ebp),%edx
 55f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 562:	01 d0                	add    %edx,%eax
 564:	0f b6 00             	movzbl (%eax),%eax
 567:	0f be c0             	movsbl %al,%eax
 56a:	25 ff 00 00 00       	and    $0xff,%eax
 56f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 572:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 576:	75 2c                	jne    5a4 <printf+0x6a>
      if(c == '%'){
 578:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 57c:	75 0c                	jne    58a <printf+0x50>
        state = '%';
 57e:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 585:	e9 4a 01 00 00       	jmp    6d4 <printf+0x19a>
      } else {
        putc(fd, c);
 58a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 58d:	0f be c0             	movsbl %al,%eax
 590:	89 44 24 04          	mov    %eax,0x4(%esp)
 594:	8b 45 08             	mov    0x8(%ebp),%eax
 597:	89 04 24             	mov    %eax,(%esp)
 59a:	e8 bb fe ff ff       	call   45a <putc>
 59f:	e9 30 01 00 00       	jmp    6d4 <printf+0x19a>
      }
    } else if(state == '%'){
 5a4:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 5a8:	0f 85 26 01 00 00    	jne    6d4 <printf+0x19a>
      if(c == 'd'){
 5ae:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 5b2:	75 2d                	jne    5e1 <printf+0xa7>
        printint(fd, *ap, 10, 1);
 5b4:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5b7:	8b 00                	mov    (%eax),%eax
 5b9:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 5c0:	00 
 5c1:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 5c8:	00 
 5c9:	89 44 24 04          	mov    %eax,0x4(%esp)
 5cd:	8b 45 08             	mov    0x8(%ebp),%eax
 5d0:	89 04 24             	mov    %eax,(%esp)
 5d3:	e8 aa fe ff ff       	call   482 <printint>
        ap++;
 5d8:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5dc:	e9 ec 00 00 00       	jmp    6cd <printf+0x193>
      } else if(c == 'x' || c == 'p'){
 5e1:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 5e5:	74 06                	je     5ed <printf+0xb3>
 5e7:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 5eb:	75 2d                	jne    61a <printf+0xe0>
        printint(fd, *ap, 16, 0);
 5ed:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5f0:	8b 00                	mov    (%eax),%eax
 5f2:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 5f9:	00 
 5fa:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 601:	00 
 602:	89 44 24 04          	mov    %eax,0x4(%esp)
 606:	8b 45 08             	mov    0x8(%ebp),%eax
 609:	89 04 24             	mov    %eax,(%esp)
 60c:	e8 71 fe ff ff       	call   482 <printint>
        ap++;
 611:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 615:	e9 b3 00 00 00       	jmp    6cd <printf+0x193>
      } else if(c == 's'){
 61a:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 61e:	75 45                	jne    665 <printf+0x12b>
        s = (char*)*ap;
 620:	8b 45 e8             	mov    -0x18(%ebp),%eax
 623:	8b 00                	mov    (%eax),%eax
 625:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 628:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 62c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 630:	75 09                	jne    63b <printf+0x101>
          s = "(null)";
 632:	c7 45 f4 48 09 00 00 	movl   $0x948,-0xc(%ebp)
        while(*s != 0){
 639:	eb 1e                	jmp    659 <printf+0x11f>
 63b:	eb 1c                	jmp    659 <printf+0x11f>
          putc(fd, *s);
 63d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 640:	0f b6 00             	movzbl (%eax),%eax
 643:	0f be c0             	movsbl %al,%eax
 646:	89 44 24 04          	mov    %eax,0x4(%esp)
 64a:	8b 45 08             	mov    0x8(%ebp),%eax
 64d:	89 04 24             	mov    %eax,(%esp)
 650:	e8 05 fe ff ff       	call   45a <putc>
          s++;
 655:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 659:	8b 45 f4             	mov    -0xc(%ebp),%eax
 65c:	0f b6 00             	movzbl (%eax),%eax
 65f:	84 c0                	test   %al,%al
 661:	75 da                	jne    63d <printf+0x103>
 663:	eb 68                	jmp    6cd <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 665:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 669:	75 1d                	jne    688 <printf+0x14e>
        putc(fd, *ap);
 66b:	8b 45 e8             	mov    -0x18(%ebp),%eax
 66e:	8b 00                	mov    (%eax),%eax
 670:	0f be c0             	movsbl %al,%eax
 673:	89 44 24 04          	mov    %eax,0x4(%esp)
 677:	8b 45 08             	mov    0x8(%ebp),%eax
 67a:	89 04 24             	mov    %eax,(%esp)
 67d:	e8 d8 fd ff ff       	call   45a <putc>
        ap++;
 682:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 686:	eb 45                	jmp    6cd <printf+0x193>
      } else if(c == '%'){
 688:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 68c:	75 17                	jne    6a5 <printf+0x16b>
        putc(fd, c);
 68e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 691:	0f be c0             	movsbl %al,%eax
 694:	89 44 24 04          	mov    %eax,0x4(%esp)
 698:	8b 45 08             	mov    0x8(%ebp),%eax
 69b:	89 04 24             	mov    %eax,(%esp)
 69e:	e8 b7 fd ff ff       	call   45a <putc>
 6a3:	eb 28                	jmp    6cd <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 6a5:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 6ac:	00 
 6ad:	8b 45 08             	mov    0x8(%ebp),%eax
 6b0:	89 04 24             	mov    %eax,(%esp)
 6b3:	e8 a2 fd ff ff       	call   45a <putc>
        putc(fd, c);
 6b8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 6bb:	0f be c0             	movsbl %al,%eax
 6be:	89 44 24 04          	mov    %eax,0x4(%esp)
 6c2:	8b 45 08             	mov    0x8(%ebp),%eax
 6c5:	89 04 24             	mov    %eax,(%esp)
 6c8:	e8 8d fd ff ff       	call   45a <putc>
      }
      state = 0;
 6cd:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6d4:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 6d8:	8b 55 0c             	mov    0xc(%ebp),%edx
 6db:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6de:	01 d0                	add    %edx,%eax
 6e0:	0f b6 00             	movzbl (%eax),%eax
 6e3:	84 c0                	test   %al,%al
 6e5:	0f 85 71 fe ff ff    	jne    55c <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 6eb:	c9                   	leave  
 6ec:	c3                   	ret    

000006ed <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6ed:	55                   	push   %ebp
 6ee:	89 e5                	mov    %esp,%ebp
 6f0:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 6f3:	8b 45 08             	mov    0x8(%ebp),%eax
 6f6:	83 e8 08             	sub    $0x8,%eax
 6f9:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6fc:	a1 f0 0b 00 00       	mov    0xbf0,%eax
 701:	89 45 fc             	mov    %eax,-0x4(%ebp)
 704:	eb 24                	jmp    72a <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 706:	8b 45 fc             	mov    -0x4(%ebp),%eax
 709:	8b 00                	mov    (%eax),%eax
 70b:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 70e:	77 12                	ja     722 <free+0x35>
 710:	8b 45 f8             	mov    -0x8(%ebp),%eax
 713:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 716:	77 24                	ja     73c <free+0x4f>
 718:	8b 45 fc             	mov    -0x4(%ebp),%eax
 71b:	8b 00                	mov    (%eax),%eax
 71d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 720:	77 1a                	ja     73c <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 722:	8b 45 fc             	mov    -0x4(%ebp),%eax
 725:	8b 00                	mov    (%eax),%eax
 727:	89 45 fc             	mov    %eax,-0x4(%ebp)
 72a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 72d:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 730:	76 d4                	jbe    706 <free+0x19>
 732:	8b 45 fc             	mov    -0x4(%ebp),%eax
 735:	8b 00                	mov    (%eax),%eax
 737:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 73a:	76 ca                	jbe    706 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 73c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 73f:	8b 40 04             	mov    0x4(%eax),%eax
 742:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 749:	8b 45 f8             	mov    -0x8(%ebp),%eax
 74c:	01 c2                	add    %eax,%edx
 74e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 751:	8b 00                	mov    (%eax),%eax
 753:	39 c2                	cmp    %eax,%edx
 755:	75 24                	jne    77b <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 757:	8b 45 f8             	mov    -0x8(%ebp),%eax
 75a:	8b 50 04             	mov    0x4(%eax),%edx
 75d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 760:	8b 00                	mov    (%eax),%eax
 762:	8b 40 04             	mov    0x4(%eax),%eax
 765:	01 c2                	add    %eax,%edx
 767:	8b 45 f8             	mov    -0x8(%ebp),%eax
 76a:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 76d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 770:	8b 00                	mov    (%eax),%eax
 772:	8b 10                	mov    (%eax),%edx
 774:	8b 45 f8             	mov    -0x8(%ebp),%eax
 777:	89 10                	mov    %edx,(%eax)
 779:	eb 0a                	jmp    785 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 77b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 77e:	8b 10                	mov    (%eax),%edx
 780:	8b 45 f8             	mov    -0x8(%ebp),%eax
 783:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 785:	8b 45 fc             	mov    -0x4(%ebp),%eax
 788:	8b 40 04             	mov    0x4(%eax),%eax
 78b:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 792:	8b 45 fc             	mov    -0x4(%ebp),%eax
 795:	01 d0                	add    %edx,%eax
 797:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 79a:	75 20                	jne    7bc <free+0xcf>
    p->s.size += bp->s.size;
 79c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 79f:	8b 50 04             	mov    0x4(%eax),%edx
 7a2:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7a5:	8b 40 04             	mov    0x4(%eax),%eax
 7a8:	01 c2                	add    %eax,%edx
 7aa:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7ad:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 7b0:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7b3:	8b 10                	mov    (%eax),%edx
 7b5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7b8:	89 10                	mov    %edx,(%eax)
 7ba:	eb 08                	jmp    7c4 <free+0xd7>
  } else
    p->s.ptr = bp;
 7bc:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7bf:	8b 55 f8             	mov    -0x8(%ebp),%edx
 7c2:	89 10                	mov    %edx,(%eax)
  freep = p;
 7c4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7c7:	a3 f0 0b 00 00       	mov    %eax,0xbf0
}
 7cc:	c9                   	leave  
 7cd:	c3                   	ret    

000007ce <morecore>:

static Header*
morecore(uint nu)
{
 7ce:	55                   	push   %ebp
 7cf:	89 e5                	mov    %esp,%ebp
 7d1:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 7d4:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 7db:	77 07                	ja     7e4 <morecore+0x16>
    nu = 4096;
 7dd:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 7e4:	8b 45 08             	mov    0x8(%ebp),%eax
 7e7:	c1 e0 03             	shl    $0x3,%eax
 7ea:	89 04 24             	mov    %eax,(%esp)
 7ed:	e8 28 fc ff ff       	call   41a <sbrk>
 7f2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 7f5:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 7f9:	75 07                	jne    802 <morecore+0x34>
    return 0;
 7fb:	b8 00 00 00 00       	mov    $0x0,%eax
 800:	eb 22                	jmp    824 <morecore+0x56>
  hp = (Header*)p;
 802:	8b 45 f4             	mov    -0xc(%ebp),%eax
 805:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 808:	8b 45 f0             	mov    -0x10(%ebp),%eax
 80b:	8b 55 08             	mov    0x8(%ebp),%edx
 80e:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 811:	8b 45 f0             	mov    -0x10(%ebp),%eax
 814:	83 c0 08             	add    $0x8,%eax
 817:	89 04 24             	mov    %eax,(%esp)
 81a:	e8 ce fe ff ff       	call   6ed <free>
  return freep;
 81f:	a1 f0 0b 00 00       	mov    0xbf0,%eax
}
 824:	c9                   	leave  
 825:	c3                   	ret    

00000826 <malloc>:

void*
malloc(uint nbytes)
{
 826:	55                   	push   %ebp
 827:	89 e5                	mov    %esp,%ebp
 829:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 82c:	8b 45 08             	mov    0x8(%ebp),%eax
 82f:	83 c0 07             	add    $0x7,%eax
 832:	c1 e8 03             	shr    $0x3,%eax
 835:	83 c0 01             	add    $0x1,%eax
 838:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 83b:	a1 f0 0b 00 00       	mov    0xbf0,%eax
 840:	89 45 f0             	mov    %eax,-0x10(%ebp)
 843:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 847:	75 23                	jne    86c <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 849:	c7 45 f0 e8 0b 00 00 	movl   $0xbe8,-0x10(%ebp)
 850:	8b 45 f0             	mov    -0x10(%ebp),%eax
 853:	a3 f0 0b 00 00       	mov    %eax,0xbf0
 858:	a1 f0 0b 00 00       	mov    0xbf0,%eax
 85d:	a3 e8 0b 00 00       	mov    %eax,0xbe8
    base.s.size = 0;
 862:	c7 05 ec 0b 00 00 00 	movl   $0x0,0xbec
 869:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 86c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 86f:	8b 00                	mov    (%eax),%eax
 871:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 874:	8b 45 f4             	mov    -0xc(%ebp),%eax
 877:	8b 40 04             	mov    0x4(%eax),%eax
 87a:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 87d:	72 4d                	jb     8cc <malloc+0xa6>
      if(p->s.size == nunits)
 87f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 882:	8b 40 04             	mov    0x4(%eax),%eax
 885:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 888:	75 0c                	jne    896 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 88a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 88d:	8b 10                	mov    (%eax),%edx
 88f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 892:	89 10                	mov    %edx,(%eax)
 894:	eb 26                	jmp    8bc <malloc+0x96>
      else {
        p->s.size -= nunits;
 896:	8b 45 f4             	mov    -0xc(%ebp),%eax
 899:	8b 40 04             	mov    0x4(%eax),%eax
 89c:	2b 45 ec             	sub    -0x14(%ebp),%eax
 89f:	89 c2                	mov    %eax,%edx
 8a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8a4:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 8a7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8aa:	8b 40 04             	mov    0x4(%eax),%eax
 8ad:	c1 e0 03             	shl    $0x3,%eax
 8b0:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 8b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8b6:	8b 55 ec             	mov    -0x14(%ebp),%edx
 8b9:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 8bc:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8bf:	a3 f0 0b 00 00       	mov    %eax,0xbf0
      return (void*)(p + 1);
 8c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8c7:	83 c0 08             	add    $0x8,%eax
 8ca:	eb 38                	jmp    904 <malloc+0xde>
    }
    if(p == freep)
 8cc:	a1 f0 0b 00 00       	mov    0xbf0,%eax
 8d1:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 8d4:	75 1b                	jne    8f1 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 8d6:	8b 45 ec             	mov    -0x14(%ebp),%eax
 8d9:	89 04 24             	mov    %eax,(%esp)
 8dc:	e8 ed fe ff ff       	call   7ce <morecore>
 8e1:	89 45 f4             	mov    %eax,-0xc(%ebp)
 8e4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 8e8:	75 07                	jne    8f1 <malloc+0xcb>
        return 0;
 8ea:	b8 00 00 00 00       	mov    $0x0,%eax
 8ef:	eb 13                	jmp    904 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8f4:	89 45 f0             	mov    %eax,-0x10(%ebp)
 8f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8fa:	8b 00                	mov    (%eax),%eax
 8fc:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 8ff:	e9 70 ff ff ff       	jmp    874 <malloc+0x4e>
}
 904:	c9                   	leave  
 905:	c3                   	ret    
