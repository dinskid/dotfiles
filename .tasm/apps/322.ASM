.model small
.stack 100h
.data
msg db "Hello world!$"
.code
mov ah,09h
lea dx,msg
int 21h
mov ax,4Ch
end 
