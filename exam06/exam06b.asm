		.386
code	segment	use16
		assume	cs:code,ds:code
		org		100h
		
start:	jmp		begin
far_jmp		db	0eah			;far jump指令的opcode
old_int21h	dw	?,?				;預備要跳到的位址[offset:seg]
new_int21h	dw	offset _new_int21h,seg _new_int21h

begin:	call	get_int		;將舊的int21h的程式位址存到old_int21h
		;call	_new_int21h	
		call	set_new_int	;將自己的程式位址存到int21h
		
		
		mov		ax,0280h
		mov		dl,'!'
		int		21h
		
		call	set_old_int
		
		mov 	ah,2
		mov		dl,'!'
		int		21h
		
		mov		ah,4ch
		int		21h

_new_int21h	proc	near
		
		cmp		ax,0280h		;因為原本dos的int21h/ah=02服務為螢幕輸出字元，
								;一般皆會使用到，故需保留原服務
		jz		port80
		
		;push		bx
		;mov		bx,seg old_int21h
		;mov		es,bx
		;mov		di,offset old_int21h
		;pop		bx
		;jmp		dword ptr es:[di]		;雖然可以跳到原來的位址，但因為es,di被修改，無法正常執行
		
								;因為MASM不支援far jmp，直接使用opcode
		db		0eah			;far jump指令的opcode
		dw		offset	far_jmp	;預備要跳到的位址offset
		dw		seg	far_jmp		;預備要跳到的位址seg
		
		
port80:	push	ax
		mov		al,dl
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
		
		mov		ax,0		;指定ds:si為int21h (0:84h)
		mov		ds,ax
		mov		si,84h
		mov		ax,seg old_int21h	;指定es:di的位址為預留的old_int21h
		mov		es,ax
		mov		di,offset old_int21h
		movsd				;將ds:si指到的位址內容存到es:di指到的位址

		
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
		mov 	di,84h

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
		mov 	di,84h

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
