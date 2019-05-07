.MODEL	SMALL		
.STACK	100H			
.DATA

MENSAJE   DB 'Digite N','$'
FIBN      DB 0              
C1        DB 0
C2        DB 0
N1        DB 0  
N2        DB 0
cadena1   db     50,0,50 dup (0aah)

.CODE				
	MOV	AX,@DATA
	MOV	DS,AX
	
	MOV DX, OFFSET MENSAJE
	MOV AH, 09H
	INT 21H
	
	MOV AH,1                      ;ESPERA LA TECLA
    INT 21H 
    SUB AL,2                    ;GUARDA DIGITO EN BL
    MOV BL,AL
    
    MOV AL,BL
    ADD AL,1 
    
    MOV CX,AX                     ;AJUSTE DE ASCII
        ADD CX,3030H

        MOV AL,0 
        MOV AH,2                    ;POSICIONAR CURSOR
        MOV DL,20
        MOV DH,15
        INT 10H
   
       ; MOV DX,OFFSET TXT13         ;DESPLIEGA EL MENSAJE DE RESULTADO.
	    ;MOV AH,9
	    ;INT 21H	
        
        MOV AH,2                    ;DESPLIEGA EL RESULTADO
        MOV DL,CH
        INT 21H
        MOV DL,CL
        INT 21H

        MOV AH,1
        INT 21H
END    
    
    
    
RESTA:  CALL PROCESO
        SUB BL,AL
        MOV AL,BL
        AAM
        JMP RESUL
        
PROCESO:       
        MOV AH,0                     ;LIMPIAR PANTALLA
        MOV AL,3
        INT 10H

        MOV AH,2                     ;POSICIONAR CURSOR
        MOV DL,36 
        MOV DH,6
        INT 10H
             
        MOV DX,OFFSET MENSAJE           ;DESPLIEGA SOLICITUD DE PRIMER #.
	    MOV AH,9
	    INT 21H  
      
        
       ; MOV AH,1                      ;ESPERA LA TECLA
       ; INT 21H 
       ; SUB AL,30H                    ;GUARDA DIGITO EN BL
        ;MOV BL,AL
        
        
        
       ; MOV AH,2                     ;POSICIONAR CURSOR
       ; MOV DL,36 
       ; MOV DH,7
       ; INT 10H
        
        ;MOV DX,OFFSET TXT12          ;DESPLIEGA SOLICITUD DE SEGUNDO #.
	    ;MOV AH,9
	    ;INT 21H	

       ; MOV AH,1                      ;ESPERA LA TECLA
        ;INT 21H 
        ;SUB AL,30H                    ;GUARDA DIGITO EN AL
        
        RET
        
RESUL:  MOV CX,AX                     ;AJUSTE DE ASCII
        ADD CX,3030H

        MOV AL,0 
        MOV AH,2                    ;POSICIONAR CURSOR
        MOV DL,20
        MOV DH,15
        INT 10H
   
       ; MOV DX,OFFSET TXT13         ;DESPLIEGA EL MENSAJE DE RESULTADO.
	    ;MOV AH,9
	    ;INT 21H	
        
        MOV AH,2                    ;DESPLIEGA EL RESULTADO
        MOV DL,CH
        INT 21H
        MOV DL,CL
        INT 21H

        MOV AH,1
        INT 21H
      
        ;JMP INICIO

END
