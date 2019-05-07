;Programa: 

; Inicio del programa, definimos el modelo de memoria a usar y el segmento 

; de c�digo 

.MODEL SMALL 			; Modelo de memoria 

.CODE 				; Area de c�digo 

Inicio: 			; Etiqueta de inicio del programa 

	MOV AX,@DATA 		; Inicializa el registro DS con la direcci�n dada 

	MOV DS,AX 		; por @DATA (Segmento de datos). 

	MOV DX, OFFSET Titulo 	; Obtiene la direcci�n de la cadena de caracteres 

	MOV AH,09 		; Usamos la funci�n 09H de la interrupci�n 21H 

	INT 21H 		; para desplegar la cadena cuya direcci�n obtuvimos. 

	MOV CX,16 		; Contador de caracteres que se mostrar�n 

	MOV BX, OFFSET Cadena 	; Permite acceso a la cadena donde se encuentran los 

			; valores a desplegar 

	Ciclo: 			; Etiqueta para generar un ciclo 

	MOV AL,CL 		; Coloca en AL el n�mero a traducir y lo traduce 

	XLAT 			; usando la instrucci�n XLAT 

	MOV DL,AL 		; Coloca en DL el valor a ser desplegado por medio de la 

	MOV AH,02 		; funci�n 2 de la interrupci�n 21H 

	INT 21H 		; Despliega el caracter 

	MOV DL,10 		; Salta una linea desplegando el caracter 10 

	INT 21H 		; Despliega el caracter 

	MOV DL,13 		; Produce un retorno de carro desplegando el caracter 13 

	INT 21H 		; Despliega el retorno de carro 

	LOOP Ciclo 		; Decrementa en uno a CX y brinca a la etiqueta Ciclo 

				; siempre y cuando CX no sea igual a cero 

	MOV AH,4C 		; Utiliza la funci�n 4C de la interrupci�n 21H para 

	INT 21H 		; finalizar el programa 

			; Inicio del segmento de datos 

	.DATA 			;Define el segmento de datos 

	Titulo DB 13,10,'Desplegar los n�meros hexadecimales del 15 al 1' 
	
	DB 13,10,'$' 		; Cadena a desplegar al inicio del programa 

	Cadena DB '0123456789ABCDEF' ; Cadena con los digitos hexadecimales 

			; Declaraci�n del segmento de la pila 

	.STACK 100h

	END Inicio 		;Declaraci�n del final del programa 

	