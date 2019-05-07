;Programa "texto4.asm"para convertir y copiar caracteres
;entre cadenas


.MODEL	SMALL			;Recursos asignados por el sistema

.STACK	100H			;Valor de la pila en hexa

.DATA

  ;Nombre    Tipo     Valor: 	      Espacio para la definicion

    MS1       DB   'Digite una palabra  ','$'  
        
	cadena1   db    50,0,50 dup (?)
	cadena2   db    15,0,15 dup (?)
	

.CODE				
	
	MOV	AX,@DATA
	MOV	DS,AX
   
    push ds			
	pop es          ; se hace que ds=es mediante la pila

	MOV DX, OFFSET MS1
	MOV AH, 09H
	INT 21H
     
    MOV DX,OFFSET CADENA1   ; ingresando el valor a ser comparado
	MOV AH,0AH
    INT 21H 
   
    MOV     AH,0			; Ajusta modo video y limpia pantalla 
    MOV     AL,3			; Modo de video
    INT     10H  
    
    mov si,offset cadena1 + 1
	lodsb	                ; en AL tenemos la cantidad de letras de la clave  
		  
	mov cl,al
	mov ch,00h              ; CX contiene el valor completo del conteo
	
	cld
	mov di,offset cadena2 
	mov si,offset cadena1 + 2
	
	ciclo:	                  
	    lodsb               ;extrae de donde apunta SI                  
	    add al,05           ;mov al,'*'            
	    stosb               ;almacena a donde apunta DI    
	loop ciclo                 
	
	
	mov si,offset cadena1 + 1
	lodsb				;extrae el byte con la cantidad de letras leidas desde el KB => AL
	
	mov ah,00h
	mov di,offset cadena2 ; DI contiene el inicio de la palabra
	
	add di,ax              ;se suma al inicio de la palabra digitada
		                   ; se tiene ahora apuntando DI al final de la palabra
	mov al,'$'
	stosb
		  
    MOV     AH,0			; Ajusta modo video y limpia pantalla 
    MOV     AL,3			; Modo de video
    INT     10H  
		
	mov dx,offset cadena2
	mov ah,09h
	int 21h
	
	MOV	AH,4CH
	INT	21H

END