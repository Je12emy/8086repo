;*************************************
;*   Manipulacion Basica de Strings  *
;*************************************
;Funcionamiento Basico:
;1. Imprimir una palabra
;2. Esperar una tecla
;3. Limpiar la pantalla
;4. Imprimir una palabra
;5. Cerrar
;Modelo de Memoria.
;Forma en la cual se trabajan los segmentos.

.model small                ;Define el modelo por utilizar, .small funcionara para la mayoria de modelos que usaremos.

.stack 100h                 ;Define el segmento del stack y su longitud

.DATA                       ;Define el segmento de datos

    mensaje DB  "Asi se imprime un string$" 
    mensaje2 DB "Asi tambien se puede imprimir un string$"
    
.CODE
;****CODIGO BASICO DE FUNCIONAMIENTO****  
    MOV AX,@DATA
    MOV DS,AX    
                            ;Si voy a imprimir en la interrupcion 21H, funcion 09 deberia bastar
                            ;9 -> Print String. Output an ASCIIZ string of characters to the standard output device. Input: DS:DX = address of the string
    
    MOV AH, 09H             ;CARGAR LA FUNCION 09 PARA LA INTERRUPCION 21H
    MOV DX, OFFSET mensaje  ;La funcion 9 imprime el contenido en DS basado en su OFFSET.
                            ;La palabra clave OFFSET devuelve el OFFSET de un determinado mensaje.
    INT 21H                 ;EJECUTAR LA INTERRUPCION 21H, FUNCION BASADO EN EL NUMERO CARGADO EN AH
    
    MOV AH,01H              ;Pausa y espera una entrada por teclado, la guarda en AL
    INT 21H  
    
    ;Limpiar pantalla
    MOV AH,00H              ;Cargar el servicio 0 para alterar las opciones de video
    MOV AL,03H              ;Se pone el modo 80x25, este es el predeterminado. Al hacer esto se 'resetea' y se limpia la pantalla
    INT 10H
    
    MOV AH,09H              ;Se debe cargar denuevo 09h pues ahora mismo tiene el servicio 0, en ella. De no estar el metodo para limpiar la pantalla no se requiere cargarlo
    LEA DX,mensaje2         ;LEA carga el OFFSET a un destino. En este caso se pasa el offset de mensaje2 a DX para luego ser  impreso
    INT 21H                 ;Ejecuta la interrupcion 21h.
    
 
;****CODIGO BASICO PARA TERMINAR UN PROGRAMA                
    MOV AH,4CH
    INT 21H
