;***************************************    ;01
code	segment 			    			;02.code �q�}�l��}
		assume	cs:code,ds:code 	    	;03.���]�{���q�θ�Ƭq
		org		100h			    		;04.�i�令 *.COM ��
;---------------------------------------    ;05.
start:	jmp		begin			    		;06.�{���i�J�I
mes		db		'Hi, I learn assembly.$'    ;07.�n�L�X���T��
begin:	mov		dx,offset mes		    	;08.���V mes ����}
		mov		ah,9			    		;09.�I�sDOS�A�ȵ{���AAH=9/INT 21H ���ܦL�X�r��
		int		21h			    			;10.�I�s DOS �A�ȵ{��
		mov		ax,4c00h		    		;11.���w�n�I�s���A�ȸ��X
		int		21h			    			;12.�I�s DOS �A�ȵ{��
;---------------------------------------    ;13.
code	ends				    			;14.code �q����
;***************************************    ;15.
		end		start			    		;16.�ϲ�Ķ�����D�{���i�J�I