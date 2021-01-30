.model small
.386
.stack 100H
.data
 a dd 98765432H
 b dd 11111111H
 .code
 mov ax,@data
 mov ax,dx
 mov eax,a
 mov ebx,b
 sub eax,ebx
 mov ah,09H
 mov edx,eax
 mov ah,4CH
 int 21H
 end
