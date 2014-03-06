;***************************************
code    segment         ;02
        assume  cs:code,ds:code
        org     100h    ;04
                        ;05
;---------------------------------------
start:  sub     bx,bx   ;07 使 BX 等於零
                        ;08
next:   mov     dl,bl   ;09 此行及以下 3 行印出 BL 內容的
        mov     cl,4    ;10 較高的四個位元
        shr     dl,cl   ;11
        call    print   ;12
        mov     dl,bl   ;13 此行及以下 2 行印出 BL 內容的
        and     dl,0fh  ;14 較低的四個位元
        call    print   ;15
                        ;16
        mov     ah,2    ;17 此行及以下兩行印出空白
        mov     dl,' '  ;18
        int     21h     ;19
        mov     dl,bl   ;20 此行及以下兩行印出 BL 所代表的
        int     21h     ;21 ASCII 字元
        call    cr_lf   ;22 印出歸位及換行字元
                        ;23
        inc     bl      ;24 使 BL 為下一個 ASCII 字元
        mov     ch,20   ;25 設定除數
        mov     ax,bx   ;26 設定被除數
        div     ch      ;27
        or      ah,ah   ;28 若餘數為零,表示已經顯示 20 個字了
        jnz     remain  ;29
        int     16h     ;30 所以應該等使用者按下任意鍵再繼續
                        ;31
remain: cmp     bl,0    ;32 如果 BL=0,表示已經完成 256 個字了
        jne     next    ;33

        mov     ax,4c00h
        int     21h
;---------------------------------------
;print 副程式
;輸入：DL-由 0 到 F 的十六進位數
;輸出：在螢幕上印出 DL 內的 ASCII 碼
print   proc    near
        add     dl,30h  ;加上 30H
        cmp     dl,'9'  ;比較看看是否超過 39H
        jbe     ok      ;沒超過直接印出
        add     dl,7    ;若超過再加上 7
ok:     mov     ah,2
        int     21h     ;印出
        ret
print   endp
;---------------------------------------
cr_lf   proc    near
        mov     ah,2
        mov     dl,0dh
        int     21h
        mov     dl,0ah
        int     21h
        ret
cr_lf   endp
;---------------------------------------
code    ends
;***************************************
        end     start