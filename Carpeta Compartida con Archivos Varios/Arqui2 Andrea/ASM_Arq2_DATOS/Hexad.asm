;Programa: 

; Inicio del programa, definimos el modelo de memoria a usar y el segmento 

; de código 

.MODEL SMALL 			; Modelo de memoria 

.CODE 				; Area de código 

Inicio: 			; Etiqueta de inicio del programa 

	MOV AX,@DATA 		; Inicializa el registro DS con la dirección dada 

	MOV DS,AX 		; por @DATA (Segmento de datos). 

	MOV DX, OFFSET Titulo 	; Obtiene la dirección de la cadena de caracteres 

	MOV AH,09 		; Usamos la función 09H de la interrupción 21H 

	INT 21H 		; para desplegar la cadena cuya dirección obtuvimos. 

	MOV CX,16 		; Contador de caracteres que se mostrarán 

	MOV BX, OFFSET Cadena 	; Permite acceso a la cadena donde se encuentran los 

			; valores a desplegar 

	Ciclo: 			; Etiqueta para generar un ciclo 

	MOV AL,CL 		; Coloca en AL el número a traducir y lo traduce 

	XLAT 			; usando la instrucción XLAT 

	MOV DL,AL 		; Coloca en DL el valor a ser desplegado por medio de la 

	MOV AH,02 		; función 2 de la interrupción 21H 

	INT 21H 		; Despliega el caracter 

	MOV DL,10 		; Salta una linea desplegando el caracter 10 

	INT 21H 		; Despliega el caracter 

	MOV DL,13 		; Produce un retorno de carro desplegando el caracter 13 

	INT 21H 		; Despliega el retorno de carro 

	LOOP Ciclo 		; Decrementa en uno a CX y brinca a la etiqueta Ciclo 

				; siempre y cuando CX no sea igual a cero 

	MOV AH,4C 		; Utiliza la función 4C de la interrupción 21H para 

	INT 21H 		; finalizar el programa 

			; Inicio del segmento de datos 

	.DATA 			;Define el segmento de datos 

	Titulo DB 13,10,'Desplegar los números hexadecimales del 15 al 1' 
	
	DB 13,10,'$' 		; Cadena a desplegar al inicio del programa 

	Cadena DB '0123456789ABCDEF' ; Cadena con los digitos hexadecimales 

			; Declaración del segmento de la pila 

	.STACK 100h

	END Inicio 		;Declaración del final del programa 

	