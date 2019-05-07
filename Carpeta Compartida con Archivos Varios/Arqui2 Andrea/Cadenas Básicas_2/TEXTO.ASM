;**************************************************************
;**************************************************************


.MODEL	SMALL				;Recursos asignados por el sistema

.STACK	100H				;Valor de la pila en hexa

.DATA

    ;Nombre   Tipo   Valor: 	Espacio para la definición


    MS        DB    'Digite un texto','$'
	cadena1   db     50,0,50 dup (?)     ;TAMAÑO BUFFER,BYTES LEIDOS,CANTIDAD DUP (?)
	cadena2   db     15,0,15 dup (?)     ;TAMAÑO BUFFER,BYTES LEIDOS,CANTIDAD DUP (?)



.CODE				;Inicio del programa
	MOV	AX,@DATA
	MOV	DS,AX


	MOV DX, OFFSET MS
	MOV AH, 09H
	INT 21H			; despliega el mensaje

	MOV AH,0AH		; ingresa valores desde el teclado
	MOV DX,OFFSET CADENA1	; se usa cadena1 
	INT 21H
     
     
    MOV     AH,00			;Selecciona modo de video
    MOV     AL,03			; Modo de video 03H 80colx25filas
    INT     10H 
         
	MOV DX,OFFSET CADENA1 	; se busca cadena1
	MOV AH,09H		; desplieque en pantalla
	INT 21H


	MOV	AH,4CH		; se devuelve al DOS
	INT	21H

END				; Fin del programa

