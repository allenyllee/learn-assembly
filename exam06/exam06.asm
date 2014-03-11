		.386
code	segment	use16
		assume	cs:code,ds:code
		org		100h
		
start:	jmp		begin
old_int21h	dw	?,?
new_int21h	dw	offset _new_int21h,seg _new_int21h

begin:	call	get_int
		;call	_new_int21h
		call	set_new_int
		
		
		mov		ah,2
		mov		dl,'!'
		int		0f1h
		
		call	set_old_int
		
		mov 	ah,2
		mov		dl,'!'
		int		21h
		
		mov		ah,4ch
		int		21h

_new_int21h	proc	near
		push	ax
		cmp		ah,02
		jz		port80
		
		;push	bx
		;push	ds
		;push	si
		;push	ax
		
		;mov		bx,seg old_int21h
		;mov		ds,bx
		;mov		si,offset old_int21h+2
		;lodsw	
		;mov		es,ax
		;mov		si,offset old_int21h
		;lodsw
		;mov		di,ax
		
		;pop		ax
		;pop		si
		;pop		ds
		;pop		bx
		
		;jmp		es:di
		
port80:	mov		al,dl
		out		80h,al
		pop		ax
		iret
_new_int21h	endp

get_int	proc	near
		push	ax
		push	ds
		push	si
		push	es
		push	di
		
		mov		ax,0
		mov		ds,ax
		mov		si,3c4h
		mov		ax,seg old_int21h
		mov		es,ax
		mov		di,offset old_int21h		
		movsd

		
		pop		di
		pop		es
		pop		si
		pop		ds
		pop		ax
		ret
get_int	endp

set_new_int	proc	near
		push	ax
		push	ds
		push	si
		push	es
		push	di
		
		mov		ax,seg new_int21h
		mov		ds,ax
		mov 	si,offset new_int21h
		mov		ax,0
		mov		es,ax
		mov 	di,3c4h

		cld
		cli
		movsd
		sti
		
		pop		di
		pop		es
		pop		si
		pop		ds
		pop		ax
		ret
set_new_int endp

set_old_int proc	near
		push	ax
		push	ds
		push	si
		push	es
		push	di
		
		mov		ax,seg old_int21h
		mov		ds,ax
		mov 	si,offset old_int21h		
		mov		ax,0
		mov		es,ax
		mov 	di,3c4h

		cld
		cli
		movsd
		sti
		
		pop		di
		pop		es
		pop		si
		pop		ds
		pop		ax
		ret
set_old_int	endp

code	ends
		end		start
