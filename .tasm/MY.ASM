.model small

.data
str1 db "Hello$"

.code
main proc

mov ax,@data
mov ds, ax

lea dx, str1
mov ah, 09h
int 21h

mov ah, 4ch
int 21h

main endp
end main
