;JOSE MANUEL ROJAS FALLAS
;EXAMEN 3 PROBLEMA C

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

.model small
.stack 100h

.data

      num1 db 0


    ENTER  DB 0AH,0DH,'$'
    MENSAJE  DB    'ô','$'
    MENSAJEB DB " ",'$'
    MENSAJEC DB "@",'$'
    MENSAJE1 DB    ' Digite alto: ','$' 
    MENSAJE2 DB    ' Digite ancho: ','$'
    MENSAJE3 DB    ' Digite un caracter: ','$'
    MSG DB  ' SE MUEVE CON 2,4,6,8 ','$'               
    X DB 10
    Y DB 10
    X3 DB 10
    y3 DB 11 
    XX DB 5
    YY DB 5
    X2 DB 12
    Y2 DB 13 
    MX DB 10
    MY DB 25      
    
    ALTO  DB 10
    ANCHO DB 10
    CHA   DB ?    
.code     
     mov ax, @data
     mov ds, ax
     

     mov ah,09
     lea dx, MENSAJE1 
     int 21h      
     MOV     AH,01H
     INT     21H         
     SUB     AL,30H
     MOV   ALTO,AL

     
     mov ah,09
     lea dx, MENSAJE2 
     int 21h      
     MOV     AH,01H
     INT     21H         
     SUB     AL,30H
     MOV   ANCHO,AL
     
     
     mov ah,09
     lea dx, MENSAJE3 
     int 21h      
     MOV     AH,01H
     INT     21H         
     SUB     AL,30H 
     ;AAD
     MOV   CHA,AL
     
     
    ;GOTOXY X,Y
    MOV CL, ALTO
OTRO:        
    GOTOXY X,Y
    mov dl, cha
    MOV 	AH,2
	INT 	21H    
	INC   X 
    DEC   CL 

    JNZ	    OTRO  
    
    MOV CL,ANCHO
    DEC   X 
OTRO1:
	GOTOXY X2,Y2 
    
    mov dl, cha
    MOV AH,2
	INT 21H
	INC Y2 
    DEC CL
    JNZ	OTRO1  
	MOV CL,CHA 
    DEC Y2    
     ;GOTOXY XX,YY
OTRO3:        
    GOTOXY X3,Y3
    mov dl, cha
    MOV 	AH,2
	INT 	21H    
	INC   X3 
    DEC   CL 

    JNZ	    OTRO3  
    
    MOV CL,ANCHO
    DEC   X3 
OTRO4:        
    GOTOXY X3,Y3
    mov dl, cha
    MOV 	AH,2
	INT 	21H    
	INC   y3 
    DEC   CL 

    JNZ	    OTRO4  
    
    MOV CL,ANCHO
    DEC   y3     
      
OTRO2:
     GOTOXY MX,MY
     IMPRIMIR MSG                  
     GOTOXY XX,YY
     IMPRIMIR MENSAJEC
     MOV AH,07H 
     INT 21h 
     
     
     CMP AL,56               ;Tecla 8 sube
                JE UP           ;Etiqueta que incrementa Y = Y + 1
     CMP AL,50               ;Tecla 2 baja
               JE DOWN         ;Etiqueta que decrementa Y = Y - 1
     CMP AL,54               ;Tecla 6 derecha
                JE RIGHT        ;Etiqueta que incrementa X = X + 1
     CMP AL,52               ;Tecla 4 izquierda
                JE LEFT 
     JnE OTRO2        ;Otra iteración o ciclo (Leemos otra tecla para mover punto)

        UP:      
                GOTOXY XX,YY               
                IMPRIMIR MENSAJEB   
                DEC YY           
                JMP OTRO2        
        DOWN:    
                GOTOXY XX,YY               
                IMPRIMIR MENSAJEB    
                INC YY           
                JMP OTRO2        

        RIGHT:   
                GOTOXY XX,YY               
                IMPRIMIR MENSAJEB     
                INC XX           
                JMP OTRO2        

        LEFT:   
                GOTOXY XX,YY                
                IMPRIMIR MENSAJEB
                DEC XX           
                JMP OTRO2
     
     END
     