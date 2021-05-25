;How to run  - Enter 2 digit no. then Automatically dot comes then enter 2 digit no. 
; TO Find Mean , Varience & Standard Deviation  using  8087

.model small
.data
num1 dt ?
num2 dt ?
num3 dt ?
num4 dt ?
num5 dt ?
a dw ?
msg db 10d,13d,"Enter 5 numbers",10d,13d,"$"
msg1 db 10d,13d,"Mean is=$"
msg2 db 10d,13d,"Varience is=$"
msg3 db 10d,13d,"Standard Deviation=$"
msg4 db 10d,13d,"$"
num dt 100
b dt 100.00
count dt 5.0
temp dt 03.44
ans dt ?
ans1 dt ?
ans2 dt ?
fans dt ?
fans1 dt ?
fans2 dt ?
mm db ".$"
.code

mov ax,@data
mov ds,ax


mov ch,05h
lea dx,msg
mov ah,09h
int 21h

finit
l1:            ; loop for accepting 5 nos.

mov cl,04h
mov ah,01h
int 21h
sub al,30h
mov bl,al
rol bl,cl
mov ah,01h
int 21h
sub al,30h
add bl,al
mov byte ptr num1,bl        ; Integer Part

lea dx,mm
mov ah,09h
int 21h

mov ah,01h
int 21h
sub al,30h
mov bl,al
rol bl,cl
mov ah,01h
int 21h
sub al,30h
add bl,al
mov byte ptr num2,bl         ; Fractional part

fbld num2
fbld num
fdivp st[1],st
fbld num1
faddp st[1],st               ; Integer . Fractional part
lea dx,msg4
mov ah,09h
int 21h
dec ch            
jnz l1

fstp num1  ; No is  stored in a Variable
fstp num2  ; No is  stored in a Variable
fstp num3  ; No is  stored in a Variable
fstp num4  ; No is  stored in a Variable
fstp num5  ; No is  stored in a Variable



;finds the mean


fld num1
fld num2
fld num3
fld num4
fld num5

faddp st[1],st
faddp st[1],st
faddp st[1],st
faddp st[1],st

fld count
fdivp st[1],st

fstp fans        ; fans stores Mean  
fld fans         



fld st
fstp fans2
fld fans2
fld num1
fld fans2
fsubp st[1],st
fmul st,st
fld num2
fld fans2
fsubp st[1],st
fmul st,st
fld num3
fld fans2
fsubp st[1],st
fmul st,st
fld num4
fld fans2
fsubp st[1],st
fmul st,st
fld num5
fld fans2
fsubp st[1],st
fmul st,st

faddp st[1],st
faddp st[1],st
faddp st[1],st
faddp st[1],st


fld count
fdivp st[1],st
fld st
fstp fans1       ;  fans1 stores Variance
fld fans1        
fsqrt
fstp fans2       ;  fans2 stores Standard Deviation
fld fans2        







; Code to Display Mean, Variance, Standard Deviation

fld fans
fld fans
lea dx,msg1
mov ah,09h
int 21h
fld b
fmulp st[1],st
fbstp fans
mov ax,word ptr fans
mov a,ax
mov dl,ah
mov cl,04h
rol dl,cl
and dl,0Fh
add dl,30h
mov ah,02h
int 21h
mov ax,a
mov dl,ah
and dl,0Fh
add dl,30h
mov ah,02h
int 21h
lea dx,mm
mov ah,09h
int 21h
mov ax,a
mov dl,al
mov cl,04h
rol dl,cl
and dl,0Fh
add dl,30h
mov ah,02h
int 21h
mov ax,a
mov dl,al
and dl,0Fh
add dl,30h
mov ah,02h
int 21h


fld fans1
fld fans1
lea dx,msg2
mov ah,09h
int 21h
fld b
fmulp st[1],st
fbstp fans
mov ax,word ptr fans
mov a,ax
mov dl,ah
mov cl,04h
rol dl,cl
and dl,0Fh
add dl,30h
mov ah,02h
int 21h
mov ax,a
mov dl,ah
and dl,0Fh
add dl,30h
mov ah,02h
int 21h
lea dx,mm
mov ah,09h
int 21h
mov ax,a
mov dl,al
mov cl,04h
rol dl,cl
and dl,0Fh
add dl,30h
mov ah,02h
int 21h
mov ax,a
mov dl,al
and dl,0Fh
add dl,30h
mov ah,02h
int 21h
finit

fld fans2
fld fans2
lea dx,msg3
mov ah,09h
int 21h
fld b
fmulp st[1],st
fbstp fans
mov ax,word ptr fans
mov a,ax
mov dl,ah
mov cl,04h
rol dl,cl
and dl,0Fh
add dl,30h
mov ah,02h
int 21h
mov ax,a
mov dl,ah
and dl,0Fh
add dl,30h
mov ah,02h
int 21h
lea dx,mm
mov ah,09h
int 21h
mov ax,a
mov dl,al
mov cl,04h
rol dl,cl
and dl,0Fh
add dl,30h
mov ah,02h
int 21h
mov ax,a
mov dl,al
and dl,0Fh
add dl,30h
mov ah,02h
int 21h



mov ah,4ch
int 21h
end


