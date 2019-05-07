
;**************************************************************
; Programa "for1" carga en AL las veces que es mostrado en 
; pantalla un dato. Luego repite el despliegue AL veces.
;**************************************************************




.MODEL SMALL       
.STACK 100H

.DATA
 
	MEN1    DB      '*','$'

.CODE

 
  
	MOV     AX,@DATA
    MOV     DS,AX

    MOV     AH,0
    MOV     AL,3
    INT     10H	
	
	MOV     AH,01H
	INT     21H		; CARGA EN "AL" LAS VECES A MOSTRAR
	
	SUB 	AL,30H ; convertir valor de ascii a binario natural

	MOV 	CL,AL
	MOV	    CH,00
	
    MOV     AH,0
    MOV     AL,3
    INT     10H	

OTRO:LEA    DX,MEN1
   	CALL    MENSAJE
	DEC 	CL
	JNZ	    OTRO

	MOV     AH,4CH      ; VUELTA AL
    INT     21H         ; DOS


;***********************DESPLIEGA EN PANTALLA*******************************

MENSAJE PROC
      	MOV	AH,9
        INT     21H                     
        RET
ENDP


END

