;include macros_examen.txt         










;MACROS [TEMPORAL]
strlen() macro largo, decimas, unidades
    mov al,largo 
    dec al
    AAM
	
	MOV decimas,AH
	MOV unidades,AL
	
	ADD decimas,30H
	ADD unidades,30H
	
	                        ;getchr()
	mov dl,decimas			
 	mov ah,02h
	int 21h				    
                      
                            ;getchr()
    mov dl,unidades			
 	mov ah,02h
	int 21h       
    
    mov ah,01h
    int 21h  
endm

strcmp() macro MS, MS2, cadena1, cadena2, erro, bien
    
     LOCAL otro,error, end_macro              
   
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
	 
	 mov si,offset cadena2 + 1
	 lodsb  
	 mov cl,al	 
 	
	 mov di,offset cadena1 
	 mov si,offset cadena2 + 2  
	
	 otro:
	 cmpsb
	 jnz error
	 dec cl
	 jnz otro
	
	
	 mov dx,offset bien
	 mov ah,09h
	 int 21h
	
	 jmp end_macro	
	
	 error:
	
	 mov dx,offset erro
	 mov ah,09h
	 int 21h
     end_macro:  
endm

strNcmp() macro MS, MS2, cadena1, cadena2, erro, bien,maximo, contador
    
     LOCAL otro,error, end_macro              
   
     
     lea dx, maximo
	 mov ah,09h
	 int 21h
	
	 mov ah,01h
	 int 21h
	
	 sub al,30h
	 mov contador, al  
     
     
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
	 
	 mov si,offset cadena2 + 1
	 lodsb  
	 mov cl,al	 
 	
	 mov di,offset cadena1 
	 mov si,offset cadena2 + 2  
	
	 otro:
        cmpsb
	    jnz error
	    dec cl		
	    dec contador
	    jnz otro
	
	
        mov dx,offset bien
    	mov ah,09h
    	int 21h
    	
    	jmp end_macro	
	
	 error:
	
    	 mov dx,offset erro
    	 mov ah,09h
    	 int 21h
     end_macro:  
endm











.model small
.stack 100h
.data
    ;***********PARAMETROS PARA MENU
     opcion1 db "[1] Obtener el largo de una cadena.$"
     opcion2 db "[2] Comparar dos cadenas de texto.$"
     opcion3 db "[3] Comparar N caracteres de dos cadenas de texto.$"
     opcion4 db "[4] [por ]$"
     opcion5 db "[5] Salir.$"
    
     input db "Ingrese una opcion:|$"





    ;*********** PARAMETROS PARA LEER
     ContieneHandle          DW    0        ; ContieneHandle de control del fichero
     EntradaDelFichero       DB    13,10,"INTRODUCE EL NOMBRE DEL FICHERO: $"
     MensajeDeMostramosError DB    13,10," MostramosError.Mira si has escrito bien el fichero ***",13,10,10,"$"
     GuardarEntradaTeclado   DB    80 DUP (0)   ; BufferLeerDisco para leer desde el teclado
     BufferLeerDisco         DB    2000 DUP (0) ;   "     "     "     "  el disco
     BufferLeerDisco2        db    2 dup(0)
    ;*********** PARAMETROS PARA LEER
    
    ;***********PARAMETROS PARA strlen()
    decimas db "$"
    unidades db "$"

    msg db "Ingrese una cadena de texto:$"
    cadena1 db 50,0,50 dup(?) 
    ;***********PARAMETROS PARA strcmp()
    MS        DB    'Digite la clave ','$' 
    MS2       DB    'Verifique la clave ','$' 
	;cadena1   db    15,0,15 dup (?)
	;cadena2   db    15,0,15 dup (?)
	
	;pass      db    'hola'   
	erro      db    'error','$'
	bien      DB    'correcto','$'
    
    ;**********PARAMETROS PARA strNcmp()
    maximo db       "Ingrese cuantas letras desea comparar:$"
    contador db     "$" 
    
    ;MS        DB    'Digite la clave ','$' 
    ;MS2       DB    'Verifique la clave ','$' 
	;cadena1   db    15,0,15 dup (?)
	cadena2   db    15,0,15 dup (?)
	
	;pass      db    'hola'   
	;erro      db    'error','$'
	;bien      DB    'correcto','$' 
	bytes_leidos db "$"
	   
.code                              
    mov ax,@data
    mov ds,ax
    
;********* MENU
;menu:
;    mov ah,00h      ;limpiar
;    mov al,03h
;    int 10h
;
;    mov dh,005h    ;row
;    mov dl,013h    ;col
;    call goto()
;    
;    lea dx,opcion1
;    call println()
;    
;    mov dh,008h    ;row
;    mov dl,013h    ;col
;    call goto()   
;    
;    lea dx,opcion2
;    call println()
;    
;    mov dh,00bh    ;row
;    mov dl,013h    ;col
;    call goto()   
;    
;    lea dx,opcion3
;    call println()
;    
;    mov dh,00eh    ;row
;    mov dl,013h    ;col
;    call goto()   
;    
;    lea dx,opcion4
;    call println()
;    
;    mov dh,011h    ;row
;    mov dl,013h    ;col
;    call goto()   
;    
;    lea dx,opcion5
;    call println()
;    
;    mov dh,013h    ;row
;    mov dl,013h    ;col
;    call goto()   
;    
;    lea dx,input
;    call println()
;      
;    call readkey()
;    cmp al,31h
;    je len
;    cmp al,32h
;    ;je comparar
;    cmp al,33h
;    ;je compararN
;    cmp al,34h
;    ;je follow
;    jmp menu 
;;*************
;    len:
;    call leer_txt
;    call clear
;    strlen() bytes_leidos, decimas, unidades
;    call readkey()    
;    jmp menu

