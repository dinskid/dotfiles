SORT MACRO CMD
        LOCAL OUTER_LOOP, INNER_LOOP, CONTINUE
        MOV CX, [LEN]
        OUTER_LOOP:
                MOV DI,LEN
                SUB DI,CX ; GETTING DI AS INCREMENTS OF 1

                SHL DI,1 ; GETTING 2*I
                MOV SI, DI
                MOV BX, DI ; BX IS INDEX OF MIN ELEMENT

                PUSH CX
                INNER_LOOP:
                        MOV AL,[ARR+BX+1]
                        CMP AL,[ARR+SI+1]
                        CMD CONTINUE
                        MOV BX,SI
                        CONTINUE:
                                ADD SI, 2
                                LOOP INNER_LOOP
                MOV AL,[ARR+DI+1]
                XCHG AL, [ARR+BX+1]
                MOV [ARR+DI+1], AL
                POP CX
                LOOP OUTER_LOOP
ENDM

DATA SEGMENT
ARR DB 100 DUP(?)
LEN DW 5
DATA ENDS

CODE SEGMENT
ASSUME CS:CODE, DS:DATA

PROC ENDL
MOV AH, 02H
MOV DL, 0AH
INT 21H
MOV AH, 02H
MOV DL, 0DH
INT 21H
RET
ENDL ENDP

PRINT PROC
        MOV CX, [LEN]
        MOV SI,0
        OUTPUT:
                SHL SI, 1
                MOV DL, [ARR+SI+1]
                SHR SI, 1
                ADD DL, 30H
                MOV AH, 02H
                INT 21H
                INC SI
                MOV DL, ' '
                INT 21H
                LOOP OUTPUT
        RET
ENDP

START:
MOV AX, DATA
MOV DS, AX

MOV AH,1
INT 21H
SUB AL,30H
CBW

MOV [LEN],AX
MOV CX, AX

MOV SI, 0
CALL ENDL
INPUT:
        MOV AH,01H
        INT 21H
        SUB AL, 30H

        MOV [ARR+SI], 0H
        MOV [ARR+SI+1],AL
        ADD SI, 2
        CALL ENDL
        LOOP INPUT
SORT JL
CALL PRINT

CALL ENDL

SORT JG
CALL PRINT

MOV AH, 4CH
INT 21H

CODE ENDS
END START
