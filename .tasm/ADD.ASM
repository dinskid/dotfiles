data segment
a dw 10
b dw 2
data ends

code segment
assume cs:code,ds:data
start:
mov ax,data
mov ds,ax
mov ax, a
mov bx, b
add ax,bx
mov ax, a
mov bx, b
sub ax, bx
mov ax, a
mov bx, b
mul bx
int 3
code ends
end start
