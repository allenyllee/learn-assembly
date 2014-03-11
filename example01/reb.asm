	.model	small
	.386

	.data


	.code
begin:
	mov	al,0feh
	out	64h,al

	mov	ah,4ch
	int	21h
	.stack

	end