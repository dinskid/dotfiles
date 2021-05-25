.model small
.386

.data
a dd 01234567H
b dd 11111111H

.code
mov ax,@data
mov ds,ax
mov eax,a
mov ebx,b
add eax,ebx

mov ah,4CH
int 21H
end
