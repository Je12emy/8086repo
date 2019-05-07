;**************************************************************
; Programa "for2a" carga en AL las veces que es mostrado en 
; pantalla un dato. Luego repite el despliegue AL veces.
; corrige para poder leer un número de 2 dígitos.
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
        INT     21H         ; CARGA EN "AL" LAS VECES A MOSTRAR
        SUB     AL,30H
        MOV     BH,AL

        MOV     AH,01H
        INT     21H         ; CARGA EN "AL" LAS VECES A MOSTRAR
        SUB     AL,30H
        MOV     BL,AL       
        MOV     AX,BX
     
        AAD		            ; ajusta a valor binario NATURAL, usa especificamente AX
        
        MOV     CX,AX
OTRO:	LEA     DX,MEN1
   	    MOV	    AH,9
        INT     21H  
        DEC     CX
	    JNZ	    OTRO
	

	    MOV 	AH,4CH      ; VUELTA AL DOS
        INT 	21H        

END			    ; FIN	

