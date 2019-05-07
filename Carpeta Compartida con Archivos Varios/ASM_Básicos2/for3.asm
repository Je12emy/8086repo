;**************************************************************
; Programa "for3" carga en AL las veces que es mostrado en 
; pantalla un dato. Luego repite el despliegue AL veces.
;**************************************************************


.MODEL SMALL       
.STACK 100H

.DATA
 
	MEN1    DB  '*','$'

.CODE

	MOV     AX,@DATA
    MOV     DS,AX

    MOV     AH,0
    MOV     AL,3
    INT     10H	
	
	MOV 	AH,01H
	INT 	21H		; CARGA EN "AL" LAS VECES A MOSTRAR
	
	SUB 	AL, 30H

	XOR 	CX,CX		; LIMPIA EL REGISTRO	
	MOV 	CL,AL

	MOV     AH,0
    MOV     AL,3
    INT     10H		; LIMPIA PANTALLA

OTRO: LEA   DX,MEN1
   	CALL    MENSAJE
	PUSH 	CX      ;coloca en la pila
	CALL	RETARDO
	POP	    CX      ;extrae de la pila
	DEC 	CL
	JNZ	    OTRO
	
	MOV 	AH,4CH      	; VUELTA AL DOS
    INT 	21H         


;***********************DESPLIEGA EN PANTALLA*******************************

MENSAJE PROC
   	MOV	    AH,9
    INT     21H                     
    RET
ENDP


;***********************RETARDA LA PANTALLA*******************************

RETARDO PROC
        MOV 	CX,0FFFFH	
RETARDO1:
        MOV 	BX,0FFFFH
RETARDO2:
        DEC 	BX
        JNZ 	RETARDO2
        LOOP 	RETARDO1
        RET
ENDP


END				; Fin del programa 

