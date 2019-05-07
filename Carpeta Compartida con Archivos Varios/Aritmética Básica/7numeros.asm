
;**************************************************************
;Programa "numeros1" detecta si se ingreso un numero o una 
;letra
;**************************************************************




.MODEL SMALL       
.STACK 100H

.DATA
 
	MEN1    DB '*','$'
	MEN2    DB 'DIGITE UN NUMERO ','$'
	MEN3    DB 0AH,0DH,'PRESIONE CUALQUIER TECLA PARA CONTINUAR','$' 
	MEN4    DB 0AH,0DH,'DIGITO UN NUMERO','$' 

.CODE

  INICIO:
  
	 MOV     AX,@DATA
     MOV     DS,AX

     MOV     AH,0
     MOV     AL,3
     INT     10H	
	 LEA     DX,MEN2
     CALL    MENSAJE
     CALL    TECLA	; CARGA EN "AL" LAS VECES A MOSTRAR
	 CALL    MAYOR0 ;salto incondicional a la validacion
	 ;devolver de la validacion a la sigte instruccion con una etiqueta      
	 
	 
	 ;JMP     INICIO
	    
  
    MOV     AH,4CH      ; VUELTA AL
    INT     21H          ; DOS      
    
CERO:
 
    
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

MAYOR0 PROC
      	CMP AL,30H
      	JAE MAS_DE_0
otro2:  RET  ;saltar a una etiqueta aca
ENDP 
  

MAS_DE_0:

     CMP AL,39H  
     JBE MENOS_DE_9
     JMP INICIO      ;saltar a la etiqueta del RET


MENOS_DE_9:

        LEA     DX, MEN4
        CALL    MENSAJE
        LEA     DX, MEN3
        CALL    MENSAJE
        CALL    TECLA
        JMP INICIO       
END

