;**************************************************************
; Programa "1" Despliegue en pantalla
;**************************************************************

.model small			;Modelo del programa

.stack 100h				;Pila 256 bytes 

.data					;Espacio de datos y mensajes

string1 DB      'BIENVENIDO AL ENSAMBLADOR ','$'
string2 DB      'H','o','l','a',' ','M','u','n','d','o',' ','$'

uno db 5 ;dup (0ffH)  ; var de nombre uno, con 5 bytes y un FF en c/u

string3 DB      48h, 6Fh, 6Ch, 61h, 20h, 4Dh, 75h, 6Eh, 64h,6Fh,24h



.code					; Espacio para los códigos del programa


Inicio:
        MOV     AX, @data
        MOV     DS, AX          	; Se ubica el segmento de datos
       
	; Imprimir el string1
       
	    MOV     AH,09           	; Servicio 9 en AH = Imprimir string
        MOV     DX, OFFSET string1 	; Direccion del string
        INT     21h             	; Llamada a la interrupcion 21h DOS
        
	; Imprimir el string 2
        
	    LEA     DX, string2     	; otra forma de dar la direccion
        INT     21h
        
	; Imprimir el string 3
        LEA     DX, string3     
        INT     21h
        
	MOV     AH, 4Ch			; Terminar el programa retornando al DOS
    INT     21h
END     Inicio

