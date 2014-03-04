;***************************************    ;01
code	segment 			    			;02.code 段開始位址
		assume	cs:code,ds:code 	    	;03.假設程式段及資料段
		org		100h			    		;04.可改成 *.COM 檔
;---------------------------------------    ;05.
start:	jmp		begin			    		;06.程式進入點
mes		db		'Hi, I learn assembly.$'    ;07.要印出的訊息
begin:	mov		dx,offset mes		    	;08.指向 mes 的位址
		mov		ah,9			    		;09.呼叫DOS服務程式，AH=9/INT 21H 表示印出字串
		int		21h			    			;10.呼叫 DOS 服務程式
		mov		ax,4c00h		    		;11.指定要呼叫的服務號碼
		int		21h			    			;12.呼叫 DOS 服務程式
;---------------------------------------    ;13.
code	ends				    			;14.code 段結束
;***************************************    ;15.
		end		start			    		;16.使組譯器知道程式進入點