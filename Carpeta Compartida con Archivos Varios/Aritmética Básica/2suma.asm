;**************************************************************
; Programa "2suma" suma 4 numeros de una lista. El resultado
; se muestra en decimal a través de la instrucc AAM.
;**************************************************************

	
.MODEL small

.STACK 100h

.DATA

datos   DB      1
        DB      38
        DB      40 
        DB      10
 
 
X       DB      '?'
Y       DB      '?'

texto1  DB 'El resultado de la suma es: ','$'
 
 
 
.CODE


inicio:	

    MOV AX,@DATA
	MOV DS,AX
	
	;Cuerpo del programa

	;Se usa AL para acumular la suma

    XOR 	AX,AX		; Limpia AX
	MOV 	AL,[DATOS]	; Cargamos AL con el pimer valor
	MOV 	BL,[DATOS+1]	; Cargamos BL con el siguiente numero
	ADD 	AL,BL		; Se suman ambos numeros y luego se sumarán los siguientes
	MOV 	BL,[DATOS+2]
	ADD 	AL,BL
	MOV 	BL,[DATOS+3]
	ADD 	AL,BL
      
	AAM			        ; Hace un ajuste decimal: AH = decenas, AL = unidades
    
    MOV 	BX,AX		; Carga el numero en BX
         
	MOV     X,5
    MOV     Y,5
	MOV     AH,2
    MOV     DL,X
    MOV     DH,Y
    INT     10H             ; coloca cursor para desplegar mensaje
	
	LEA     DX,texto1	; carga la dirección del mensaje en DX	
    MOV	    AH,9		; despliegar en pantalla
    INT     21H 			  

	MOV     X,45
        MOV     Y,5
        MOV     AH,2
        MOV     DL,X
        MOV     DH,Y
        INT     10H 
    
     
	MOV 	AH,2		; Opción para utilizar el display en la interrupción 21h
        MOV 	DL,BH		; las decenas se cargan en DL
        ADD 	DL,30h		; se le suma un 30h al numero para mostrar el caracter
        INT 	21h		; llamada a utilizar display, se muestra caracter en DL
      
	MOV 	DL,BL		; las unidades se cargan en DL
        ADD 	DL,30h		; se repite el proceso anterior
        INT 	21h

        MOV	AH,1		; Espera tecla por medio del DOS
	INT	21H
        
	MOV 	AH,4Ch		; Regreso al S.O.
        INT 	21h

END inicio			; fin del programa
