READKEY MACRO           ;Equivalente de ReadKey en otros lenguajes
                MOV AH,07H      ;STDIN, direct input, no echo (Func 07/int 21h)
                INT 21h         ;Interrupt 21h DOS Funcions
        ENDM

GRAPH MACRO                     ;Inicia modo gráfico
                MOV AH,00H      ;Set video mode (Func 00/int 10h)
                MOV AL,12h      ;12h = 80x30 8x16 640x480 16/256k A000 VGA, ATI, VIP
                INT 10H         ;Interrupt 10h Video functions
        ENDM
       
FONDO MACRO COLOR       ;Define la paleta de colores
                MOV AH,0BH      ;Set colro palette (Func 0B/Int 10h)
                MOV BH,0H       ;
                MOV BL,COLOR;color 0-15
                INT 10H         ;Interrupt 10h Video functions
        ENDM
       
DOS MACRO                       ;Inicia/Regresa a modo MSDOS
                MOV AH,00H      ;Set video mode (Func 00/int 10h)
                MOV AL,03H      ;03h = 80x25 8x8 16 4 B800 CGA
                INT 10H         ;Interrupt 10h Video functions
        ENDM

CARRO MACRO X,Y,COLOR,mensaje ;Dibuja un punto en la pantalla (En modo gráfico)
                ;MOV AH,0CH              ;Write dos on screen (Func 0C/Int 10h)
                mov ah,0ch
                ;mov ah,9
	            ;mov dx,offset mensaje
	            ;int 21h 
                MOV AL,COLOR    ;color 0-15
                MOV BH,0                ;pagina (0 por default en esta aplicación)
                MOV CX,X                ;Columna
                MOV DX,Y                ;Fila
                INT 10H         ;Interrupt 10h Video functions
               ;mov ah,9
	            ;mov dx,offset mensaje
	            ;int 21h
ENDM  
limpiar macro
    MOV     AH,0      ; Ajusta modo video y limpia pantalla
    MOV     AL,3      ; Modo de video
    INT     10H  
endm  

cargar macro
	MOV	    AH,7   ;Espera tecla por medio del DOS sin eco en pantalla
	INT	    21H 
	;no muestra el caracter digitado
endm

cargarDAto macro
	MOV     AH,01H
	INT     21H	; CARGA EN "AL" LAS VECES A MOSTRAR
endm


imprimir macro mensaje
	mov ah,9
	mov dx,offset mensaje
	int 21h
endm


gotoxy Macro Fil,Col
	mov ah,02h
	mov bh,00
	mov dh,Fil		;fila
	mov dl,Col		;columna
	int 10h
endm

esperaTecla macro
	;MOV	AH,1  ; Espera tecla por medio del DOS
	;INT	21H
endm

FONDOCOLOR MACRO color           ;Permite definir la paleta
                MOV AH,0BH   ;servicio Set Color Palette
                MOV BH,00H   ;el registro BL tiene el color
                MOV BL,color ;background color
                INT 10H
        ENDM


;include ProyectoTXT.txt
.model small
.stack 100h  

.data

    titulo DB  "PLACAS VEHICULOS$"
    numero dw ?, '$'
	LINEA    DB      '°°°°°','$'
	         DB      '°   °','$'
	         DB      '°   °','$'
	         DB      '°   °','$'
	         DB      '°°°°°','$'
	LINEAB   DB      '     ','$'
	         DB      '     ','$'
	         DB      '     ','$'
	         DB      '     ','$'
	         DB      '     ','$'
	         DB      '     ','$'	          
	LINEA1   DB      '³','$'
	LINEA2   DB      '³','$'
	         DB      ' ','$'          
	INSTRUCCION DB   'Digite "8" del teclado',0AH,0DH,'   numeral para que los',0AH,0DH,'   vehiculos se muevan','$'        
	;ENTER   DB 0AH,0DH,'$'
	XCARRO1 DB  25 ;abajo
	YCARRO1 DB  30 ;--->
    XCARRO2 DB  25
	YCARRO2 DB  46
	
	a       DB  0
	b       DB  10
	
	MX      DB  15
	MY      DB  3
	
	XCALLE  DB  1 
	XCALLE2 DB  1
	YCALLE  DB  25
	YCALLE1 DB  55 
	YCALLE2 DB  40
	
	
	avance  DB  3
	conta   DB  2   ; le pone el tamaño que quiera
    conta1  DB  27 
    conta2  DB  14
    C       DB  4
    
    ESQUINAIU db 'É','$'
    ESQUINAID db 'È','$'
    ESQUINADU db '»','$'
    ESQUINADD db '¼','$'
    LINEAAA db 'Í','$'
    LINEADI db 'º','$'
