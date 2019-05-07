;************************************************************************
; Programa "2" Despliegue en pantalla con limpieza previa y espera tecla
;************************************************************************

.model small				;modelo del programa

.stack 100H

.data					;Espacio de datos y mensajes

string1 DB      'BIENVENIDO AL ENSAMBLADOR','$'
string2 DB      'H','o','l','a',' ','M','u','n','d','o','$'
string3 DB      48h, 6Fh, 6Ch, 61h, 20h, 4Dh, 75h, 6Eh, 64h, 6Fh, 24h

.code

Inicio:
        MOV     AX, @data
        MOV     DS, AX          	; Se ubica el segmento de datos
       
	; Ajusta modo video y limpia pantalla al mismo tiempo

	    MOV     AH,00			;Selecciona modo de video
        MOV     AL,03			; Modo de video 03H 80colx25filas
        INT     10H                     ; Llama a la INT de video
	
	; Imprimir el string1
       
	
	
	
	    MOV     AH, 9           	; Servicio 9 en AL = Imprimir string
        MOV     DX, OFFSET string1 	; Direccion del string
        INT     21h             	; Llamada a la interrupcion 21h DOS
   
    
        MOV	    AH,1			;Espera tecla por medio del DOS	INT	21H
  	    INT	    21H      
    
          
        MOV     AH,0			;Selecciona modo de video
        MOV     AL,3			; Modo de video 03H 80colx25filas
        INT     10H    
	; Imprimir el string 2
        MOV     AH, 9      
	    LEA     DX, string2     ; otra forma de dar la direccion
        INT     21h

        MOV	    AH,1			;Espera tecla por medio del DOS
	    INT	    21H               
 
        MOV     AH,0			;Selecciona modo de video
        MOV     AL,3			; Modo de video 03H 80colx25filas
        INT     10H               
	; Imprimir el string 3
        MOV     AH, 9   
        LEA     DX, string3     
        INT     21h
 
        MOV	    AH,7			;Espera tecla por medio del DOS sin eco en pantalla
	    INT	    21H    
	
	 
        MOV     AH, 4Ch			; Terminar el programa retornando al DOS
        INT     21h
END     Inicio

