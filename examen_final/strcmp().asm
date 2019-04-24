;Macro
strcmp() macro MS, MS2, cadena1, cadena2, erro, bien
    
     LOCAL otro,error
    
     push ds			
	 pop es          

	 MOV DX, OFFSET MS
	 MOV AH, 09H
	 INT 21H

	
	 MOV DX,OFFSET CADENA1   
	 MOV AH,0AH
     INT 21H
   
     MOV     AH,0			 
     MOV     AL,3			
     INT     10H 
	
	 MOV DX, OFFSET MS2
	 MOV AH, 09H
	 INT 21H

	
	 MOV DX,OFFSET CADENA2   
	 MOV AH,0AH
     INT 21H
	
	
	
	 MOV     AH,0			 
     MOV     AL,3			
     INT     10H    

	
	
	 cld 
	 mov si,offset cadena1 + 1
	 lodsb
	 mov cl,al
	 mov si,offset cadena2 + 1
	 lodsb
	 
	 cmp al,cl
	 jne error
	 
 	
	 mov di,offset cadena1 + 2 
	 mov si,offset cadena2 + 2  
	
	 otro:
	 cmpsb
	 jnz error
	 dec cl
	 jnz otro
	
	
	 mov dx,offset bien
	 mov ah,09h
	 int 21h
	
	 jmp salir	
	
	 error:
	
	 mov dx,offset erro
	 mov ah,09h
	 int 21h
       
endm
  
 
;.MODEL	SMALL			;Recursos asignados por el sistema
;
;.STACK	100H			;Valor de la pila en hexa
;
;.DATA
;
;   ;Nombre    Tipo     Valor: 	      Espacio para la definicion
;
;    MS        DB    'Digite la clave ','$' 
;    MS2       DB    'Verifique la clave ','$' 
;	cadena1   db    15,0,15 dup (?)
;	cadena2   db    15,0,15 dup (?)
;	
;	;pass      db    'hola'   
;	erro      db    'error','$'
;	bien      DB    'correcto','$'
;
;.CODE				
;	
;	MOV	AX,@DATA
;	MOV	DS,AX 
;	
;	strcmp() MS, MS2, cadena1, cadena2, erro, bien 
;	
;   
;    push ds			
;	pop es          ; se hace que ds=es mediante la pila
;
;	MOV DX, OFFSET MS
;	MOV AH, 09H
;	INT 21H
;
;	
;	MOV DX,OFFSET CADENA1   ; ingresando el valor a ser comparado
;	MOV AH,0AH
;    INT 21H
;   
;    MOV     AH,0			; Ajusta modo video y limpia pantalla 
;    MOV     AL,3			; Modo de video
;    INT     10H 
;	
;	MOV DX, OFFSET MS2
;	MOV AH, 09H
;	INT 21H
;
;	
;	MOV DX,OFFSET CADENA2   ; ingresando el valor a ser comparado
;	MOV AH,0AH
;    INT 21H
;	
;	
;	
;	MOV     AH,0			; Ajusta modo video y limpia pantalla 
;    MOV     AL,3			; Modo de video
;    INT     10H    
;
;	
;	
;	 cld 
;	 mov si,offset cadena1 + 1
;	 lodsb
;	 mov cl,al
;	 mov si,offset cadena2 + 1
;	 lodsb
;	 
;	 cmp al,cl
;	 jne error
;	 
; 	
;	mov di,offset cadena1 + 2 
;	mov si,offset cadena2 + 2  
;	
;	otro:
;	cmpsb
;	jnz error
;	dec cl
;	jnz otro
;	
;	
;	mov dx,offset bien
;	mov ah,09h
;	int 21h
;	
;	jmp salir
;	
;	;lodsb				;extrae el byte con la cantidad de letras leidas desde el KB
;	
;	
;	error:
;	
;	mov dx,offset erro
;	mov ah,09h
;	int 21h
	

salir:
	MOV	AH,4CH
	INT	21H

END