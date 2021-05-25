segment data
s db "CABCBA$"
pali db "PALINDROME", 0ah, 0dh, "$"
notpali db "NOT PALINDROME", 0ah, 0dh, "$"
data ends

segment code
assume cs:code, ds:data, es:data
start:
mov ax, data
mov ds, ax
mov es, ax
lea si, s
again:
    cmp byte ptr [si], '$'
    je outagain
    mov di, si
    inc si
    jmp again
outagain:
    lea si, s
back:
    cmpsb
    jne outback
    inc si
    dec di
equal:
    lea dx, pali
    jmp return
outback:
    lea dx, notpali
return:
    mov ah, 09h
    int 21h
    mov ah, 4ch
    int 21h
code ends
end start