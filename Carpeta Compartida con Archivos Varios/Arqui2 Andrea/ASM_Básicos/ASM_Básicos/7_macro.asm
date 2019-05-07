;**************************************************************
; Programa "7_macro" Despliegue pantalla,limpieza previa,
; espera tecla, coloca el cursor y hace uso de macros
;**************************************************************

include librer2.lib
                          
;include librer3.lib 
                         
.model small				;modelo del programa

.stack 100h

.data					;Espacio de datos y mensajes

msg1 DB      'BIENVENIDO AL ENSAMBLADOR','$'
msg2 DB      'H','o','l','a',' ','M','u','n','d','o','$'
msg3 DB      48h, 6Fh, 6Ch, 61h, 20h, 4Dh, 75h, 6Eh, 64h, 6Fh, 24h

x	db	'?'			;declaración de variables
y	db	'?'

.code
        MOV     AX, @data
        MOV     DS, AX          	; Se ubica el segmento de datos
 	
	    MOV     AH,0			; Ajusta modo video y limpia pantalla 
        MOV     AL,3			; Modo de video
        INT     10H                     ; Llama a la INT de video
	
	; Imprimir el 1er mensaje
       

	gotoxy 5,10

  	;MOV     X,10
    ;MOV     Y,5
	;MOV     AH,2
    ;MOV     DL,X
    ;MOV     DH,Y
    ;INT     10H                     ; Coloca cursor para desplegar el mensaje       
 
	
	escribe msg1
        
	;Imprimir el 2 mensaje
        
        
	gotoxy 6,10

	;MOV     X,10
    ;MOV     Y,6
    ;MOV     AH,2
    ;MOV     DL,X
    ;MOV     DH,Y
    ;INT     10H
	
	escribe msg2
        
	;Imprimir el string 3
        
	
	gotoxy 7,10
	escribe msg3     
	lee ah
	getcha        

	;MOV	AH,1			; Espera tecla por medio del DOS
	;INT	21H
				

	MOV     AH, 4Ch			; Terminar el programa retornando al DOS
    INT     21h


END     				; Fin del programa

