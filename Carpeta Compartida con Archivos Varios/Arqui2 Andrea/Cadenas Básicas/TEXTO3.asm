;Programa "textoc1.asm"para probar la verificacion de caracteres
;contra una clave predefinida.


.MODEL	SMALL			;Recursos asignados por el sistema

.STACK	100H			;Valor de la pila en hexa

.DATA

   ;Nombre    Tipo     Valor: 	      Espacio para la definicion

    MS        DB    'Digite la clave ','$' 
        
	cadena1   db    50,0,50 dup (?)
	cadena2   db    15,0,15 dup (?)
	
	pass      db    'hola'   
	erro      db    'error','$'
	bien      DB    'correcto','$'

.CODE				
	
	MOV	AX,@DATA
	MOV	DS,AX
   
    push ds			
	pop es          ; se hace que ds=es mediante la pila

	MOV DX, OFFSET MS
	MOV AH, 09H
	INT 21H

	
	MOV DX,OFFSET CADENA1   ; ingresando el valor a ser comparado
	MOV AH,0AH
    INT 21H

	
	
	
	
	MOV     AH,0			; Ajusta modo video y limpia pantalla 
    MOV     AL,3			; Modo de video
    INT     10H    

	
	
	cld
	mov di,offset cadena1 + 2 
	mov si,offset pass
	
	cmpsb
	jnz error
	
	mov dx,offset bien
	mov ah,09h
	int 21h
	
	jmp salir
	
	;lodsb				;extrae el byte con la cantidad de letras leidas desde el KB
	
	
	error:
	
	mov dx,offset erro
	mov ah,09h
	int 21h
	

salir:
	MOV	AH,4CH
	INT	21H

END