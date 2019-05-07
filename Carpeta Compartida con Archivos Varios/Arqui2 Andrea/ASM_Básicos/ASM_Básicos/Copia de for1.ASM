
;**************************************************************
; Programa "for1" carga en AL las veces que es mostrado en 
; pantalla un dato. Luego repite el despliegue AL veces.
;**************************************************************




.MODEL SMALL       
.STACK 100H

.DATA
 
	MEN1    DB      'Digite el caracter a desplegar','$'
    MEN2    DB      'Digite las filas','$'	                                                    
	MEN3    DB      'Digite las columnas','$'                                                    
	
	ENTER   DB 0AH,0DH,'$';CREA UNA NUEVA LINEA 
	
	
	
	letra db '?'
   
     Columnas DB 0 
     Filas DB 0
     
     
     
.CODE

 
  
	MOV     AX,@DATA
    MOV     DS,AX

	
	lea dx,men1
	call mensaje
	
	
	MOV     AH,01H
	INT     21H		; carga el caracter a ser mostrado
	mov    letra,al
    call clrscr	
	lea dx, men2
	call mensaje   
	
	MOV     AH,01H
	INT     21H		; CARGA EN "AL" LAS VECES A MOSTRAR
	
	SUB 	AL,30H ; convertir valor de ascii a binario natural
     
  
	MOV     FILAS, AL
	;MOV	    CH,00
   
    call clrscr
    lea dx, men3
    call mensaje
        
        ;Ingreso de columnas
    MOV     AH,01H
	INT     21H		; CARGA EN "AL" LAS VECES A MOSTRAR
	
	SUB 	AL,30H ; convertir valor de ascii a binario natural
     
  
	MOV     Columnas, AL
	call clrscr
	
       
    mov     dl,letra  
    
OTRO2:    
    MOV     CL, Columnas ;
    
OTRO:
   	CALL    MENSAJE1
	DEC 	CL 
	;DEC COLUMNAS
	JNZ	    OTRO
    
    PUSH    DX
	LEA     DX,ENTER
	CALL    MENSAJE
	POP     DX      
    Dec     FILAS
    JNZ     OTRO2  
	    
	    
    
    mov ah,01
    int 21h 
     
	MOV     AH,4CH      ; VUELTA AL
    INT     21H         ; DOS


;***********************DESPLIEGA EN PANTALLA*******************************

MENSAJE PROC
      	MOV	AH,9
        INT     21H                     
        RET
ENDP
       
       
       
MENSAJE1 PROC
      	MOV	    AH,2 ; solo imprime el caracter en DL
        INT     21H                     
        RET
ENDP
       

clrscr  proc
    MOV     AH,0
    MOV     AL,3
    INT     10H	
    ret
    endp

END

