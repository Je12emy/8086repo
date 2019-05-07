;Programa "texto2b.asm"para probar la verificacion de caracteres
;contra una clave cualquiera.


.MODEL	SMALL			;Recursos asignados por el sistema

.STACK	100H			;Valor de la pila en hexa

.DATA

   ;Nombre    Tipo     Valor: 	      Espacio para la definicion

    
    MS1       DB    'Digite su clave: ','$' 
    MS2       DB    'Confirme su clave: ','$' 
        
	
	cadena1   db    15,0,15 dup (7)
	cadena2   db    15,0,15 dup (?)
	
    erro      db    'error','$'
	bien      DB    'correcto','$'



.CODE				
	
	MOV	AX,@DATA
	MOV	DS,AX
   
    push ds			
	pop es          ; se hace que ds=es mediante la pila

	MOV DX, OFFSET MS1
	MOV AH, 09H
	INT 21H

	
	MOV DX,OFFSET CADENA1   ; se ingresa la primera palabra a ser comparada
	MOV AH,0AH
    INT 21H

	MOV AH,0			; Ajusta modo video y limpia pantalla 
    MOV AL,3			; Modo de video
    INT 10H    
	 
	MOV DX, OFFSET MS2
	MOV AH, 09H
	INT 21H

	
	MOV DX,OFFSET CADENA2   ; se ingresa la 2a palabra a ser comparada
	MOV AH,0AH
    INT 21H 
	

	MOV AH,0			; Ajusta modo video y limpia pantalla 
    MOV AL,3			; Modo de video
    INT 10H    
 	cld                 ;asegura que se incremente SI o DI
 	    
    mov si,offset cadena1 + 1 
    lodsb
    
    mov bl,al ; ponemos en BL la long de cadena1
	 
	mov si,offset cadena2 + 1 
    lodsb     ; tenemos en AL la long de cadena2
                                                
    cmp al,bl
    
    jnz error  ; si no son de igual longitud sale                                          
	 
	mov cl,al      ; indica la cantidad de comparaciones por hacer
	mov ch,00h 
	
	mov si,offset cadena1 + 2 
    mov di,offset cadena2 + 2 

	
	
    ciclo:                  
	    cmpsb   ; compara [SI] con [DI] direccion que el mismo CMPSB va incrementando
	    jnz error
	loop ciclo  ; decrementa CL y salta en tanto que CL !=0
	
	
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