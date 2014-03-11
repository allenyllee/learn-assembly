	.model	small
	.386

	.data


	.code
begin:
	;Disable GBL_SMI 
	mov	dx,830h
	in	al,dx
	and	al,0FEh
	out	dx,al

	;Disable SLP_SMI_EN
	mov	dx,830h
	in	al,dx
	and	al,0EFh
	out	dx,al


	;ENABLE RTC
	mov	dx,803h
	in	al,dx
	or	al,04h
	out	dx,al

	;SLEEP TYPE
	mov	dx,804h
	in	ax,dx
	and	ax,0E3ffh
	or	ax,1c00h
	out	dx,ax

	;Sleep Enable
	mov	dx,804h	
	in	ax,dx
	or	ax,2000h
	out	dx,ax    

	mov	ah,4ch
	int	21h
	.stack

	end