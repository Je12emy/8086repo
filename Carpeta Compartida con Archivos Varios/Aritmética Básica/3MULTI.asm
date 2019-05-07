;****************************************************************************************
; Programa "3MUL" 
;****************************************************************************************

.MODEL	SMALL			;Recursos asignados por el sistema

.STACK	100H			;Valor de la pila en hexa

.DATA

        ;Nombre   Tipo   Valor: 	Espacio para la definición

	
.CODE				

inicio:					; inicio del programa
	MOV	AX,@DATA
	MOV	DS,AX

	MOV AL,0FFH
	MOV CL,5
	MUL CL
	
	MOV AX,0FFFFH
	MOV CX,0FFFFH
	MUL CX   
					; Sale del programa
	MOV	AH,4CH
	INT	21H

END					; Fin del programa