;    comparar:
;    call leer_txt
;    call clear
;    strcmp() MS, MS2, BufferLeerDisco, cadena2, erro, bien
;    call readkey()    
;    jmp menu 

;    compararN:
;    call leer_txt
;    call clear
;    strNcmp() MS, MS2, cadena1, cadena2, bien, erro, maximo, contador
;    call readkey()    
;    jmp menu    
       
    
;*******    
;leer_txt proc    
    push ds			
	pop es
   
    LEA   DX,EntradaDelFichero                      ;Lo que hacemos con estas instrucciones
    MOV   AH,9                                      ;es pasar a la pantalla, el contenido
    INT   21h                                       ;de la memoria, apuntado por EntradaDelFichero
    
    LEA   DX,GuardarEntradaTeclado                  ; Puntero a la dirección para la entrada
    MOV   BYTE PTR [GuardarEntradaTeclado],60       ; Fijamos los 60 caracteres
    MOV   AH,10                                     ; función de entrada de teclado
    INT   21h                                       ; LLamar a la interrupción del DOS
    
    
    MOV   BL,[GuardarEntradaTeclado+1]              ; Esta es la longitud efectiva tecleada
    MOV   BH,0              
    ADD   BX,OFFSET GuardarEntradaTeclado           ; apuntamos  al final
    MOV   BYTE PTR [BX+2],0                         ; ponemos el cero al final
    
    LEA   DX,GuardarEntradaTeclado+2                ; offset 
    MOV   AL,0                                      ; Lo abrimos para  lectura
    MOV   AH,3Dh                                    ; Esta función nos abrirá el fichero
    INT   21h                                       ; Y ahora llamamos al DOS
    ;JC    MostramosError                           ; Mirando los flags si CF=1 Mostrariamos un error
    MOV   ContieneHandle,AX                         ; En el buffer reservado guardamos
    
LeemosElFichero:
    MOV   BX,ContieneHandle                         ; Movemos a BX el handle contenido en Contiene Hanndle        
    MOV   CX,2000                                   ; 2000 será el número de bytes a leer
                   
    ;apunta a buffer leer disco
    LEA   DX,BufferLeerDisco                        ; dirección del BufferLeerDisco
    MOV   AH,3Fh                                    ; Esta función es para leer del fichero
    ;queda en buffer lo leido
                                      
    INT   21h                                       ; Y aquí llamamos  al DOS
 ;   JC    MostramosError                           ; Si el flag  CF=1 --> MostramosError
    MOV   CX,AX                                     ; bytes leídos realmente 
    
    mov bytes_leidos,cl             
    
;    JCXZ  CerramosElFichero                        ; Si es 0 leidos entonces no hay nada que i
    PUSH  AX                                        ; preservarmos ax en La Pila
    LEA   BX,BufferLeerDisco                        ; imprimir BufferLeerDisco ...

    
;ret
;endp
    strlen() bytes_leidos, decimas, unidades
    strcmp() MS, MS2, BufferLeerDisco, cadena2, erro, bien
    strNcmp() MS, MS2, cadena1, cadena2, bien, erro, maximo, contador
    
    



    
;CerramosElFichero: 
;    MOV   BX,ContieneHandle                        ;Handle de acceso al fichero hilario.txt
;    
;    MOV   AH,3Eh                                   ; CerramosElFichero 
;    INT   21h                                      ; Llamaremos  al DOS
;    JC    MostramosError
;                                                   ; sI EL FLAG CF = 1, QUE ESTARÍA EN CY --> MostramosError
;;    MOV AH,4CH
;;    INT   21h                                     ; Y llegamos al fin del programa
;
;MostramosError:
;    LEA   DX,MensajeDeMostramosError               ;  MostramosError
;    MOV   AH,9                                     ; función de escribir en consola
;    INT   21h                                      ; Llamaremos al DOS
;    CMP   ContieneHandle,0                         ;Coparamos si el handle está 0 "!fichero abierto"!
;    JNE   CerramosElFichero
;                                                   ; Y fin del programa
    
    
    ;strlen() decimas,unidades,BufferLeerDisco2,msg     
    
    
    
    mov ah,4ch
    int 21h
;********** METODOS
 println() proc
    mov ah,09h
    int 21h
    ret
endp



readkey() proc 
    mov ah,01h
    int 21h
    ret
endp


goto() proc
    mov ah,02h
    int 10h  
    ret
endp

clear() proc
    mov ah,00h
    mov al,03h
    int 10h
    ret
endp

END ;ComenzandoElCodigo    
    
    


