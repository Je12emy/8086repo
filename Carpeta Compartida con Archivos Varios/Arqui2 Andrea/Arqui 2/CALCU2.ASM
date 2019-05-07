;CALCULADORA 
.model small
.stack 100h
.data

TXT1 DB '**UNIVERSIDAD HISPANOAMERICANA**','$'
TXT2 DB 'CALCULADORA','$'
TXT3 DB 'MENU','$'
TXT4 DB '1) SUMA', '$'
TXT5 DB '2) RESTA', '$'
TXT6 DB '3) MULTIPLICACION','$'
TXT7 DB '4) DIVISION','$'
TXT8 DB '5) ELEVAR AL CUADRADO','$'
TXT9 DB '6) SALIDA DEL PROGRAMA','$'
TXT10 DB 'DIGITE SU OPCION:','$'
TXT11 DB 'DIGITE EL PRIMER NUMERO:','$'
TXT12 DB 'DIGITE EL SEGUNDO NUMERO:','$'
TXT13 DB 'EL RESULTADO ES:','$'

.CODE

        MOV AX,@DATA
	MOV DS,AX

INICIO:
	MOV BX,0
	
	MOV AH,0                   ;ESCOGE MODO DE RESOLUCION DE PANTALLA Y
	MOV AL,3                   ;LIMPIA PANTALLA.
	INT 10H

	MOV AH,2		   ;POSICIONA EL CURSOR EN LA PANTALLA.  	
	MOV DL,19
	MOV DH,2
	INT 10H
	
	MOV DX,OFFSET TXT1          ;DESPLIEGA INTEGRATES DEL PROYECTO. 
	MOV AH,9
	INT 21H

	MOV AH,2                    ;POSICIONA EL CURSOR EN LA PANTALLA.
	MOV DL,33
	MOV DH,4
	INT 10H

	MOV DX,OFFSET TXT2           ;DESPLIEGA NOMBRE DEL PROYECTO.
	MOV AH,9
	INT 21H
	
	MOV AH,2                    ;POSICIONA EL CURSOR EN LA PANTALLA.
	MOV DL,36
	MOV DH,6
	INT 10H

	MOV DX,OFFSET TXT3           ;DESPLIEGA MENU.
	MOV AH,9
	INT 21H

	MOV AH,2                    ;POSICIONA EL CURSOR EN LA PANTALLA.
	MOV DL,15
	MOV DH,9
	INT 10H		
	
	MOV DX,OFFSET TXT4           ;DESPLIEGA LA OPCION DE SUMA.
	MOV AH,9
	INT 21H
		
	MOV AH,2                    ;POSICIONA EL CURSOR EN LA PANTALLA.
	MOV DL,15
	MOV DH,11
	INT 10H		
	
	
	MOV DX,OFFSET TXT5           ;DESPLIEGA LA OPCION DE RESTA.
	MOV AH,9
	INT 21H
	
	MOV AH,2                    ;POSICIONA EL CURSOR EN LA PANTALLA.
	MOV DL,15
	MOV DH,13
	INT 10H		
	
	MOV DX,OFFSET TXT6           ;DESPLIEGA LA OPCION DE MULTIPLICACION.
	MOV AH,9
	INT 21H	

	MOV AH,2                    ;POSICIONA EL CURSOR EN LA PANTALLA.
	MOV DL,52
	MOV DH,9
	INT 10H	

	MOV DX,OFFSET TXT7           ;DESPLIEGA LA OPCION DE DIVISION.
	MOV AH,9
	INT 21H	
 
	MOV AH,2                    ;POSICIONA EL CURSOR EN LA PANTALLA.
	MOV DL,52
	MOV DH,11
	INT 10H	

	MOV DX,OFFSET TXT8           ;DESPLIEGA LA OPCION CUADRATICA.
	MOV AH,9
	INT 21H	
 	

	MOV AH,2                    ;POSICIONA EL CURSOR EN LA PANTALLA.
	MOV DL,52
	MOV DH,13
	INT 10H	

	MOV DX,OFFSET TXT9           ;DESPLIEGA LA OPCION DE SALIDA DEL PROGRAMA.
	MOV AH,9
	INT 21H

	MOV AH,2                    ;POSICIONA EL CURSOR EN LA PANTALLA.
	MOV DL,33
	MOV DH,18
	INT 10H	

	MOV DX,OFFSET TXT10           ;DESPLIEGA LA OPCION.
	MOV AH,9
	INT 21H	

        
        MOV AH,1                      ;ESPERA LA TECLA
        INT 21H

        CMP AL,31H                    ;ELIGE LA OPCIÓN
        JZ SUMA
        CMP AL,32H
        JZ RESTA   
	CMP AL,33H                    ;ELIGE LA OPCIÓN
        JZ MULTI
        CMP AL,34H
        JZ DIVI   
        CMP AL,35H                    ;ELIGE LA OPCIÓN
        JZ CUADRA
        CMP AL,36H
        JZ SALIR
        JMP SALIR

        
 SUMA:  CALL PROCESO
        ADD AL,BL
        AAM
        JMP RESUL

