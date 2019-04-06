
;**************************************************************
;Ejercicio1 - Parcial 2
;Juan Pablo Carmona Campos
;**************************************************************

.MODEL SMALL       
.STACK 100H

.DATA
 
	MEN1    DB      'Ejercicio 1, Parcial 2 - Arquitectura de Datos II','$'
    MEN2    DB      'Hecho por Juan Pablo Carmona Campos','$'
    MEN3    DB      'Ingrese un numero del 1 al 21 para cargar el espiral: ','$'
    MEN4    DB      'ESPIRAL: ','$'
    MEN5    DB      'Desea borrar el espiral?(S/N)','$'
    MEN6    DB      'Desea salir(S/N)','$'				                                                                                                       
	MEN7    DB      'Presione el boton S para salir... ','$'
	MEN8    DB      'Presione una tecla para continuar...  ','$'
	MEN9    DB      'Desea realizar otro espiral? (S/N)','$'
	
	AS      DB      2AH
	ESPACIO DB      1FH
	
	ENTER   DB      0AH,0DH,'$';CREA UNA NUEVA LINEA 
   
    UNIDADES    DB 0
    DECENAS     DB 0
    NUMERO      DB 0
    
    AUX         DB 0
     
    X DB 10
    Y DB 5 
     
     
.CODE

 
	MOV     AX,@DATA
    MOV     DS,AX

	CALL    CURSOR
	LEA     DX,MEN1
	CALL    MENSAJE
    
    MOV     X,10
    MOV     Y,7
    CALL    CURSOR
    LEA     DX,MEN2
	CALL    MENSAJE
	
	MOV     X,10
    MOV     Y,9
    CALL    CURSOR
    LEA     DX,MEN8
	CALL    MENSAJE
	
	CALL    TECLA
	
INICIO:	
	
	CALL    LIMPIAR		
	CALL    CURSOR    
	LEA     DX,MEN3    
    CALL    MENSAJE
    
    CALL    TECLA
    SUB     AL,30H
    MOV     DECENAS,AL

    CALL    TECLA
        
    CMP     AL,31H
    JAE     MASDECERO   ;MAYOR IGUAL
    JMP     VALIDAR
    
MASDECERO:
    
    CMP     AL,40H  
    JAE     SALIR       ;VALIDAR EL NUMERO
    JMP     VALIDO
    
VALIDAR:

    CMP     DECENAS,0
    JE      INICIO

VALIDO:
    	
	SUB 	AL,30H          
  	MOV     UNIDADES,AL   ;SE CARGA EL NUMERO

    MOV     AH,DECENAS
    MOV     AL,UNIDADES      

    AAD
    
    MOV     NUMERO,AL    
  	MOV     AUX,AL  
  	
  	CMP     NUMERO,21
  	JG      INICIO     
  	
  	
  	CALL    LIMPIAR
  	
  	MOV     X,10
  	MOV     Y,0
  	CALL    CURSOR
  	LEA     DX,MEN4
  	CALL    MENSAJE
  	  	
  	;SE CARGA EL ESPIRAL
  	
  	MOV     X,10
  	MOV     Y,2
  	MOV     BL,AUX
  	CALL    ESPIRAL
  	  
FIN:
                       
    MOV     AH,2
    MOV     DL,10
    MOV     DH,1
    INT     10H         ;CURSOR PERO SIN EDITAR LAS COORDENADAS ACTUALES
       
    LEA     DX,MEN5
    CALL    MENSAJE
    CALL    TECLA

    CMP     AL,'S'
    JE      BORRAR
    CMP     AL,'s'
    JE      BORRAR
    CALL    PREGUNTA
    
BORRAR:
    
    MOV     AUX,1
    CALL    BORRARESPIRAL
    CALL    PREGUNTA
    
SALIR:
    CALL    PREGUNTA
    
SALIR2:
                    
    CALL    BOTONSALIR

CERRAR:
     
	MOV     AH,4CH      
    INT     21H         


;***********************DESPLIEGA EN PANTALLA*******************************

MENSAJE PROC
      	MOV	    AH,9
        INT     21H                     
        RET
ENDP
       
       
       
MENSAJE1 PROC
      	 MOV	 AH,2 ; solo imprime el caracter en DL
         INT     21H                     
         RET
ENDP
       

LIMPIAR PROC
        MOV     AH,0
        MOV     AL,3
        INT     10H	
        RET
ENDP

CURSOR  PROC
        MOV     AH,2
        MOV     DL,X
        MOV     DH,Y
        INT     10H                 
        RET
ENDP

TECLA  PROC
       MOV      AH,01H
	   INT      21H
	   RET
ENDP

ESPIRAL PROC
    
    XOR     DX,DX
    
FILA:    
    CALL    CURSOR
    MOV     DL,AS
    CALL    MENSAJE1
    INC     X
    DEC     BL
    JNZ     FILA
    
    DEC     X    
    INC     Y
    MOV     BL,AUX
    
COLUMNA:

    CALL    CURSOR    
    MOV     DL,AS
    CALL    MENSAJE1
    INC     Y
    DEC     BL
    JNZ     COLUMNA
    
    DEC     AUX
    JZ      FIN
    DEC     X
    DEC     Y
    MOV     BL,AUX

