;****************************************************************************************
; Programa "5DIV" 
;****************************************************************************************

.MODEL	SMALL			;Recursos asignados por el sistema

.STACK	100H			;Valor de la pila en hexa

.DATA

        ;Nombre   Tipo   Valor: 	Espacio para la definición

	
.CODE				

inicio:					; inicio del programa
	MOV	AX,@DATA
	MOV	DS,AX

        
	   
	MOV AX,00FFH
	MOV BL,8
	DIV BL
	
	MOV AX,0FFFFH
	MOV BX,8
	DIV BX   
	
	MOV AX,0100H
	MOV BL,8
	DIV BL
					; Sale del programa
	MOV	AH,4CH
	INT	21H

END					; Fin del programa

