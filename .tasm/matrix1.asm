data segment
mat1 db 01H, 01H, 01H, 02H, 02H, 02H, 03H, 03H, 03H
mat2 db 04H, 04H, 04H, 05H, 05H, 05H, 06H, 06H, 06H
;mat3 dw 0018H
mat3 db 09 dup(0)

m1 db 03
n1 db 03

m2 db 03 
n2 db 03

sum db 00h
data ends
code segment
assume cs:code, ds:data, ss:data

start:
	mov ax, data
	mov ds, ax
	mov ss, ax

	mov si, offset mat1
	mov di, offset mat2
	mov bp, offset mat3

	mov cl, m1
	loop1: ;for(i=0; i<m1; i++)

		mov bl, n2 ;counter
		loop2: ;for(j=0; j<n2; j++)
			
			mov ch, m2
			mov sum, 00H
			loop3: ;for(k=0; k<n1; k++)
				mov ah, 00h
				mov al, [si]
				mul byte ptr [di]

				mov dl, sum
				add dl, al
				mov sum, dl

				inc si
				add di, 03

				dec ch
				jnz loop3

			mov dl, sum
			mov [bp], dl
			inc bp
			int 3

			sub si, 03
			sub di, 09

			; inc di 		;point to second column
			dec bl
			jnz loop2

		add si, 03h
		dec cl	
		jnz loop1
		int 3
code ends
end start