RESTA:  CALL PROCESO
        SUB BL,AL
        MOV AL,BL
        AAM
        JMP RESUL

MULTI:  CALL PROCESO
        MUL BL
        AAM
        JMP RESUL

 DIVI:  CALL PROCESO
        MOV BH,0
        MOV AH,0
        MOV CL,BL
        MOV BL,AL
        MOV AL,CL
        DIV BL
        AAD
        JMP RESUL 

CUADRA: MOV AH,0                     ;LIMPIAR PANTALLA
        MOV AL,3
        INT 10H

        MOV AH,2                     ;POSICIONAR CURSOR
        MOV DL,36 
        MOV DH,6
        INT 10H
             
        MOV DX,OFFSET TXT11          ;DESPLIEGA SOLICITUD DE PRIMER #.
	MOV AH,9
	INT 21H	

        MOV AH,1                     ;ESPERA LA TECLA
        INT 21H 
        SUB AL,30H                   ;GUARDA DIGITO EN BL
        MOV BL,AL
        MUL BL                       ;LO MULTIPLICA POR EL MISMO 
        AAM
        JMP RESUL

SALIR:  JMP FIN
 
PROCESO:       
        MOV AH,0                     ;LIMPIAR PANTALLA
        MOV AL,3
        INT 10H

        MOV AH,2                     ;POSICIONAR CURSOR
        MOV DL,36 
        MOV DH,6
        INT 10H
             
        MOV DX,OFFSET TXT11           ;DESPLIEGA SOLICITUD DE PRIMER #.
	MOV AH,9
	INT 21H	

        MOV AH,1                      ;ESPERA LA TECLA
        INT 21H 
        SUB AL,30H                    ;GUARDA DIGITO EN BL
        MOV BL,AL

        MOV AH,2                     ;POSICIONAR CURSOR
        MOV DL,36 
        MOV DH,7
        INT 10H
        
        MOV DX,OFFSET TXT12          ;DESPLIEGA SOLICITUD DE SEGUNDO #.
	MOV AH,9
	INT 21H	

        MOV AH,1                      ;ESPERA LA TECLA
        INT 21H 
        SUB AL,30H                    ;GUARDA DIGITO EN AL
        
        RET
        
RESUL:  MOV CX,AX                     ;AJUSTE DE ASCII
        ADD CX,3030H

        MOV AL,0 
        MOV AH,2                    ;POSICIONAR CURSOR
        MOV DL,20
        MOV DH,15
        INT 10H
   
        MOV DX,OFFSET TXT13         ;DESPLIEGA EL MENSAJE DE RESULTADO.
	MOV AH,9
	INT 21H	
        
        MOV AH,2                    ;DESPLIEGA EL RESULTADO
        MOV DL,CH
        INT 21H
        MOV DL,CL
        INT 21H

        MOV AH,1
        INT 21H
      
        JMP INICIO

   FIN: 
	MOV AH, 4CH
	INT 21H

        END
		