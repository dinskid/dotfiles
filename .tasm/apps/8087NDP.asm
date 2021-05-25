print macro msg
mov ah,09h
lea dx,msg
int 21h
endm

.model small
.stack
.data

m1 db 10,13,"Mean is$"
m2 db 10,13,"STD DEVIATION is$"
m3 db 10,13,"VARIANCE IS$"

data1 dd 9.0,1.0
sum dt 0
c1 dw 2
c2 dw 100

mean dt 0
stddev dt 0
variance dt 0

.code
        ;assume cs:code,ds:data
.startup

        mov ax,@data
        mov ds,ax

        ;for mean...

        print m1
        mov cx,05
        mov bx,00
        finit
        fldz
x:
        fld data1[bx]
        fadd st,st(1)
        inc bx
        dec cx
        jnz x
        fidiv c1
        fimul c2
        fbstp mean
        lea bp,mean
        call disp

        ;for std deviation...
        print m2
        mov cx,05
        mov bx,00
        finit
        fld sum
y:
        fbld mean
        fidiv c2
        fld data1[bx]
        fsub st,st(1)
        fmul st,st
        fadd st,st(2)
        fstp sum
        inc bx
        dec cx
        jnz y
        fld sum
        fidiv c1
        fsqrt
        fimul c2
        fbstp stddev
        lea bp,stddev
        call disp

        ;for variance..

        print m3
        fbld stddev
        fidiv c2
        fmul st,st
        fimul c2
        fbstp variance
        lea bp,variance
        call disp

        mov ah,4ch
        int 21h

disp proc
        mov si,09
        back:
                mov bl,byte ptr[bp+si]
                call disp1
                dec si
                cmp si,00
                jne back

                mov ah,02h
                mov dl,'.'
                int 21h

                mov bl,byte ptr[bp]
                call disp1
                ret
                disp endp

disp1 proc
        mov ch,02
        mov cl,04
 x1:
        rol bl,cl
        mov dl,bl
        and dl,0fh
        add dl,30h

        mov ah,02h
        int 21h
        dec ch
        jnz x1
        ret
        disp1 endp

        end
