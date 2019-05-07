; PRACTICA 1.1
; Programa que suma 4 numeros de una listay los muestra en pantalla. 
; Para comprobar el resultado, ver la parte baja del registro AX ( AL )
	
	.MODEL small
	.STACK 60h

	.DATA
datos   DB      1
        DB      38
        DB      40 
        DB      10

	.CODE

	;Icializacion del registro de segmento de codigo

inicio:	MOV AX,@DATA
		MOV DS,AX
	
	;Cuerpo del programa
	;Usamos AL para acumular la suma
	
        XOR AX,AX		;Limpia AX
	MOV AL,[DATOS]		;Cargamos AL con el pimer valor
	MOV BL,[DATOS+1]	;Cargamos BL con el siguiente numero
	ADD AL,BL		;Se suman ambos numeros y luego se sumarán los siguientes
	MOV BL,[DATOS+2]
	ADD AL,BL
	MOV BL,[DATOS+3]
	ADD AL,BL
      
	AAM			;Hace un ajuste decimal: AH = decenas, AL = unidades
        MOV BX,AX		;Carga el numero en BX
      
	MOV AH,2		;Opción para utilizar el display en la interrupción 21h
        MOV DL,BH		;las decenas se cargan en DL
        ADD DL,30h		;se le suma un 30h al numero para mostrar el caracter
        INT 21h			;llamada a utilizar display, se muestra caracter en DL
      
	MOV DL,BL		;las unidades se cargan en DL
        ADD DL,30h		; se repite el proceso anterior
        INT 21h

        ;Regreso al S.O.

        MOV AH,4Ch
        INT 21h

	END inicio
