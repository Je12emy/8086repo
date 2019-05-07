;********************************************************************************
; Programa "6" para mostrar uso de lazos y combinaciones de saltos y llamados
;********************************************************************************



.MODEL	SMALL
.STACK	100H
.DATA
        MEN1    DB      'Digite un numero del 4 al 6 ','$'
        MEN2    DB      'Presione 3 para salir: ','$'
        MEN3   	DB      'digito un cuatro','$'
        MEN4  	DB      'digito un cinco','$'
        MEN5   	DB      'digito un seis','$'
        MEN6   	DB      'Presione cualquier tecla ','$'
        X       DB      '?'
        Y       DB      '?'

.CODE

INICIO  PROC
        MOV     AX,@DATA
        MOV     DS,AX




        MOV     AH,0
        MOV     AL,3
        INT     10H

        MOV     X,10
        MOV     Y,1
        CALL    CURSOR
        LEA     DX,MEN1
        CALL    MENSAJE
	
        MOV     X,10
        MOV     Y,2
        CALL    CURSOR
        LEA     DX,MEN2
        CALL    MENSAJE
	    CALL 	LEER
        CALL    COMPARA
        CALL    SALIR
       	RET
ENDP


;*******************DESPLIEGA EL MENSAJE*******************************

MENSAJE PROC
  	    MOV	    AH,9
        INT     21H  
        RET
ENDP

;*******************LEE DEL TECLADO************************************

LEER PROC
  	 MOV     AH,1
     INT     21H   ; EL DATO QUEDA EN AL
	 RET        
ENDP

;*********************COLOCA CURSOR*************************************

CURSOR  PROC
        MOV     AH,2
        MOV     DL,X
        MOV     DH,Y
        INT     10H                     ;Coloca cursor para dezplegar mensaje
        RET
ENDP

;*********************DISCRIMINA LA TECLA*******************************

COMPARA PROC
        CMP     AL,34H                  ;4=34H
        JE      cuatro               	;Salta si es igual
        CMP     AL,35H                  ;5=35H
        JE      cinco               	;Salta si es igual
        CMP     AL,36H                  ;6=36H
        JE      seis               	;Salta si es igual
	    CMP     AL,33H                  ;3=33H
        JE      SALIR                   ;Salta si es igual
        JMP     INICIO              ;salto incondicional
        RET
ENDP
	
;*********************SALIR DEL PROGRAMA*********************************

SALIR   PROC           ;SALIR: CALL SALIR1
        MOV     AH,0
        MOV     AL,3
        INT     10H
        MOV     AH,4CH
        INT     21H
        RET
ENDP 


OTRO	PROC
	    MOV     X,15
        MOV     Y,12
        CALL    CURSOR
        LEA     DX,MEN6
        CALL    MENSAJE
	    RET
ENDP	



;**********************MENSAJE RESPECTO A LA TECLA*************************

cuatro: MOV     AH,2
	MOV	DL,15
	MOV	DH,10
	INT	10H			;Coloca el cursor para el primer mensaje
    MOV  DX,OFFSET MEN3	        ;Despliega primer mensaje
	MOV	AH,9H
	INT	21H
	CALL 	OTRO	
	MOV	AH,1
	INT	21H
	JMP	Inicio


cinco:  MOV     AH,2
	MOV	DL,15
	MOV	DH,10
	INT	10H			;Coloca el cursor para el primer mensaje
        MOV     DX,OFFSET MEN4	        ;Despliega primer mensaje
	MOV	AH,9H
	INT	21H
	CALL 	OTRO	
	MOV	AH,1
	INT	21H
	JMP	Inicio


seis:   MOV     AH,2
	MOV	DL,15
	MOV	DH,10
	INT	10H			;Coloca el cursor para el primer mensaje
        MOV     DX,OFFSET MEN5	        ;Despliega primer mensaje
	MOV	AH,9H
	INT	21H
	CALL 	OTRO	
	MOV	AH,1
	INT	21H
	JMP	Inicio

END	INICIO
