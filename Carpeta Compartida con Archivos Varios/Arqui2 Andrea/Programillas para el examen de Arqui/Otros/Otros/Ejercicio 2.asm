.model small
.stack 100h

.data
     NUM DB ?
     AUX DB ?
     x db ?
     y db ?
     men db '*','$'
     MENCON    DB 0AH,0DH,'PRESIONE CUALQUIER TECLA PARA CONTINUAR','$'
     MENSAL    DB 0AH,0DH,'PRESIONE "Q" PARA SALIR:','$'
     MENINI    DB 0AH,0DH,'GRAFICA NUMEROS ENTRE 01 - 13','$'
     cont db ? 
.code 

  
        MOV     AX,@DATA
        MOV     DS,AX

        MOV     AH,0
        MOV     AL,3
        INT     10H 
        
        MOV     X,5
        MOV     Y,1
        LEA DX,MENINI
        CALL MENSAJE
        
        MOV     cont,6
        MOV     X,2 
        
INICIO:
        CALL Leer_Num  
        CALL GRAFICO
        CMP  cont,0
        JE MENSALIDA
        JMP INICIO
        
           	

Leer_Num PROC
          
         ADD X,3
         MOV Y,16
         CALL CURSOR
         
          mov ah,01h   
          int 21h      
          sub al,30h   
  
          mov bl,10    
          mul bl       
          mov AUX,al   

          mov ah,01h   
          int 21h      
          sub al,30h   
   
          add AUX,al   
          mov bl,AUX   
          mov NUM,bl
          RET 
        
ENDP

GRAFICO PROC
     
         MOV CL,NUM
         For1: DEC Y
            CALL CURSOR
            LEA     DX,men
            CALL MENSAJE 
            DEC CL
            JNZ For1

         DEC cont      
         RET
ENDP

MENSALIDA PROC
    MOV X,5
    MOV Y,17
    CALL CURSOR
    LEA DX,MENCON
    CALL MENSAJE
    LEA DX, MENSAL
    CALL MENSAJE
    
    mov ah,01h   
    int 21h
    
    CMP AL,51H
    JE SALIR  
    
    CMP AL,71H
    JE SALIR
    
    MOV     AH,0
    MOV     AL,3
    INT     10H
    
    MOV     X,5
    MOV     Y,1
    LEA DX,MENINI
    CALL MENSAJE 
        
    MOV     cont,6
    MOV     X,2
    JMP INICIO
    
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
