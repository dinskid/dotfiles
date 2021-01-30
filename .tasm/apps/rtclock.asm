;TSR FOR REAL TIME CLOCK
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

.model tiny
.code
org 100h
begin:
        jmp init
        oldint8 dd ?  ;define double word
        cnt db 00h
        row db 00h
        col db 00h
        sec db 00h
        min db 00h
        hrs db 00h
my_isr:
        pushall
        mov ax,cs
        mov ds,ax
        add cs:cnt,01
        cmp cs:cnt,18
        jne down
        mov cs:cnt,00h
        mov ah,02h     ;get time
        int 1ah         ;gives time
        mov cs:sec,dh  ;d-data,
        mov cs:min,cl
        mov cs:hrs,ch
        mov ah,03h   ;get curser position
        mov bh,00h
        int 10h      ;10h -for vedio mode
        mov cs:row,dh
        mov cs:col,dl
        mov ah,02h     
        mov bh,00h    
        mov dh,23
        mov dl,70
        int 10h
        mov ah,09h
        mov al,cs:sec
        and al,0f0h
        ror al,1
        ror al,1
        ror al,1
        ror al,1
        add al,30h
        mov bh,0
        mov bl,16h
        mov cx,01h
        int 10h
        mov ah,02h
        mov bh,00h
        mov dh,23
        mov dl,71
        int 10h
        mov ah,09h
        mov al,cs:sec
        and al,0fh
        add al,30h
        mov bh,0
        mov bl,16h
        mov cx,01h
        int 10h
        jmp ab
down:
        jmp down1
ab:
        mov ah,02h
        mov bh,00h
        mov dh,23
        mov dl,67
        int 10h
        mov ah,09h
        mov al,cs:min
        and al,0f0h
        ror al,1
        ror al,1
        ror al,1
        ror al,1
        add al,30h
        mov bh,0
        mov bl,16h
        mov cx,01h
        int 10h
        mov ah,02h
        mov bh,00h
        mov dh,23
        mov dl,68
        int 10h
        mov ah,09h
        mov al,cs:min
        and al,0fh
        add al,30h
        mov bh,0
        mov bl,16h
        mov cx,01h
        int 10h
        jmp bc
down1 :
        jmp ahead
bc :
        mov ah,02h
        mov bh,00h
        mov dh,23
        mov dl,64
        int 10h
        mov ah,09h
        mov al,cs:hrs
        and al,0f0h
        ror al,1
        ror al,1
        ror al,1
        ror al,1
        add al,30h
        mov bh,0
        mov bl,16h
        mov cx,01h
        int 10h
        mov ah,02h   ;set curser position
        mov bh,00h   ;page 0
        mov dh,23    ;row
        mov dl,65    ;col
        int 10h
        mov ah,09h  ;write character & atribute at curser
        mov al,cs:hrs ;character
        and al,0fh
        add al,30h
        mov bh,0     ;page 0
        mov bl,16h   ;colour
        mov cx,01h   ;count of character to write
        int 10h     
        mov ah,00h
        mov dh,cs:row
        mov dl,cs:col
        int 10h
ahead:
        popall
        jmp cs:oldint8
init:
        cli
        mov ah,35h   ;get intrupt vector type 8
        mov al,8     ;set intrupt vector type 8
        int 21h

        mov word ptr oldint8,bx
        mov word ptr oldint8+2,es
        mov ah,25h
        mov al,08
        mov dx,offset my_isr
        int 21h

        mov ah,31h
        mov dx,offset init
        int 21h
        sti              ;set intrupt flag
        end begin
        end
;

;C:\TASM>tasm tsr1.asm
;Turbo Assembler  Version 3.0  Copyright (c) 1988, 1991 Borland International

;Assembling file:   tsr1.asm
;Error messages:    None
;Warning messages:  None
;Passes:            1
;Remaining memory:  459k


;C:\TASM>tlink/t tsr1.obj
;Turbo Link  Version 2.0  Copyright (c) 1987, 1988 Borland International

;C:\TASM>tsr1

;C:\TASM>


                                                                15 51 43