
; Programa de "Hola Mundo"
.model small
.stack 100h
.data
String1 DB      'BIENVENIDO AL ENSAMBLADOR','$'
String2 DB      'H','o','l','a',' ','M','u','n','d','o','$'
String3 DB      0Dh,07h,48h, 6Fh, 6Ch, 61h, 20h, 4Dh, 75h, 6Eh, 64h, 6Fh, 24h
String4 DB      0Dh, 0Ah, 'Hola Mundo', 0Dh, 0Ah, '$'

 uno dw 3 dup(0ah)          
 dos db 0ffh
 
.code

Inicio:
        MOV     AX, @data
        MOV     DS, AX          ; Ajustamos el segmento de datos
        ; Imprimir el String1
        MOV     AH, 9           ; Servicio 9 en AL = Imprimir String
        MOV     DX, OFFSET String1 ; Direccion del string
        INT     21h             ; Llamada a la interrupci¢n 21h (DOS)
        ; Imprimir el string 2
        LEA     DX, String2     ; otra forma de dar la direccion
        INT     21h
        ; Imprimir el string 3
        LEA     DX, String3     
        INT     21h
        ; Imprimir el string 4
        LEA     DX, String4     
        INT     21h
        ; Terminar el programa
        MOV     AH, 4Ch
        INT     21h
       ;jmp inicio
        
        END     Inicio