;xabajo
;y--->
    XESQUINA1 DB 0 
    YESQUINA1 DB 0 

    XESQUINA2 DB 28
    YESQUINA2 DB 0

    XESQUINA3 DB 0
    YESQUINA3 DB 70

    XESQUINA4 DB 28
    YESQUINA4 DB 70

    XLINEAAA  DB 0
    YLINEAAA  DB 1  

    XLINEADI  DB 28
    YLINEADI  DB 1  
              
    XLINEAAA2  DB 1
    YLINEAAA2  DB 0  

    XLINEADI2  DB 1
    YLINEADI2  DB 70
              
    CONTALINEA DB 69
    CONTALINEA2 DB 27
    
.code 

MOV AX,@DATA
mov ds,ax
GRAPH
;FONDOCOLOR 05h
;0      0000      black
;1      0001      blue
;2      0010      green
;3      0011      cyan
;4      0100      red
;5      0101      magenta
;6      0110      brown
;7      0111      light gray
;8      1000      dark gray
;9      1001      light blue
;A      1010      light green
;B      1011      light cyan
;C      1100      light red
;D      1101      light magenta
;E      1110      yellow
;F      1111      white   
      
;marco principal 
mov ax,0600h
mov bh,9ah
mov cx,0502h
mov dx,0E13h
int 10h
;posicionar el cursor para titulo
mov dx,0803h
mov ah,02h
mov bh,00h
int 10h
;escribir string de titulo 
mov ah,09h
mov cx,01h
mov dx,offset titulo; dir. base string CALCULADORA
int 21h
;posicionar el cursor para texto
mov dx,0A14h
mov ah,02h
mov bh,00h
int 10h

;marco de datos
mov ax,0600h
mov bh,70h
mov cx,0A03h
mov dx,0B12h
Int 10h
;marco Velocidades 
mov ax,0600h
mov bh,4ah
mov cx,0939h
mov dx,0E41h
int 10h 
;marco datos Velocidades
mov ax,0600h
mov bh,20h
mov cx,0A3BH
mov dx,0B3FH
Int 10h 

;*****************************************       
MSJ:  
    gotoxy MX,MY
	imprimir INSTRUCCION   
;************MARCO***********************
 MARCO:
GOTOXY XESQUINA1,YESQUINA1 
    IMPRIMIR ESQUINAIU 
    GOTOXY XESQUINA2,YESQUINA2 
    IMPRIMIR ESQUINAID 
    GOTOXY XESQUINA3,YESQUINA3 
    IMPRIMIR ESQUINADU 
    GOTOXY XESQUINA4,YESQUINA4 
    IMPRIMIR ESQUINADD
    mov CL,CONTALINEA
BORDE1:  
    gotoxy XLINEAAA,YLINEAAA
    imprimir LINEAAA
    gotoxy XLINEADI,YLINEADI
	imprimir LINEAAA         	
	INC     YLINEAAA 
	INC     YLINEADI
	DEC 	CL
    JNZ	    BORDE1

	   
    mov CL,CONTALINEA 
    DEC YLINEAAA
    DEC YLINEADI
    MOV CL,CONTALINEA2
BORDE2:
    gotoxy XLINEAAA2,YLINEAAA2
    imprimir LINEADI
    gotoxy XLINEADI2,YLINEADI2
	imprimir LINEADI         	
	INC     XLINEAAA2 
	INC     XLINEADI2
	DEC 	CL
    JNZ	    BORDE2

	   
    mov CL,CONTALINEA2 
    DEC XLINEAAA2
    DEC XLINEADI2

;**********************************************
;**********CARRO1*******************
mover:    
    ;limpiar
    ;ADD XCARRO1,18
    ;mov YCARRO1 ,31 
    ;ADD XCARRO2,18
    ;mov YCARRO2 ,46
    ADD  a ,0
    mov  b, 30
	mov cl,conta
                     
