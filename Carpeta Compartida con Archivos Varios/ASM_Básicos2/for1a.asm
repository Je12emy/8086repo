
;**************************************************************
; Programa "for1a" carga en AL las veces que es mostrado en 
; pantalla un dato. Luego repite el despliegue AL veces.
; Detecta si se digito un cero
;**************************************************************




.MODEL SMALL       
.STACK 100H

.DATA
 
	MEN1    DB      '*','$'
	MEN2    DB 'DIGITE UN NUMERO MAYOR A CERO ','$'
	MEN3    DB 'PRESIONE CUALQUIER TECLA PARA CONTINUAR','$'

.CODE

  INICIO:
  
	    MOV     AX,@DATA
        MOV     DS,AX

        MOV     AH,0
        MOV     AL,3
        INT     10H	
	
		CALL    TECLA	; CARGA EN "AL" LAS VECES A MOSTRAR
	
        cmp     al,30h
        JZ      CERO     ; es igual que colocar JE 
    
	SUB 	AL,30H ; convertir valor de ascii a binario natural

	MOV 	CL,AL
	MOV	    CH,00

OTRO:LEA    DX,MEN1
   	CALL    MENSAJE
	DEC 	CL
	JNZ	    OTRO
    
    MOV AH,4CH      ; VUELTA AL
    INT 21H          ; DOS      
    
CERO:
    LEA     DX, MEN2
    CALL    MENSAJE
    
    LEA     DX,MEN3
    CALL    MENSAJE
    CALL    TECLA       
 
 
 
 JMP     INICIO  
    
           
	     

;***********************DESPLIEGA EN PANTALLA*******************************


 TECLA PROC
       MOV AH,01H
	   INT 21H
	   RET
 ENDP 
 
MENSAJE PROC
      	MOV	AH,9
        INT     21H                     
        RET
ENDP	  
 
 
 
END

