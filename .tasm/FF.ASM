data segment
numm dw 0009h
ans dd ?
data ends
code segment
assume cs:code, ds:data
start:
mov ax, data
mov ds, ax
mov ax, 0001
mov bx, 0001
mov cx, numm
cmp cx, 0001
jz finish
calculate:
inc bx
mul bx
cmp bx, cx
jnz calculate
finish:
lea si, ans
mov [si], ax
mov [si+2], dx
int 3
code ends
end start