; Imprimir linea
OTRO:  
    gotoxy XCARRO1,YCARRO1
	imprimir LINEA 
	gotoxy XCARRO2,YCARRO2
	imprimir LINEA
	INC   XCARRO1 
	INC   XCARRO2
    DEC 	CL
    JNZ	    OTRO

	   
	   mov CL,conta 
       DEC XCARRO1
       DEC XCARRO2
       
;***********CALLE********************
     mov cl,conta1
OTRO1:  
    gotoxy XCALLE,YCALLE
    imprimir LINEA1
    gotoxy XCALLE,YCALLE1
	imprimir LINEA1         	
	INC    XCALLE
    DEC 	CL
    JNZ	    OTRO1

	   
	   mov CL,conta1 
       DEC XCALLE

;***********CALLEMEDIO********************
     mov cl,conta2
OTRO2:           
	gotoxy XCALLE2,YCALLE2	
	imprimir LINEA2	
	INC    XCALLE2
	ADD    XCALLE2,1
    DEC 	CL
    JNZ	    OTRO2

	   
	   mov CL,conta2 
       DEC XCALLE2
    

;***********SIMULACION********************
;DOS
;*****************************************
SIM:
READKEY       
CMP AL,56               
JE correr           
correr:                             
call  otrocarro0 
READKEY
CMP AL,56               
JE correr1 
correr1:                                          
call  otrocarro1 
READKEY
CMP AL,56               
JE correr2
correr2:
CALL  otrocarro2
READKEY
CMP AL,56               
JE correr3 
correr3:
call otrocarro3
    ;posicionar cursor Velocidades
    mov dx,0B3CH
    mov ah,02h
    mov bh,00h
    int 10h 
    CALL RANDOMVELOCIDAD
    ;posicionar cursor placas
    mov dx,0B07h
    mov ah,02h
    mov bh,00h
    int 10h
    CALL RANDOMPLACA  
READKEY
CMP AL,56               
JE correr4
correr4:
CALL otrocarro4           
READKEY
CMP AL,56               
JE correr5
correr5:
CALL otrocarro5
JMP SIM

;**********************************************
;**********************************************
;**********************************************
;**********************************************
;**********************************************
RANDOMPLACA PROC 
Mov ah,2Ch
Int 21h
xor ax, ax
mov dh, 00h
add ax, dx
aaa
add ax, 3030h
mov numero[0], ax 
lea dx, numero
mov ah, 9
int 21h
Mov ah,2Ch
Int 21h
xor ax, ax
mov dh, 00h
add ax, dx
aaa
add ax, 3030h
mov numero[0], ax 
lea dx, numero
mov ah, 9
int 21h
Mov ah,2Ch
Int 21h
xor ax, ax
mov dh, 00h
add ax, dx
aaa
add ax, 3030h
mov numero[0], ax 
lea dx, numero
mov ah, 9
int 21h
Mov ah,2Ch
Int 21h
xor ax, ax
mov dh, 00h
add ax, dx
aaa
add ax, 3030h
mov numero[0], ax 
lea dx, numero
mov ah, 9
int 21h

RET         
ENDP 
;************************************
RANDOMVELOCIDAD PROC    
Mov ah,2Ch
Int 21h
xor ax, ax
mov dh, 00h
add ax, dx
aaa
add ax, 3030h
mov numero[0], ax 
lea dx, numero
mov ah, 9
int 21h    
    RET
