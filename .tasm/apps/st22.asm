disp macro msg
mov ah,09h
mov dx,offset msg
int 21h
endm

extrn str1:byte
extrn str2:byte
extrn str3:byte

public concat
public subst

.model small
.stack

.data
msgy db 10,13,"It is a substr$"
msgn db 10,13,"It is not a substr$"
msgr db 10,13,"No. of occurrences:$"
c_addr dw ?
e_addr dw ?

count db 0
.code


        mov ax,@data
        mov ds,ax

concat proc far

        mov si,offset str1
        mov di,offset str3
        mov ch,00
        mov cl,byte ptr[si+1]
        inc si
        inc si
        rep movsb
        mov si,offset str2
        mov cl,byte ptr[si+1]
        inc si
        inc si
        rep movsb
        ret
concat endp

 
subst proc far
        mov bl,00h
        lea si,str1+2
        mov c_addr,si
        mov dl,str1+1
        mov dh,00h
        mov ax,si
        add ax,dx
        mov e_addr,ax
s1:
        mov ch,0
        mov cl,str2+1
        lea di,str2+2
bb:
        mov bh,[si]
        cmp bh,byte ptr [di]
        jnz next
        inc si
        inc di
        loop bb
        inc bl
        cmp si,e_addr
        jnz s1
        jmp last
next:
        mov si,c_addr
        inc si                                 
        mov c_addr,si
        cmp si,e_addr
        jnz s1
last:
        disp msgr
        mov al,bl
        call dis_hex
        ret   
subst endp
dis_hex proc near
        mov ah,00h
        aam             
        add ax,3030h
        mov bx,ax
        mov dl,bh
        mov ah,02h
        int 21h
        mov dl,bl
        int 21h
        sub dl,30h
        cmp dl,00h
        jz s2
        disp msgy
        jmp re
s2:     disp msgn
re:     ret 
dis_hex endp
end





