segment data
n db 5
r db 2
ans db 0
data ends

segment code
assume cs:code, ds:data, es:data

ncr proc
    cmp al, bl
    je one
    jg greater
    ret
    greater:
        cmp bl, 0
        je one
        dec al
        push ax
        push bx
        call ncr
        pop bx
        pop ax
        dec bl
        push ax
        push bx
        call ncr
        pop bx
        pop ax
        ret
    one:
        inc ans
        ret
endp ncr

start:
mov ax, data
mov ds, ax
mov al, n
mov bl, r

call ncr
int 3
mov ah, 4ch
int 21h

code ends
end start