FILA2:
    
    CALL    CURSOR
    MOV     DL,AS
    CALL    MENSAJE1
    DEC     X
    DEC     BL
    JNZ     FILA2
    
    INC     X
    DEC     Y
    MOV     BL,AUX
    
COLUMNA2:    
    
    CALL    CURSOR    
    MOV     DL,AS
    CALL    MENSAJE1
    DEC     Y
    DEC     BL
    JNZ     COLUMNA2
    
    DEC     AUX
    JZ      FIN
    
    INC     X
    INC     Y
    MOV     BL,AUX    
    JMP     FILA
                
    RET    
ENDP

BORRARESPIRAL PROC
    
    XOR     DX,DX    
    
    MOV     AH,00
    MOV     AL,NUMERO
    MOV     BL,2
    DIV     BL
    
    CMP     AH,0
    JE      PAR
    JMP     IMPAR

PAR:

    MOV     BL,0
    INC     Y
    JMP     COLUMNABORRAR

IMPAR:

    MOV     BL,0
    DEC     Y
    JMP     COLUMNABORRAR2
        
COLUMNABORRAR2:    
    
    CALL    CURSOR    
    MOV     DL,ESPACIO
    CALL    MENSAJE1
    DEC     Y
    INC     BL
    CMP     BL,AUX 
    JNE     COLUMNABORRAR2
     
    MOV     BL,0
    
FILABORRAR2:
    
    CALL    CURSOR    
    MOV     DL,ESPACIO
    CALL    MENSAJE1
    DEC     X
    INC     BL
    CMP     BL,AUX 
    JNE     FILABORRAR2
       
    INC     AUX
    MOV     AL,NUMERO
    CMP     AL,AUX
    JL      SALIR
    
    MOV     BL,0   
    
COLUMNABORRAR:

    CALL    CURSOR    
    MOV     DL,ESPACIO
    CALL    MENSAJE1
    INC     Y
    INC     BL
    CMP     BL,AUX
    JNE     COLUMNABORRAR
  
    MOV     BL,0
     
FILABORRAR:

    CALL    CURSOR
    MOV     DL,ESPACIO
    CALL    MENSAJE1
    INC     X
    INC     BL
    CMP     BL,AUX
    JNE     FILABORRAR
    
    
    INC     AUX
    MOV     AL,NUMERO
    CMP     AL,AUX
    JL      SALIR
        
    MOV     BL,0
    
    JMP     COLUMNABORRAR2 
                   
    RET    
    
ENDP

BOTONSALIR PROC

    XOR     BX,BX

    ;LIMPIARPANTALLA
    mov     ax,0600h
    mov     bh,007          ;nibble alto: color del fondo  / nibble bajo: color del texto
    mov     cx,0000h        ;Y,X ESQUINA SUPERIOR IZQUIERDA
    mov     dx,2585h        ;Y,X ESQUINA INFERIOR DERECHA
    int     10h    
    
    LEA     DX,MEN7
	CALL    MENSAJE
    
    ;marco de símbolo &
    mov     ax,0600h
    mov     bh,0D7h          ;nibble alto: color del fondo  / nibble bajo: color del texto
    mov     cx,0235h        ;Y,X ESQUINA SUPERIOR IZQUIERDA
    mov     dx,0437h        ;Y,X ESQUINA INFERIOR DERECHA
    int     10h    
    ;posicionar cursor
    mov     ah,02h
    mov     dx,0336h        ;Y,X
    mov     bh,00h
    int     10h
    ;escribir simbolo
    mov     ah,02h
    mov     cx,01h
    mov     dl,53h; simbolo 
    int     21h
    
    ;capturar operacion 
    ;reset mouse and get its status:
    mov     ax, 0
    int     33h
    
    ; display mouse cursor:
    mov     ax, 1
    int     33h


CHECK_MOUSE_BOTTONS:                        ;Verificacion constante de la posicion del mouse
                        
    mov     ax, 3
    int     33h                                ; CX=X  DX=Y
    cmp     bx, 1                              ; Boton izquierdo
    je      comparar
            
    JMP     CHECK_MOUSE_BOTTONS
          
COMPARAR:
    
    
    XOR     CH,CH    
    CMP     CX,00A9H
    JGE     COMPARARX    
    JMP     CHECK_MOUSE_BOTTONS

COMPARARX:
    
    CMP     CX,00BFH
    JLE     COMPARARY    
    JMP     CHECK_MOUSE_BOTTONS
    
COMPARARY:
    
    CMP     DX,0010H
    JGE     VALIDARBOTON
    JMP     CHECK_MOUSE_BOTTONS
               
VALIDARBOTON:

    CMP     DX,0028H
    JLE     BOTONVALIDO     
    JMP     CHECK_MOUSE_BOTTONS
    

BOTONVALIDO:
    
    JMP     CERRAR    
    RET
ENDP 

PREGUNTA PROC
    CALL    LIMPIAR
    MOV     X,10
    MOV     Y,7
    CALL    CURSOR
    LEA     DX,MEN9
	CALL    MENSAJE

    CALL    TECLA
	
    CMP     AL,'S'
    JE      INICIO
    CMP     AL,'s'
    JE      INICIO
    JMP     SALIR2	
   
    RET
ENDP
END