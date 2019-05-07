;JOSE MANUEL ROJAS FALLAS
;EXAMEN 3 PROBLEMA B
;SECUENCIA FIBONACCI    
    .MODEL SMALL

.DATA    
        MENSAJE   DB 'Digite N: ','$'
        ESPACIO   DB ' ','$'
        NUM1      DB  ?
        NUM2      DB  ?
        NUM3      DB  ?
        VAR1      DB  ?
        VAR2      DB  ?
       OTRALINEA  DB  '  ', 0DH,0AH,'$'
        FIBN      DB  ?

.CODE                   
    MAIN PROC
    MOV	AX,@DATA
	MOV	DS,AX
	
	MOV ah,09
    LEA dx, MENSAJE 
    INT 21h      
    MOV     AH,01H
    INT     21H         
    SUB     AL,30H
    MOV   FIBN,AL

    
    MOV DX, OFFSET OTRALINEA
	MOV AH, 09H
	INT 21H
    MOV NUM1,0
    MOV NUM2,1
    MOV DL,NUM1
    MOV CL, FIBN            
INICIAR_FIB:        
    
    MOV AL,NUM1
    ADD AL,NUM2
    MOV AH,0
    MOV BL,AL
    MOV DL,10
    DIV DL
    ADD AX,3030H

    MOV VAR1,AL
    MOV VAR2,AH

    MOV DL,VAR1
    MOV AH,02H
    INT 21H
                        
    MOV DL,VAR2
    MOV AH,02H
    INT 21H

    MOV DX, OFFSET ESPACIO
	MOV AH, 09H
	INT 21H

    MOV AL,NUM2
    MOV NUM1,AL
    MOV NUM2,BL
    DEC   CL 

    JNZ	    INICIAR_FIB 
    MOV AX,4C00H
    INT 21H

     END 