ENDP
;****PROCEDIMIENTOS-MOVER-CARROS*****
otrocarro0 PROC
    mov XCARRO1,25
    mov YCARRO1,30 
    mov XCARRO2,25
    mov YCARRO2,46
    ADD  a ,0
    mov  b, 30
	mov cl,3                                      
    
    mover0:
    gotoxy XCARRO1,YCARRO1
	imprimir LINEA 
	gotoxy XCARRO2,YCARRO2
	imprimir LINEA
	INC   XCARRO1 
	INC   XCARRO2
       
    DEC 	CL
    JNZ	    mover0
    
    mov XCARRO1,20
    mov YCARRO1,30 
    mov XCARRO2,20
    mov YCARRO2,46
    ADD  a ,0
    mov  b, 30
	mov cl,3                                      
    
    mover01:
    gotoxy XCARRO1,YCARRO1
	imprimir LINEAB 
	gotoxy XCARRO2,YCARRO2
	imprimir LINEAB
	INC   XCARRO1 
	INC   XCARRO2
       
    DEC 	CL
    JNZ	    mover01 
    
    mov XCARRO1,15
    mov YCARRO1,30 
    mov XCARRO2,15
    mov YCARRO2,46
    ADD  a ,0
    mov  b, 30
	mov cl,3                                      
    
    mover02:
    gotoxy XCARRO1,YCARRO1
	imprimir LINEAB 
	gotoxy XCARRO2,YCARRO2
	imprimir LINEAB
	INC   XCARRO1 
	INC   XCARRO2
       
    DEC 	CL
    JNZ	    mover02
    
    mov XCARRO1,10
    mov YCARRO1,30 
    mov XCARRO2,10
    mov YCARRO2,46
    ADD  a ,0
    mov  b, 30
	mov cl,3                                      
    
    mover03:
    gotoxy XCARRO1,YCARRO1
	imprimir LINEAB 
	gotoxy XCARRO2,YCARRO2
	imprimir LINEAB
	INC   XCARRO1 
	INC   XCARRO2
       
    DEC 	CL
    JNZ	    mover03
    
    mov XCARRO1,5
    mov YCARRO1,30 
    mov XCARRO2,5
    mov YCARRO2,46
    ADD  a ,0
    mov  b, 30
	mov cl,3                                      
    
    mover04:
    gotoxy XCARRO1,YCARRO1
	imprimir LINEAB 
	gotoxy XCARRO2,YCARRO2
	imprimir LINEAB
	INC   XCARRO1 
	INC   XCARRO2
       
    DEC 	CL
    JNZ	    mover04
    
    mov XCARRO1,1
    mov YCARRO1,30 
    mov XCARRO2,1
    mov YCARRO2,46
    ADD  a ,0
    mov  b, 30
	mov cl,3                                      
    
    mover05:
    gotoxy XCARRO1,YCARRO1
	imprimir LINEAB 
	gotoxy XCARRO2,YCARRO2
	imprimir LINEAB
	INC   XCARRO1 
	INC   XCARRO2
       
    DEC 	CL
    JNZ	    mover05             
RET         
ENDP 
otrocarro1 PROC
     
    mov XCARRO1,20
    mov YCARRO1,30 
    mov XCARRO2,20
    mov YCARRO2,46
    ADD  a ,0
    mov  b, 30
	mov cl,3                                      
    
    mover100:
    gotoxy XCARRO1,YCARRO1
	imprimir LINEA 
	gotoxy XCARRO2,YCARRO2
	imprimir LINEA
	INC   XCARRO1 
	INC   XCARRO2 
    
    DEC 	CL
    JNZ	    mover100
    
    mov XCARRO1,25
    mov YCARRO1,30 
    mov XCARRO2,25
    mov YCARRO2,46
    ADD  a ,0
    mov  b, 30
	mov cl,3                                      
    
    mover101:
    gotoxy XCARRO1,YCARRO1
	imprimir LINEAB 
	gotoxy XCARRO2,YCARRO2
	imprimir LINEAB
	INC   XCARRO1 
	INC   XCARRO2 
    
    DEC 	CL
    JNZ	    mover101
               
  RET         
