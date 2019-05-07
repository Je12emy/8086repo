;**************************************************************
; Programa "3" Despliegue pantalla,limpieza previa,espera tecla
; declara variables y coloca el cursor en diferentes partes 
; de la pantalla
;**************************************************************

.model small				;modelo del programa

.stack 100h

.data					;Espacio de datos y mensajes

msg1 DB      'BIENVENIDO AL ENSAMBLADOR','$'
msg2 DB      'H','o','l','a',' ','M','u','n','d','o','$'
msg3 DB      48h, 6Fh, 6Ch, 61h, 20h, 4Dh, 75h, 6Eh, 64h, 6Fh, 24h

x	db	'?'			 ;declaración de variables
y	db	'?'

.code
        MOV     AX, @data
        MOV     DS, AX          	; Se ubica el segmento de datos
 	
	    MOV     AH,0			; Ajusta modo video y limpia pantalla 
        MOV     AL,3			; Modo de video
        INT     10H                     ; Llama a la INT de video
	
	; Imprimir el 1er mensaje
       
        MOV     X,20
        MOV     Y,5
	
	    MOV     AH,2
        MOV     DL,X
        MOV     DH,Y
        INT     10H                     ; Coloca cursor para desplegar el mensaje       
 
	MOV     AH, 9           	; Servicio 09 en AL = Imprimir string
        MOV     DX, OFFSET msg1 	; Direccion del mensaje
        INT     21h             	; Llamada a la interrupcion 21h DOS
        
	; Imprimir el 2 mensaje
        
        MOV     X,10
        MOV     Y,6
        
	MOV     AH,2
        MOV     DL,X
        MOV     DH,Y
        INT     10H
	
	MOV     AH, 9 
	LEA     DX, msg2     		; otra forma de dar la direccion
        INT     21h
        
	; Imprimir el string 3
        
	MOV     X,10
        MOV     Y,7
       
	MOV     AH,2
        MOV     DL,X
        MOV     DH,Y
        INT     10H
	LEA     DX, msg3     
	MOV     AH, 9 
        INT     21h
        
	MOV	AH,1			; Espera tecla por medio del DOS
	INT	21H
				

	MOV     AH, 4Ch			; Terminar el programa retornando al DOS
        INT     21h


END     				; Fin del programa

