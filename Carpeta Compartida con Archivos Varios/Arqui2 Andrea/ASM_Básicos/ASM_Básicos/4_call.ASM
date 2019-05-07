;**************************************************************
; Programa "4_call" Despliegue pantalla,limpieza previa,espera tecla
; y coloca el cursor en diferentes partes de la pantalla
; muestra el uso de las llamadas a rutinas
;**************************************************************

.model small				;modelo del programa

.stack 100h

.data					;Espacio de datos y mensajes

msg1 DB      'BIENVENIDO AL ENSAMBLADOR','$'
msg2 DB      'H','o','l','a',' ','M','u','n','d','o','$'
msg3 DB      48h, 6Fh, 6Ch, 61h, 20h, 4Dh, 75h, 6Eh, 64h, 6Fh, 24h

x	db	'?'
y	db	'?'

.code

Inicio:
        MOV     AX, @data
        MOV     DS, AX          	; Se ubica el segmento de datos
 	
	MOV     AH,0			; Ajusta modo video y limpia pantalla 
        MOV     AL,3			; Modo de video
        INT     10H                     ; Llama a la INT de video
	
	; Imprimir el string1
       
        MOV     X,10
        MOV     Y,5
        CALL    CURSOR			; Llamada a una rutina o procedimiento
	
	MOV     AH, 9           	; Servicio 9 en AL = Imprimir string
        MOV     DX, OFFSET msg1 	; Direccion del string
        INT     21h             	; Llamada a la interrupcion 21h DOS
        
	; Imprimir el string 2
        
        MOV     X,10
        MOV     Y,6
        CALL    CURSOR			; Llamada a la rutina
	MOV     AH, 9 
	LEA     DX, msg2     		; otra forma de dar la direccion
        INT     21h
        
	; Imprimir el string 3
        
	MOV     X,10
        MOV     Y,7
        CALL    CURSOR			; Llamada a la rutina
	LEA     DX, msg3     
	MOV     AH, 9 
        INT     21h
        
	MOV	AH,1			; Espera tecla por medio del DOS
	INT	21H

	MOV     AH, 4Ch			; Terminar el programa retornando al DOS
        INT     21h


;****************************RUTINA CURSOR***************************************
;******La rutina o procedimiento es código que se llama en forma repetida********
	
CURSOR  PROC			; Nombre de la rutina + PROC
        MOV     AH,2
        MOV     DL,X
        MOV     DH,Y
        INT     10H     ; Coloca cursor para desplegar el mensaje
        RET				; RET = instrucción necesaria para terminar una rutina o procedimiento
ENDP					; Fin de la rutina con ENDP

;********************* FIN DE RUTINA CURSOR**************************************	



END     Inicio	; Fin del programa

