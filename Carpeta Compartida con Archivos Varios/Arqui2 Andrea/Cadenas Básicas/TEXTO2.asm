;Programa para probar el ingreso de un texto al computador
;inserta el caracter de $ al final de la cadena
;luego la muestra en pantalla


.MODEL	SMALL			;Recursos asignados por el sistema

.STACK	100H			;Valor de la pila en hexa

.DATA

      ;Nombre    Tipo     Valor: 	      Espacio para la definición

        MS        DB    'Digite un texto','$'
	    cadena1   db     50,0,50 dup (0aah)

.CODE				
	MOV	AX,@DATA
	MOV	DS,AX
	push    ds	
	pop     es	


	MOV DX, OFFSET MS
	MOV AH, 09H
	INT 21H

	
	MOV DX,OFFSET CADENA1
	MOV AH,0AH
        INT 21H

	MOV     AH,0			; Ajusta modo video y limpia pantalla 
        MOV     AL,3			; Modo de video
        INT     10H    

	cld                     ; Activa DF para conteo ascendente en SI-DI
	mov si,offset cadena1 + 1
	lodsb				;extrae el byte con la cantidad de letras leidas desde el KB => AL
	
	mov ah,00h
	mov di,offset cadena1 + 2  ; DI contiene el inicio de la palabra
	
	add di,ax             ;se suma al inicio de la palabra digitada
		                   ; se tiene ahora apuntando DI al final de la palabra
	mov al,'$'
	
	stosb
	
	MOV DX, OFFSET cadena1 + 2
	MOV AH, 09H
	INT 21H
	
	
	MOV	AH,4CH
	INT	21H

END

