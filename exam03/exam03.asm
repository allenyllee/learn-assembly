;***************************************
code    segment
        assume  cs:code,ds:code
        org     100h

;---------------------------------------
start:  mov     bl,2bh
;以下九行印出 BL 內較高的 4 個位元，例如 BL=2B 則在螢幕印出『2』
        mov     cl,4    ;將 4 存於 CL
        mov     dl,bl   ;將 BL 之內容存於 DL 中以方便印出
        shr     dl,cl   ;把 BL 較高之 4 位元變成 DL 中較低之 4 位元
        add     dl,30h  ;加上 30H
        cmp     dl,'9'  ;比較看看是否超過 39H
        jbe     ok_1    ;沒超過直接印出
        add     dl,7    ;若超過再加上 7
ok_1:   mov     ah,2
        int     21h     ;印出

;以下 8 行印出 BL 較低的 4 個位元，例如 BL=2B 則在螢幕印出『B』
        mov     dl,bl   ;將 BL 之值存入 DL
        and     dl,0fh  ;取得 DL 之較低的 4 個位元
        add     dl,30h  ;加上 30H
        cmp     dl,'9'  ;比較看看是否超過 9
        jbe     ok_2    ;沒超過直接印出
        add     dl,7    ;若超過再加上 7
ok_2:   mov     ah,2
        int     21h     ;印出

        mov     ax,4c00h;結束程式
        int     21h
;---------------------------------------
code    ends
        end     start