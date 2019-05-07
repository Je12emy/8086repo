;***************************************************
;EJERCICIO D
;ALBERTH RAMIREZ RAMIREZ
;ARQUI2
;***************************************************

.MODEL small

.STACK 100h

.DATA 

    DATO DB ?
    CRUZ DB '+$'      
    MSJ  DB 'DIGITE UN NUMERO $'
    X DB ?
    Y DB ? 
    I DB 1
           


.CODE


INICIO:
        MOV AX,@DATA
	    MOV DS,AX  
	    
	    CALL PEDIR_NUM 
        MOV X,20
        MOV Y,2

CICLO:	           
        MOV DH,Y
        MOV DL,X      
        CALL GOTOXY
        MOV AH,09
        LEA DX,CRUZ 
        INT 21H
        MOV BH,I
        MOV BL,DATO
        CMP BH,1 
        JE SIGUE
        CMP BH,3
        JE SIGUE2  
        JMP DEVUELVE
        SIGUE:
        INC Y
        DEC X 
        INC I
        JMP CICLO
        SIGUE2: 
        INC Y
        DEC X     
        INC I
        MOV AH,09
        LEA DX,CRUZ 
        INT 21H
        INC I    
        JMP CICLO  
        INC X
        DEVUELVE: 
        CMP BH,BL   
        INC I
        INC X
          
        JNE CICLO
	    
	    
	    
	    MOV	AH,4Ch		
        INT	21h
     
;*****************************************************
PROC PEDIR_NUM
           
        MOV AH,09
        LEA DX,MSJ 
        INT 21H 
        MOV AH,01
        INT 21H
        MOV DATO,AL     
	    RET
ENDP
;*****************************************************
PROC GOTOXY
      MOV  AH, 2                  
      MOV  BH, 0                
      INT  10H                  
      RET
ENDP; GotoXY.
        
END inicio	
