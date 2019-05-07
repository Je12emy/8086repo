;****************************************************************************************
; Programa "4MUL" 
;****************************************************************************************

.MODEL	SMALL			;Recursos asignados por el sistema

.STACK	100H			;Valor de la pila en hexa

.DATA

        ;Nombre   Tipo   Valor: 	Espacio para la definición

	
.CODE				

inicio:					; inicio del programa
	MOV	AX,@DATA
	MOV	DS,AX

	xor ax,ax               ; asegura que el registro se limpie
	
	mov al,0FFh
	xor ax,ax
	
	MOV AL,-1
	MOV CL,6
	MUL CL
	
	MOV AL,-1
	IMUL CL   
					; Sale del programa
	MOV	AH,4CH
	INT	21H

END					; Fin del programa

