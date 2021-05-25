.MODEL SMALL

.DATA
  MSG DB 10,13,"ENTER THE NUMBER :$"
    MSG1 DB 10,13,"ENTERED NO IS...$"
    MSG2 DB 10,13,"HOW MANY NUMBERS U WANT TO ADD...$"
    MSG3 DB 10,13,"ARRY ELEMENTS ARE:$"
    MSG4 DB 10,13,"SUMATION :$"
    CNT1 DB ?
    CNT2 DB ?
    CNT3 DB ?
    SUM1 DB 00
    ARR DB 20 DUP (?)
    SUM DW ?
.CODE

   DISP MACRO XX
   MOV AH,09H
   LEA DX,XX
   INT 21H
   ENDM

   INPUT MACRO 
   MOV AH,01H
   INT 21H
ENDM

OUTPUT MACRO
MOV AH,02H
INT 21H
ENDM

   MOV AX,@DATA
   MOV DS,AX

DISP  MSG2

INPUT
 CMP AL,39H
 JBE L6
 SUB AL,07H
L6:
  SUB AL,30H
  MOV CNT1,AL
  MOV CNT2,AL
  MOV CNT3,AL

LEA SI,ARR

BACK:
        MOV BL,00
        MOV CH,02
        MOV CL,04

DISP MSG
BCK:

 INPUT
 CMP AL,39H
 JBE L1
 SUB AL,07H
L1:
  SUB AL,30H
  ADD BL,AL
  ROL BL,CL
  DEC CH
  JNZ BCK
  ROL BL,CL
  MOV [SI],BL
  INC SI
  DEC CNT1
  JNZ BACK

LEA SI,ARR
DISP MSG3
M1:

MOV DH,[SI]
ROL DH,CL
MOV CH,02
DISP1:
       
        AND DH,0FH
        CMP DH,09H
        JBE L9
        ADD DH,07
      L9: ADD DH,30H
          MOV DL,DH
          OUTPUT
          MOV DH,[SI]
          DEC CH
          JNZ DISP1
          INC SI
          DEC CNT2
          JNZ M1

LEA SI,ARR
ADDITION:
          MOV AL,[SI]
          ADC SUM1,AL
          INC SI
          DEC CNT3
          JNZ ADDITION
DISP MSG4
MOV DH,SUM1
ROL DH,CL
MOV CH,02
XY:
   AND DH,0FH
   CMP DH,09H
   JBE L41
   ADD DH,07H
 L41: ADD DH,30H
      MOV DL,DH
      OUTPUT
      MOV DH,SUM1
      DEC CH
      JNZ XY




MOV AH,4CH
INT 21H
END

