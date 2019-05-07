
 include LIBRER2.lib
.MODEL SMALL
.STACK 100H
 
.DATA

       MENSAJE1 DB 'INCREMENTAR ALTURA..(A)','$' 
       MENSAJE2 DB 0AH,0DH,'DECREMENTAR ALTURA..(Z)','$'
       MENSAJE3 DB 0AH,0DH,0AH,0DH,'FINALIZAR.......(S)','$'
       ERROR DB 'MAXIMA ALTURA','$'
       X DB ?
       Y DB ? 
       siminc DB 0B2H,'$'
       simdec DB 20H,'$'
       
       
       
.CODE


    mov ax,@data
    mov ds,ax 
    
    MOV     AH,0
    MOV     AL,3
    INT     10H 
    
    LEA DX,MENSAJE1
    MOV	    AH,9
    INT     21H 
    
    LEA DX,MENSAJE2
    MOV	    AH,9
    INT     21H 
    
    LEA DX,MENSAJE3
    MOV	    AH,9
    INT     21H 
    
   
    
    
    
INICIO:
    
    
    MOV AH,07H
    INT 21H
    CMP AL,41H     
    JE  INCREMENTAR
    CMP AL, 5AH    
    JE DECREMENTAR
    CMP AL,53H     
    MOV AH,4CH 
    INT 21H
    gotoxy X,Y  
    JMP INICIO    
    


INCREMENTAR PROC
    
    CMP X,37
    JE MAX
    MOV     AH,2
    MOV     DL,X
    MOV     DH,Y
    INT     10H   
    LEA DX, siminc
    MOV	    AH,9
    INT     21H
    ADD X,1
    
    JMP INICIO
    RET

ENDP

DECREMENTAR PROC
    
    CMP X,5
    JE INICIO
    MOV     AH,2
    MOV     DL,X
    MOV     DH,Y
    INT     10H 
    LEA DX, simdec
    MOV	    AH,9
    INT     21H
    DEC X
    JMP INICIO
    RET
    
ENDP

MAX PROC
    gotoxy 5,22
    LEA DX,ERROR
    MOV	    AH,9
    INT     21H 
    
    gotoxy 36,19
    JMP INICIO
    
    RET
ENDP
    

    
END 
  
 
