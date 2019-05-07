.MODEL SMALL
.STACK 100H
 
.DATA
       X DB ?
       Y DB ?
       MENSUB DB 0B2H,'$'
       MENBAJ DB 20H,'$'
       N20    DB '-20','$'
       N10    DB '-10','$'
       P0     DB '0','$'
       P10    DB '10','$'
       P20    DB '20','$'
       P30    DB '30','$'
       P40    DB '40','$'
       MENDER DB 'INCREMENTAR ALTURA...(U)','$' 
       MENIZQ DB 0AH,0DH,'DECREMENTAR ALTURA...(D)','$'
       MENFIN DB 0AH,0DH,0AH,0DH,'FINALIZAR............(',51H,')','$'
       MENERR DB 'SE ALCANZO ALTURA MAXIMA','$'
.CODE

    mov ax,@data
    mov ds,ax 
    
    MOV     AH,0
    MOV     AL,3
    INT     10H 
    
    LEA DX,MENDER
    CALL MENSAJE
    
    LEA DX,MENIZQ
    CALL MENSAJE
    
    LEA DX, MENFIN
    CALL MENSAJE
    
    MOV X,5
    MOV Y,20
    CALL CURSOR
    
    CALL EJE
    MOV X,5
    MOV Y,19
    CALL CURSOR
    
INICIO:
    
    CALL TECLA
    
    CMP AL,55H     ;INCREMENTAR
    JE  DERECHA
    CMP AL,75H
    JE  DERECHA
    
    CMP AL, 44H    ;DECREMENTAR
    JE IZQUIERDA
    CMP AL,64H
    JE IZQUIERDA
    
    CMP AL,51H     ;SALIR
    JE SALIR
    CMP AL,71H
    JE SALIR  
    
    CALL CURSOR  
    JMP INICIO    ;CUALQUIER OTRA TECLA
    
TECLA PROC
     
     MOV AH,07H
     INT 21H
     RET
     
ENDP

DERECHA PROC
    
    CMP X,37
    JE ERROR
    
    CALL CURSOR
    LEA DX, MENSUB
    CALL MENSAJE
    ADD X,1
    
    JMP INICIO
    RET

ENDP

IZQUIERDA PROC
    
    CMP X,5
    JE INICIO
    
    CALL CURSOR
    LEA DX, MENBAJ
    CALL MENSAJE
    DEC X
    
    JMP INICIO
    RET
    
ENDP

ERROR PROC
    MOV X,5
    MOV Y,22
    
    CALL CURSOR
    LEA DX,MENERR
    CALL MENSAJE
    
    MOV X,36
    MOV Y,19
    CALL CURSOR
    JMP INICIO
    
    RET
ENDP
    
EJE PROC
    LEA DX,N20
    CALL MENSAJE
    
    ADD X,5
    CALL CURSOR
    LEA DX,N10
    CALL MENSAJE
    
    ADD X,5
    CALL CURSOR
    LEA DX,P0
    CALL MENSAJE
    
    ADD X,5
    CALL CURSOR
    LEA DX,P10
    CALL MENSAJE
    
    ADD X,5
    CALL CURSOR
    LEA DX,P20
    CALL MENSAJE
    
    ADD X,5
    CALL CURSOR
    LEA DX,P30
    CALL MENSAJE
    
    ADD X,5
    CALL CURSOR
    LEA DX,P40
    CALL MENSAJE
    RET
ENDP
    
SALIR PROC
    
    MOV 	AH,4CH 
    INT 	21H
                
    RET
    
ENDP
    
MENSAJE PROC
    
   	MOV	    AH,9
    INT     21H                     
    RET
  
ENDP
    
CURSOR  PROC
    			
        MOV     AH,2
        MOV     DL,X
        MOV     DH,Y
        INT     10H     
        RET	
    
ENDP
  
END 
  
 

