;include macros_examen.txt
strlen() macro decimas,unidades,cadena1, msg
    ;mov ah,09h
    ;lea dx, msg
    ;int 21h
    
    ;mov ah,0ah                                  ;Leer un string de caracteres, queda en dx -> cadena1
    ;lea dx,cadena1
    ;int 21h
    
    cld                                         ;Ajustar el direction flag para leer de forma ascendente
    
    mov si,offset cadena1 + 1                   ;Mover largo (2do byte) del mensaje ingresado a si
    
    lodsb                                       ;extraer el byte del mensaje hacia AL
    
    
    
    ;Manipulacion de 2 caracteres
    

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
endm

strcmp() macro MS, MS2, cadena1, cadena2, erro, bien
    
     LOCAL otro,error, end_macro
              

	 ;MOV DX, OFFSET MS
	 ;MOV AH, 09H
	 ;INT 21H

	
	 ;MOV DX,OFFSET CADENA1   
	 ;MOV AH,0AH
     ;INT 21H
   
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
	 
;	 mov si,offset cadena2 + 1
;	 lodsb
;	 
;	 cmp al,cl
;	 jne error
	 
 	
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




.model small
.stack 100h
.data
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
.code                              
    mov ax,@data
    mov ds,ax
    
   
     push ds			
	 pop es
   
    LEA   DX,EntradaDelFichero  ;Lo que hacemos con estas instrucciones
    MOV   AH,9                  ;es pasar a la pantalla, el contenido
    INT   21h                   ;de la memoria, apuntado por EntradaDelFichero
    
    LEA   DX,GuardarEntradaTeclado                  ; Puntero a la dirección para la entrada
    MOV   BYTE PTR [GuardarEntradaTeclado],60       ; Fijamos los 60 caracteres
    MOV   AH,10                                     ; función de entrada de teclado
    INT   21h                                       ; LLamar a la interrupción del DOS
    
    
    MOV   BL,[GuardarEntradaTeclado+1]    ; Esta es la longitud efectiva tecleada
    MOV   BH,0              
    ADD   BX,OFFSET GuardarEntradaTeclado ; apuntamos  al final
    MOV   BYTE PTR [BX+2],0 ; ponemos el cero al final
    
    LEA   DX,GuardarEntradaTeclado+2    ; offset 
    MOV   AL,0              ; Lo abrimos para  lectura
    MOV   AH,3Dh            ; Esta función nos abrirá el fichero
    INT   21h               ; Y ahora llamamos al DOS
    ;JC    MostramosError     ; Mirando los flags si CF=1 Mostrariamos un error
    MOV   ContieneHandle,AX   ; En el buffer reservado guardamos
    
LeemosElFichero:
    MOV   BX,ContieneHandle  ; Movemos a BX el handle contenido en Contiene Hanndle        
    MOV   CX,2000            ; 2000 será el número de bytes a leer
                   
    ;apunta a buffer leer disco
    LEA   DX,BufferLeerDisco ; dirección del BufferLeerDisco
    MOV   AH,3Fh             ; Esta función es para leer del fichero
    ;queda en buffer lo leido
                                      
    INT   21h                ; Y aquí llamamos  al DOS
 ;   JC    MostramosError     ; Si el flag  CF=1 --> MostramosError
    MOV   CX,AX              ; bytes leídos realmente
;    JCXZ  CerramosElFichero  ; Si es 0 leidos entonces no hay nada que i
    PUSH  AX                 ; preservarmos ax en La Pila
    LEA   BX,BufferLeerDisco ; imprimir BufferLeerDisco ...
;strlen() decimas,unidades,BufferLeerDisco2,msg
    strcmp() MS, MS2, BufferLeerDisco, cadena2, erro, bien



;    
;CerramosElFichero: 
;    MOV   BX,ContieneHandle  ;Handle de acceso al fichero hilario.txt
;    
;    MOV   AH,3Eh            ; CerramosElFichero 
;    INT   21h               ; Llamaremos  al DOS
;    JC    MostramosError
;                                           ; sI EL FLAG CF = 1, QUE ESTARÍA EN CY --> MostramosError
;;    MOV AH,4CH
;;    INT   21h               ; Y llegamos al fin del programa
;
;MostramosError:
;    LEA   DX,MensajeDeMostramosError     ;  MostramosError
;    MOV   AH,9              ; función de escribir en consola
;    INT   21h               ; Llamaremos al DOS
;    CMP   ContieneHandle,0  ;Coparamos si el handle está 0 "!fichero abierto"!
;    JNE   CerramosElFichero
;                           ; Y fin del programa
    
    
    ;strlen() decimas,unidades,BufferLeerDisco2,msg     
    
    
    
    mov ah,4ch
    int 21h

    END ;ComenzandoElCodigo    
    
    


