;**************************************************************
; Programa "5_call" Despliegue pantalla e ingresa datos a variables
; declaradas para luego mostrarlas en pantalla
;**************************************************************

.MODEL	SMALL
.STACK	100H
.DATA
        MEN1    DB      'Digite el primer numero ','$'
        MEN2    DB      'Digite el segundo numero ','$'

        VA      DB      '?'
        VB      DB      '?'
	    X       DB      '?'
        Y       DB      '?'

.CODE
  
  
  
  
  
INIC	PROC
        MOV     AX,@DATA
        MOV     DS,AX

        MOV     AH,0
        MOV     AL,3
        INT     10H

        MOV     X,10
        MOV     Y,1
        CALL    CURSOR
        LEA     DX,MEN1
        CALL    MENSAJE
	
	MOV AH,01H
	INT 21H
	MOV VA,AL

	MOV     X,10
        MOV     Y,2
        CALL    CURSOR
        LEA     DX,MEN2
        CALL    MENSAJE

	MOV AH,01H
	INT 21H
	MOV VB,AL	



;SE DESPLIEGA CONTENIDO DE LAS VARIABLES

	MOV     AH,0
        MOV     AL,3
        INT     10H
       

	MOV     X,5
        MOV     Y,5
	CALL CURSOR
        MOV DL,VA
	MOV AH,2
	INT 21H
	
	MOV     X,15
        MOV     Y,5
	CALL CURSOR
	MOV DL,VB
	MOV AH,2
	INT 21H

	MOV	AH,1			;Espera tecla por medio del DOS
	INT	21H


	MOV AH,4CH      ; VUELTA AL
        INT 21H         ; DOS

ENDP

;***********************DESPLIEGA EN PANTALLA*******************************

MENSAJE PROC				; Inicio de la rutina = nombre + PROC	
      	MOV	AH,9
        INT     21H                     
        RET
ENDP					; Fin de la rutina = fin de procedimiento

;*************************COLOCA CURSOR*************************************
 
CURSOR  PROC  
        MOV     AH,2
        MOV     DL,X
        MOV     DH,Y
        INT     10H                     ; Coloca cursor para desplegar mensaje
        RET
ENDP					; Fin de la rutina

END					; Fin del programa
