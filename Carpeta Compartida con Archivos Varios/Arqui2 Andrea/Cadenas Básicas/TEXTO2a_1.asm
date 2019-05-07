;Programa "texto2a" para probar el ingreso de un texto al computador
;inserta el caracter de $ al final de la cadena
;luego la muestra en pantalla


.MODEL	SMALL			;Recursos asignados por el sistema

.STACK	100H			;Valor de la pila en hexa

.DATA

      ;Nombre    Tipo     Valor: 	      Espacio para la definición

    MS        DB    'Digite su clave','$'
	                                        
    MS2        DB    'Digite de nuevo su clave','$'	                                        
    
	cadena1   db     15,0,15 dup (?)
	
	cadena2   db     15,0,15 dup (?)
       
       
    erro db ' error','$'
    bien db 'correcto','$'


   
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
    
    
    MOV DX, OFFSET MS2
	MOV AH, 09H
	INT 21H

	
	MOV DX,OFFSET CADENA2
	MOV AH,0AH
        INT 21H

	MOV     AH,0			; Ajusta modo video y limpia pantalla 
        MOV     AL,3			; Modo de video
        INT     10H  
    
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
; aca se tienen en 2 espacios de memoria las claves
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    
    
	cld                     ; Activa DF para conteo ascendente en SI-DI
	
	mov si,offset cadena1 + 1
	
			
	lodsb				;extrae el byte con la cantidad de letras leidas desde el KB => AL
	
	mov bl,al
	
	mov si,offset cadena2 + 1
	
			
	lodsb				;extrae el byte con la cantidad de letras leidas desde el KB => AL
	
	cmp al,bl
	jne error       ; si las longitudes son diferentes, termine
	 
	;mov ah,00h
	
	mov si,offset cadena1 + 2
	
	mov di,offset cadena2 + 2  ; DI contiene el inicio de la palabra
	
	mov cl,al    
	mov ch,00h       ;CX vale el tamaño de la cadena
otro:
		
	cmpsb           ;comparamos DI contra SI
	jne error       ;si no son iguales salte
	loop otro       ;hace lazo
	
	
	
	
    MOV DX, OFFSET bien
	MOV AH, 09H
	INT 21H
    jmp fin


error:

    MOV DX, OFFSET erro
	MOV AH, 09H
	INT 21H
    
fin:
	MOV	AH,4CH
	INT	21H

END

