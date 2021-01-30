;screen
pushall macro
pushf
push ax
push bx
push cx
push dx
push si
push di
push ds
push es
endm

popall macro
pop es
pop ds
pop di
pop si
pop dx
pop cx
pop bx
pop ax
popf
endm

captureint macro intno,saveint,subroutine
cli
mov ah,35h
mov al,intno
int 21h
mov word ptr saveint,bx
mov word ptr saveint+2,es
mov ah,25h
mov al,intno
lea dx,subroutine
int 21h
endm

.model tiny
.code
org 100h
start:
jmp init
saveint8 dd ?
saveint9 dd ?
stri db 'I',06,'N',06,'D',06,'I',06,'A',06,'M',06
count db 00h

keyboard:
pushall
mov cs:count,0
mov ah,05h
mov al,00h
int 10h
popall
jmp cs:saveint9

timer:
pushall
cmp cs:count,50
jbe exit8
mov ah,05h
mov al,01h
int 10h
mov ax,cs
mov ds,ax
mov ax,0b900h
mov es,ax
lea si,stri
mov di,1980
mov cx,12
rep movsb
jmp next

exit8:
inc cs:count

next:
popall
jmp cs:saveint8

init:
cli
captureint 8,saveint8,timer
captureint 9,saveint9,keyboard
mov ah,31h
lea dx,init
sti
int 21h
end start












