;**************************************************************
; Programa "1suma" suma 4 numeros de una lista. El resultado
; se carga en una variable, que luego es desplegada. Ver despliegue
;**************************************************************


TITLE 1suma

.MODEL small
.STACK 100h

.DATA

datos	DB	1
	    DB	38
	    DB	40	
        DB  10

resul	DB	0

X       DB      '?'
Y       DB      '?'

texto1  DB 'El resultado de la suma es: ','$'

.CODE
	

inicio:	
    MOV 	AX,@DATA
	MOV 	DS,AX
	
	;Cuerpo del programa

    ; Usamos AL para acumular la suma
	
	MOV AL,[DATOS]		; Cargamos AL con el 1er valor
	MOV BL,[DATOS+1]	; Cargamos BL con el 2o valor
	ADD AL,BL		    ; se hace la suma
	MOV BL,[DATOS+2]	; se vuelve a cargar
	ADD AL,BL
	MOV BL,[DATOS+3]
	ADD AL,BL
	
	MOV [RESUL],AL		;se almacena el resultado en memoria

;SE DESPLIEGA CONTENIDO DE LA VARIABLE CON EL RESULTADO

	MOV     AH,0
        MOV     AL,3
        INT     10H
       
	MOV     X,5
        MOV     Y,5
	MOV     AH,2
        MOV     DL,X
        MOV     DH,Y
        INT     10H             ; coloca cursor para desplegar mensaje
	
	LEA     DX,texto1	; carga la dirección del mensaje en DX	
        MOV	AH,9		; despliegar en pantalla
        INT     21H 			  

	MOV     X,45
        MOV     Y,5
        MOV     AH,2
        MOV     DL,X
        MOV     DH,Y
        INT     10H             ; coloca cursor para desplegar mensaje

        MOV 	DL,[RESUL]	; pasar de memoria al registro DL
	MOV 	AH,2
	INT 	21H
	
	MOV	AH,1		;Espera tecla por medio del DOS
	INT	21H

	MOV 	AH,4CH      	; VUELTA AL DOS
        INT 	21H         	

END inicio			; Fin del programa