ENDP 
otrocarro2 PROC
    mov XCARRO1,15
    mov YCARRO1,30 
    mov XCARRO2,15
    mov YCARRO2,46
    ADD  a ,0
    mov  b, 30
	mov cl,3                                      
    
    mover200:
    gotoxy XCARRO1,YCARRO1
	imprimir LINEA 
	gotoxy XCARRO2,YCARRO2
	imprimir LINEA
	INC   XCARRO1 
	INC   XCARRO2
         
    DEC 	CL
    JNZ	    mover200
    
    mov XCARRO1,20
    mov YCARRO1,30 
    mov XCARRO2,20
    mov YCARRO2,46
    ADD  a ,0
    mov  b, 30
	mov cl,3                                      
    
    mover201:
    gotoxy XCARRO1,YCARRO1
	imprimir LINEAB   
	gotoxy XCARRO2,YCARRO2
	imprimir LINEAB
	INC   XCARRO1 
	INC   XCARRO2
         
    DEC 	CL
    JNZ	    mover201
    
    mov XCARRO1,25
    mov YCARRO1,30 
    mov XCARRO2,25
    mov YCARRO2,46
    ADD  a ,0
    mov  b, 30
	mov cl,3                                      
    
    mover202:
    gotoxy XCARRO1,YCARRO1
	imprimir LINEA 
	gotoxy XCARRO2,YCARRO2
	imprimir LINEA
	INC   XCARRO1 
	INC   XCARRO2
         
    DEC 	CL
    JNZ	    mover202
    RET         
ENDP 
  
otrocarro3 PROC
    mov XCARRO1,10
    mov YCARRO1,30 
    mov XCARRO2,10
    mov YCARRO2,46
    ADD  a ,0
    mov  b, 30
	mov cl,3                                      
    
    mover300:
    gotoxy XCARRO1,YCARRO1
	imprimir LINEA 
	gotoxy XCARRO2,YCARRO2
	imprimir LINEA
	INC   XCARRO1 
	INC   XCARRO2
        
    DEC 	CL
    JNZ	    mover300 
    
    mov XCARRO1,20
    mov YCARRO1,30 
    mov XCARRO2,20
    mov YCARRO2,46
    ADD  a ,0
    mov  b, 30
	mov cl,3                                      
    
    mover301:
    gotoxy XCARRO1,YCARRO1
	imprimir LINEA 
	gotoxy XCARRO2,YCARRO2
	imprimir LINEA
	INC   XCARRO1 
	INC   XCARRO2
        
    DEC 	CL
    JNZ	    mover301
    
    mov XCARRO1,25
    mov YCARRO1,30 
    mov XCARRO2,25
    mov YCARRO2,46
    ADD  a ,0
    mov  b, 30
	mov cl,3                                      
    
    mover302:
    gotoxy XCARRO1,YCARRO1
	imprimir LINEAB 
	gotoxy XCARRO2,YCARRO2
	imprimir LINEAB
	INC   XCARRO1 
	INC   XCARRO2
        
    DEC 	CL
    JNZ	    mover302
    
    mov XCARRO1,15
    mov YCARRO1,30 
    mov XCARRO2,15
    mov YCARRO2,46
    ADD  a ,0
    mov  b, 30
	mov cl,3                                      
    
    mover303:
    gotoxy XCARRO1,YCARRO1
	imprimir LINEAB 
	gotoxy XCARRO2,YCARRO2
	imprimir LINEAB
	INC   XCARRO1 
	INC   XCARRO2
        
    DEC 	CL
    JNZ	    mover303 

    RET
ENDP

otrocarro4 PROC
    mov XCARRO1,5
    mov YCARRO1,30 
    mov XCARRO2,5
    mov YCARRO2,46
    ADD  a ,0
    mov  b, 30
	mov cl,3                                      
    
    mover400:
    gotoxy XCARRO1,YCARRO1
	imprimir LINEA 
	gotoxy XCARRO2,YCARRO2
	imprimir LINEA
	INC   XCARRO1 
	INC   XCARRO2
        
    DEC 	CL
    JNZ	    mover400
    
    mov XCARRO1,25
    mov YCARRO1,30 
    mov XCARRO2,25
    mov YCARRO2,46
    ADD  a ,0
    mov  b, 30
	mov cl,3                                      
    
    mover401:
    gotoxy XCARRO1,YCARRO1
	imprimir LINEA 
	gotoxy XCARRO2,YCARRO2
	imprimir LINEA
	INC   XCARRO1 
	INC   XCARRO2
        
    DEC 	CL
    JNZ	    mover401 
    
    mov XCARRO1,15
    mov YCARRO1,30 
    mov XCARRO2,15
    mov YCARRO2,46
    ADD  a ,0
    mov  b, 30
	mov cl,3                                      
    
    mover402:
    gotoxy XCARRO1,YCARRO1
	imprimir LINEA 
	gotoxy XCARRO2,YCARRO2
	imprimir LINEA
	INC   XCARRO1 
	INC   XCARRO2
        
    DEC 	CL
    JNZ	    mover402
    
    mov XCARRO1,20
    mov YCARRO1,30 
    mov XCARRO2,20
    mov YCARRO2,46
    ADD  a ,0
    mov  b, 30
	mov cl,3                                      
    
    mover403:
    gotoxy XCARRO1,YCARRO1
	imprimir LINEAB 
	gotoxy XCARRO2,YCARRO2
	imprimir LINEAB
	INC   XCARRO1 
	INC   XCARRO2
        
    DEC 	CL
    JNZ	    mover403
    
    mov XCARRO1,10
    mov YCARRO1,30 
    mov XCARRO2,10
    mov YCARRO2,46
    ADD  a ,0
    mov  b, 30
	mov cl,3                                      
    
    mover404:
    gotoxy XCARRO1,YCARRO1
	imprimir LINEAB 
	gotoxy XCARRO2,YCARRO2
	imprimir LINEAB
	INC   XCARRO1 
	INC   XCARRO2
        
    DEC 	CL
    JNZ	    mover404   
              
  RET         
