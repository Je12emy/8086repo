
strlen() macro decimas,unidades,cadena1, msg
    mov ah,09h
    lea dx, msg
    int 21h
    
    mov ah,0ah                                  ;Leer un string de caracteres, queda en dx -> cadena1
    lea dx,cadena1
    int 21h
    
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


;Programa para obtener el largo de un string de texto.
;funciona hasta nueve caracteres
.model small
.stack 100h
.data
    decimas db "$"
    unidades db "$"

;   prueba db "prueba$"
;   enter db 0AH,0DH,'$' 
    msg db "Ingrese una cadena de texto:$"
    cadena1 db 50,0,50 dup(?)                   ;primer byte: tama�o maximo, segundo byte
.code                                           ;tama�o de lo ingresado, tercer byte
                                                ;contenido del mensaje                                                                
inicio:    
    mov ax,@data
    mov ds,ax
    
    strlen() decimas, unidades, cadena1, msg
    
;    
;    mov ah,09h
;    lea dx, msg
;    int 21h
;    
;    mov ah,0ah                                  ;Leer un string de caracteres, queda en dx -> cadena1
;    lea dx,cadena1
;    int 21h
;    
;    cld                                         ;Ajustar el direction flag para leer de forma ascendente
;    
;    mov si,offset cadena1 + 1                   ;Mover largo (2do byte) del mensaje ingresado a si
;    
;    lodsb                                       ;extraer el byte del mensaje hacia AL
;    
;    
;    
;    ;Manipulacion de 2 caracteres
;    
;
;    AAM
;	
;	MOV decimas,AH
;	MOV unidades,AL
;	
;	ADD decimas,30H
;	ADD unidades,30H
;	
;	                        ;getchr()
;	mov dl,decimas			
; 	mov ah,02h
;	int 21h				    
;                      
;                            ;getchr()
;    mov dl,unidades			
; 	mov ah,02h
;	int 21h       
    
halt:
    mov ah,4ch
    int 21h
 


   