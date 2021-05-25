DATA SEGMENT
s db 'ABCDEFG$'
string db 50 DUP('$')
DATA ENDS

CODE SEGMENT
ASSUME CS:CODE,DS:DATA

COUT PROC
; si must be set to string before calling
; must be terminated with '$'
mov ah, 02h
loop1:
	lodsb
	cmp al, '$'
	je loop1exit
	mov dl, al
	int 21h
	jmp loop1
loop1exit:
mov dl, 0ah
int 21h
mov dl, 0dh
int 21h
RET
COUT ENDP

START:

mov ax, data
mov ds, ax

lea si, s
call cout

mov ah, 4ch
int 21h

CODE ENDS
END START

