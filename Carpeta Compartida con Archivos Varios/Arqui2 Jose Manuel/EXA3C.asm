gotoxy Macro Fil,Col
	mov ah,02h
	mov bh,00
	mov dh,Fil		;fila
	mov dl,Col		;columna
	int 10h
endm             
imprimir macro mensaje
	mov ah,9
	mov dx,offset mensaje
	int 21h
endm
.MODEL	SMALL	
.STACK	100H		
.DATA

    MENSAJE1 DB    'Digite alto','$' 
    MENSAJE2 DB    'Digite ancho','$'
    MENSAJE3 DB    'Digite un caracter','$'   
    X DB 10
    Y DB 10
    ALTO  DB ?
    ANCHO DB ?
    CHAR  DB ?
.CODE				
	
	MOV	AX,@DATA
	MOV	DS,AX
    
    mov ah,09
     lea dx, MENSAJE1 
     int 21h 
     CALL LEER 
     lea dx, MENSAJE2 
     int 21h  
     CALL LEER
     mov ah,09
     lea dx, MENSAJE3 
     int 21h  
    
     CALL LEER
;	MOV DX, OFFSET MENSAJE1
	;MOV AH, 01H
	;INT 21H
	;SUB AL,30H
	;MOV ALTO,AL
    
 ;  	MOV DX, OFFSET MENSAJE2
	;MOV AH, 01H
;	INT 21H 
;	SUB AL,30H
;	MOV ANCHO,AL
    
 ;   MOV DX, OFFSET MENSAJE3
	;MOV AH, 01H
	;INT 21H 
	;SUB AL,30H
	;MOV CHAR,AL
	
;	CALL LEER
	
    GOTOXY X,Y
    MOV CL, ALTO
OTRO:        
    GOTOXY X,Y
    IMPRIMIR [CHAR]
	INC   X 
    DEC 	CL
    JNZ	    OTRO
    MOV CL,ANCHO
    DEC X
OTRO1:
	GOTOXY X,Y
    IMPRIMIR [CHAR]
	INC   Y 
    DEC 	CL
    JNZ	    OTRO1  
	MOV CL,ALTO 
    DEC Y
	
salir:
	MOV	AH,4CH
	INT	21H

LEER PROC
  	 MOV     AH,1
     INT     21H 
	 RET        
ENDP

END