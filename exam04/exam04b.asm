code	segment
		assume	cs:code,ds:code
		org		100h
start:	mov		bl,2bh
		mov		cl,4
		mov		dl,bl
		shr		dl,cl
		call	print
		
		mov		dl,bl
		and		dl,0fh
		call 	print
		
		mov 	ah,4ch
		int		21h
		
print	proc	near
		add		dl,30h
		cmp		dl,'9'
		jbe		ok
		add		dl,7
ok:		mov		ah,2
		int		21h
		ret
print	endp
code	ends
		end		start
		
