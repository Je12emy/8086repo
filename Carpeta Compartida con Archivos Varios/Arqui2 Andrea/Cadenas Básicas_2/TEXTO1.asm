;Programa para probar el ingreso de un texto al computador
;muestra la cantidad de caracteres que se ingresaron por KB


.MODEL	SMALL			;Recursos asignados por el sistema

.STACK	100H			;Valor de la pila en hexa

.DATA

      ;Nombre    Tipo     Valor: 	      Espacio para la definición

        MS        DB    'Digite un texto: ','$'
	    cadena1   db     50,0,50 dup (?)
	    cadena2   db     15,0,15 dup (?)

.CODE				
	MOV	AX,@DATA
	MOV	DS,AX


	MOV DX, OFFSET MS
	MOV AH, 09H
	INT 21H

	
	MOV DX,OFFSET CADENA1
	MOV AH,0AH
        INT 21H

	MOV     AH,0			; Ajusta modo video y limpia pantalla 
        MOV     AL,3			; Modo de video
        INT     10H    

	cld 

	
	mov si,offset cadena1 + 1
	lodsb				;extrae el byte con la cantidad de letras leidas desde el KB
	
	add al,30H
	mov dl,al			;prepara el despligue
 	mov ah,02h
	int 21h				;despliega el contenido de dl=al= pos 2 de la cadena.

	MOV	AH,4CH
	INT	21H

END

