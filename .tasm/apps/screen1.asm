.model small
.stack
.code

main:
        jmp init
        m1 db "*****This is screen saver****$"
        old_add dd ?
        old_kbd dd ?
        buff db 4000 dup (0)
        cnt db 0
        flag db 0

our_isr:
        push ax
        push bx
        push cx
        push dx
        push es
        push ds
        push ss
        push si
        push di

        mov ax,cs
        mov ds,ax

        cmp flag,1
        je exit_isr

        inc cnt
        cmp cnt,100
        jne exit_isr

        mov flag,01
        mov si,0B800h
        mov es,si
        mov cx,2000
        lea di,buff
        mov si,00

save:
        mov al,es:[si]
        mov [di],al
        mov al,' '
        mov es:[si],al
        inc si
        inc di
        mov [di],al
        mov al,00100111B
        mov es:[si],al
        inc si
        inc di
        dec cx
        jnz save
        lea di,m1
        mov si,2000

print_msg:
        mov al,[di]
        cmp al,'$'
        je exit_isr
        mov es:[si],al
        inc di
        add si,02
        jmp print_msg

exit_isr:
        pop di
        pop si
        pop ss
        pop ds
        pop es
        pop dx
        pop cx
        pop bx
        pop ax
        jmp cs:old_add

our_kbd:
        
        push ax
        push bx
        push cx
        push dx
        push es
        push ds
        push ss
        push si
        push di

        mov ax,cs
        mov ds,ax
        mov cnt,0
        cmp flag,0
        je exit_kbd
        mov si,0B800h
        mov es,si
        mov si,0
        lea di,buff
        mov cx,4000

restore:
        mov al,[di]
        mov es:[si],al
        inc si
        inc di
        dec cx
        jnz restore

exit_kbd:
        pop di
        pop si
        pop ss
        pop ds
        pop es
        pop dx
        pop cx
        pop bx
        pop ax
        jmp cs:old_kbd

init:
        cli

        mov ax,cs
        mov ds,ax

        mov ah,35h
        mov al,8
        int 21h

        mov word ptr old_add+2,es
        mov word ptr old_add,bx

        mov ah,25h
        mov al,8
        lea dx,our_isr
        int 21h

        mov ah,35h
        mov al,9
        int 21h

        mov word ptr old_kbd+2,es
        mov word ptr old_kbd,bx

        mov ah,25h
        mov al,9
        lea dx,our_kbd
        int 21h

        mov ah,31h
        mov al,0
        lea dx,init
        int 21h
     sti
  end
