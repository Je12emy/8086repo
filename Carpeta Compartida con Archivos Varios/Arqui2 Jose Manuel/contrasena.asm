;Programa "texto3.asm"para probar la verificacion de caracteres
;contra una clave predefinida.


.MODEL	SMALL			;Recursos asignados por el sistema

.STACK	100H			;Valor de la pila en hexa

.DATA

   ;Nombre    Tipo     Valor: 	      Espacio para la definicion

    MS        DB    'Digite la clave ','$' 
        
	cadena1   db    50,0,50 dup (?)
	mensaje   db    'Debe Ingresar al menos 8 caracteres!!!','$'
	pass      db    '1hola2t4'   
	erro      db    'error','$'
	bien      DB    'correcto','$'  
	
	;menu
	menu1     db    '1- Muestra contrasena sin numeros','$'
	menu2     db    '2- Muestra contrasena sin letras','$'
	menu3     db    '3- Salir','$'                    
	numeross  db    '?'.'$'
	letrass   db    '?','$'   
	selec     db    0

.CODE				
	
nuevo:
	MOV	AX,@DATA
	MOV	DS,AX
    
    call limpiar  
   
    push ds			
	pop es          ; se hace que ds=es mediante la pila

	MOV DX, OFFSET MS
	call imprimir

	
	MOV DX,OFFSET CADENA1   ; ingresando el valor a ser comparado
	MOV AH,0AH
    INT 21H
    
    mov si,offset cadena1 + 1
    lodsb
    
    
    cmp al,08h
    je entra
    cmp al,08h   ;compara lo digitado con un ocho 
    jng minimo     	
	
	call limpiar   

	
entra:	
	cld
	mov di,offset cadena1 + 2 
	mov si,offset pass
	mov cl,04 
	
otro:	
	cmpsb
	jnz error
	dec cl
	jnz otro
	

	call nueva_linea
	mov dx,offset bien
	call imprimir

volver:
    call esperar
    call menu
    call esperar  
    mov selec,al
	call seleccion
	
	jmp salir


	
	;lodsb				;extrae el byte con la cantidad de letras leidas desde el KB
	

error:
	
	mov dx,offset erro
	call imprimir 

minimo:
    mov ah,0
    mov al,3
    int 10h
    
    lea dx, mensaje
    call imprimir
    
    call nueva_linea     
    call esperar
    
    
    jmp nuevo

UNO:
    mov bx, offset cadena1[2]
    call limpiar   
    jmp otroo 
    
DOS:        
    mov bx, offset cadena1[2]
    call limpiar   
    jmp otroo

otroo: 
    mov dl, [bx]
    call compara
    loop otroo
    	

numeros:    
    cmp dl,0Dh
    je volver
    inc bx
    cmp selec,31h
    je otroo
    cmp selec,32h
    je mostrar_numeros  
         
mostrar_numeros:
    mov ah,2
    int 21h    
    jmp otroo         

letras:
    cmp dl,0Dh
    je volver
    inc bx 
    cmp selec,31h
    je mostrar_letras
    cmp selec,32h
    je otroo 

mostrar_letras:
    mov ah,2
    int 21h    
    jmp otroo

salir:
	MOV	AH,4CH
	INT	21H


;;;;;;;;;;;;;;;;;;;;;;PROCEDIMIENTOS

nueva_linea PROC  
            mov dl, 13
            mov ah, 2
            int 21h   
            mov dl, 10                                     
            mov ah, 2
            int 21h   
            ret                                    
endp                                               

esperar     PROC
            mov ah,01h
            int 21h
            ret
endp     

menu        PROC   
            call limpiar
            call nueva_linea
            lea dx,menu1
            call imprimir
            call nueva_linea
            lea dx,menu2
            call imprimir
            call nueva_linea
            lea dx,menu3
            call imprimir
            call nueva_linea
            ret
endp  

seleccion   PROC
            cmp al,31h
            je UNO
            cmp al,32h
            je DOS 
            cmp al,33h
            je salir
            ret
endp

imprimir    PROC
            mov ah,9
            int 21h
            ret
endp       

limpiar     PROC
            MOV     AH,0			; Ajusta modo video y limpia pantalla 
            MOV     AL,3			; Modo de video
            INT     10H 
            ret
endp 

compara     PROC     
            cmp dl,3ah
            jng numeros
            cmp dl, 40h
            jg letras 
            ret
endp  


END