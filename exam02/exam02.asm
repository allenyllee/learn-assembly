;***************************************
code    segment          ;02
        assume  cs:code,ds:code
        org     100h
;---------------------------------------
start:  mov     cx,256   ;06 有 256 個 ASCII 碼
        mov     dl,0     ;07
next:   mov     ah,2     ;08 Loop 迴圈開始處 ─┐
        int     21h      ;09                   │
        inc     dl       ;10                   │
        loop    next     ;11 Loop 迴圈結束處 ─┘
        mov     ax,4c00h ;12
        int     21h      ;13
;---------------------------------------
code    ends
;***************************************
        end     start