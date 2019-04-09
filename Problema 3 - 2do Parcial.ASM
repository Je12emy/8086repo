;********************************************************************************
; PROBLEMA 3 DEL SEGNDO PARCIAL, JOSE DANIEL CARTIN VARGAS
;********************************************************************************



.MODEL	SMALL
.STACK	100H
.DATA
        MEN1    DB      'INCREMENTAR TEMPERATURA (A)','$'
        MEN2    DB      'DECREMENTAR TEMPERATURA (Z)','$'
        MEN3   	DB      'FINALIZAR PROGRAMA..... (S)','$' 
        MEN4   	DB      ' |--------|--------|--------|--------|--------|--------|','$'
        MEN5   	DB      '-20      -10       0        10       20       30       40','$'
        MEN6    DB      'INCREMENTAR CON MOUSE...(M)','$'  
        MEN7    DB      'MODO MOUSE ACTIVADO, CLIC IZQUIERDO AUMENTA, DERECHO DISMINUYE', '$'
        
        
        X       DB      '?'
        Y       DB      '?' 
        
        A       DB      '?'  ;variables para aumentar coordenadas de la barra
        B       DB      '?'
        
        

.CODE

INICIO  PROC 

        MOV     AX,@DATA
        MOV     DS,AX
        MOV     AH,0
        MOV     AL,3
        INT     10H

                     
        MOV     X,10               ;muestra mensaje 1
        MOV     Y,1
        CALL    CURSOR
        LEA     DX,MEN1
        CALL    MENSAJE
	
        MOV     X,10               ;muestra mensaje 2
        MOV     Y,3
        CALL    CURSOR
        LEA     DX,MEN2
        CALL    MENSAJE 
        
        MOV     X,10               ;muestra mensaje 3
        MOV     Y,5
        CALL    CURSOR
        LEA     DX,MEN3
        CALL    MENSAJE 
        
        MOV     X,10               ;muestra mensaje 4
        MOV     Y,17
        CALL    CURSOR
        LEA     DX,MEN4
        CALL    MENSAJE 
        
        MOV     X,10               ;muestra mensaje 5
        MOV     Y,18
        CALL    CURSOR
        LEA     DX,MEN5
        CALL    MENSAJE        
        
        MOV     X,10               ;muestra mensaje 6
        MOV     Y,7
        CALL    CURSOR
        LEA     DX,MEN6
        CALL    MENSAJE 
        
        
        MOV     A,0Ch              ;posicion inicial de la barra de temperatura
        MOV     B,19h  

COMIENZO:    
              
        CALL    TERMOMETRO      ;Llama procedimiento termometro y lo muestra   
        
        MOV     X,10              
        MOV     Y,50
        
	    CALL 	LEER            ;Lee el dato a ingresar
        CALL    COMPARA         ;Compara el dato ingresado

       	JMP COMIENZO
ENDP


;*******************DESPLEGAR MENSAJES*******************************

MENSAJE PROC                       ;mostar menajes en pantalla
  	    MOV	    AH,9
        INT     21H  
        RET
ENDP
                                                                       
                                                                       
;*******************HABILITAR MOUSE*******************************                                                                      
 
MMEN PROC
        
        MOV     X,10               ;muestra mensaje 7, mensaje del mouse
        MOV     Y,9
        CALL    CURSOR
        LEA     DX,MEN7
        CALL    MENSAJE 
        CALL MOUSE 
        RET
        
ENDP

MOUSE PROC       
    
           
MOV ax, 0 
INT 33h  

MOV ax, 1 ;MOSTAR MOUSE        
INT 33h     

check_mouse_buttons:
MOV ax, 03h               


INT 33h

CMP bx, 2              ;DERECHO 
JE  DECREMENTARM 
    
CMP bx, 1              ;IZQUIERDO
JE  AUMENTARM 

JMP check_mouse_buttons 

RET


ENDP MOUSE                                                                    
                                                                       
;*******************LEER TECLADO************************************

LEER PROC
  	 MOV     AH,07
     INT     21H   ; lee la tecla pero no la muestra en pantalla
	 RET        
ENDP

;*********************COLOCA CURSOR PARA MENSAJE*************************************

CURSOR  PROC
        MOV     AH,2
        MOV     DL,X
        MOV     DH,Y
        INT     10H                     ;Coloca cursor para dezplegar mensaje
        RET
ENDP 

;*********************CASE*******************************

COMPARA PROC
        CMP     AL,41H                  ;A=41H
        JE      AUMENTAR              	;Salta si es igual
        CMP     AL,61H                  ;a=61H
        JE      AUMENTAR              	;Salta si es igual
        CMP     AL,5AH                  ;Z=5AH
        JE      DECREMENTAR             ;Salta si es igual        
        CMP     AL,7AH                  ;z=7AH
        JE      DECREMENTAR             ;Salta si es igual        
        CMP     AL,53H                  ;S=53H
        JE      SALIR                   ;Salta si es igual
        CMP     AL,73H                  ;s=73H
        JE      SALIR                   ;Salta si es igual
        CMP     AL,4DH                  ;M=4DH
        JE      MMEN                    ;Salta si es igual
        CMP     AL,6DH                  ;m=6DH
        JE      MMEN                    ;Salta si es igual 
        RET                              
ENDP
	
;*********************SALIR*********************************

SALIR   PROC          
        MOV     AH,0
        MOV     AL,3                    ;Salir del programa
        INT     10H
        MOV     AH,4CH
        INT     21H
        RET
ENDP 

;*************************AUMENTAR BARRA*************************************

AUMENTAR    PROC
                                          ;aumenta barra teclado
            INC     B  
            CALL    TERMOMETRO
            RET
        
            ENDP
                    
AUMENTARM    PROC
                                          ;aumenta barra mouse
            INC     B  
            CALL    TERMOMETRO
            CALL    MOUSE
            RET
        
ENDP   
                    
;*************************DECREMENTAR BARRA*************************************

DECREMENTAR    PROC
        
            DEC     B                     ;decrementa barra teclado
            CALL    LIMPIARBARRA  
            CALL    TERMOMETRO
            RET
        
ENDP

DECREMENTARM    PROC
        
            DEC     B                     ;decrementa barra mouse
            CALL    LIMPIARBARRA  
            CALL    TERMOMETRO
            CALL    MOUSE
            RET
        
ENDP


;**********************INSTRUCCIONES RESPECTO A LA TECLA*************************
       
 
TERMOMETRO PROC
                                             ;despliega barra termometro
        MOV ax,0600h
        MOV bh,047h
        MOV ch,0Eh
        MOV cl,A  
        MOV dh,0Fh
        MOV dl,B
        INT 10h   
        RET       
        
    ENDP
         
         
LIMPIARBARRA  PROC
                                             ;limpiar barra antes de mostrar nuevamente.
        MOV ax,0600h
        MOV bh,0000h
        MOV ch,0Eh
        MOV cl,A  
        MOV dh,0Fh
        MOV dl,57H
        INT 10h   
        RET 

ENDP    


END
END	INICIO
