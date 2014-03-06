code	segment	
		assume	cs:code,ds:code
		org		100h
		
start:	sub 	bx,bx

next:	mov		dl,bl
		mov		cl,4
		shr		dl,cl
		call	print
		
		mov		dl,bl
		and		dl,0fh
		call	print
		
		mov		ah,2
		mov		dl,' '
		int		21h
		mov		dl,bl
		int		21h
		call	cr_lf
		
		inc		bl
		mov		ax,bx
		mov		cl,20
		div		cl
		or		ah,ah
		jnz		remain
		
		mov		ah,0
		int		16h
		
remain:	or		bl,bl
		jnz		next
		mov		ah,4ch
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
		
cr_lf	proc	near
		mov		ah,2
		mov		dl,0dh
		int		21h
		mov		dl,0ah
		int		21h
		ret
cr_lf	endp
		
code	ends
		end		start