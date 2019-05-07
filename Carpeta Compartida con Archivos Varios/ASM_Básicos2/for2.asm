
;**************************************************************
; Programa "for2" carga en BX las veces que es mostrado en 
; pantalla un dato. Luego repite el despliegue. Ver despliegue
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
        INT     21H
                           ; CARGA EN "AL" LAS VECES A MOSTRAR
        SUB     AL,30H
        MOV     BH,AL       ; DECENAS

        MOV     AH,01H
        INT     21H         ; CARGA EN "AL" LAS VECES A MOSTRAR
        SUB     AL,30H
        MOV     BL,AL       ; UNIDADES
              
        
        MOV     CX,BX 
        
OTRO:	LEA     DX,MEN1
   	    CALL    MENSAJE
        DEC     CX
	    JNZ	    OTRO
	

	MOV AH,4CH      ; VUELTA AL
        INT 21H         ; DOS


;***********************DESPLIEGA EN PANTALLA*******************************

MENSAJE PROC
      	MOV	AH,9
        INT     21H                     
        RET
ENDP


END

