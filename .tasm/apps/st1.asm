disp macro msg
mov ah,09h
mov dx,offset msg
int 21h
endm

.model small
.stack
.data
msg1 db 10,13,"Power Programming Tool By Sagar Taware:Computer Dep.(NESGOI)$"

.code
  mov ax,@data
  mov ds,ax
  mov es,ax

start:
      disp msg1
      mov ah,01h
      int 21h
    
     mov ah,4ch
     int 21h
endp
end