ENDP           
   
otrocarro5 PROC
    mov XCARRO1,1
    mov YCARRO1,30 
    mov XCARRO2,1
    mov YCARRO2,46
    ADD  a ,0
    mov  b, 30
	mov cl,3                                      
    
    mover500:
    gotoxy XCARRO1,YCARRO1
	imprimir LINEA 
	gotoxy XCARRO2,YCARRO2
	imprimir LINEA
	INC   XCARRO1 
	INC   XCARRO2
        
    DEC 	CL
    JNZ	    mover500 
    
    mov XCARRO1,20
    mov YCARRO1,30 
    mov XCARRO2,20
    mov YCARRO2,46
    ADD  a ,0
    mov  b, 30
	mov cl,3                                      
    
    mover501:
    gotoxy XCARRO1,YCARRO1
	imprimir LINEA 
	gotoxy XCARRO2,YCARRO2
	imprimir LINEA
	INC   XCARRO1 
	INC   XCARRO2
        
    DEC 	CL
    JNZ	    mover501
    
    mov XCARRO1,10
    mov YCARRO1,30 
    mov XCARRO2,10
    mov YCARRO2,46
    ADD  a ,0
    mov  b, 30
	mov cl,3                                      
    
    mover502:
    gotoxy XCARRO1,YCARRO1
	imprimir LINEA 
	gotoxy XCARRO2,YCARRO2
	imprimir LINEA
	INC   XCARRO1 
	INC   XCARRO2
        
    DEC 	CL
    JNZ	    mover502
    
    mov XCARRO1,25
    mov YCARRO1,30 
    mov XCARRO2,25
    mov YCARRO2,46
    ADD  a ,0
    mov  b, 30
	mov cl,3                                      
    
    mover503:
    gotoxy XCARRO1,YCARRO1
	imprimir LINEAB 
	gotoxy XCARRO2,YCARRO2
	imprimir LINEAB
	INC   XCARRO1 
	INC   XCARRO2
        
    DEC 	CL
    JNZ	    mover503
    
    mov XCARRO1,15
    mov YCARRO1,30 
    mov XCARRO2,15
    mov YCARRO2,46
    ADD  a ,0
    mov  b, 30
	mov cl,3                                      
    
    mover504:
    gotoxy XCARRO1,YCARRO1
	imprimir LINEAB 
	gotoxy XCARRO2,YCARRO2
	imprimir LINEAB
	INC   XCARRO1 
	INC   XCARRO2
        
    DEC 	CL
    JNZ	    mover504  
    
    mov XCARRO1,5
    mov YCARRO1,30 
    mov XCARRO2,5
    mov YCARRO2,46
    ADD  a ,0
    mov  b, 30
	mov cl,3                                      
    
    mover505:
    gotoxy XCARRO1,YCARRO1
	imprimir LINEAB 
	gotoxy XCARRO2,YCARRO2
	imprimir LINEAB
	INC   XCARRO1 
	INC   XCARRO2
        
    DEC 	CL
    JNZ	    mover505       
              
  RET         
ENDP
         
END