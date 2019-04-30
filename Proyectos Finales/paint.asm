

data segment

                                                                      
;Este sera el color del pincel
;-----------------------------
;Negro         = 0
;Azul          = 1                 
;Verde         = 2
;Celeste       = 3
;Rojo          = 4
;Magenta       = 5
;Cafe          = 6
;Gris Claro    = 7
;Gris Oscuro   = 8
;Azul Claro    = 9
;Verde Claro   = 10
;Celeste Claro = 11
;Rojo Claro    = 12
;Magenta Claro = 13
;Amarillo      = 14
;Blanco        = 15

;Me van a servir para manejar la posicion de la barra
aux      dw  0 
posbarrax dw 3
posbarray dw 199
cont     dw 0
init     dw 0 
datos      dw 0

grax     db  "",13,10,
         db  "  Gracias por utilizar Paint Malignant Se despide",13,10,
         db  "  Presione una tecla para salir...$"      
radio db "Ingrese el valor del radio:$"         
         
w equ 20
h equ 20  

cc1 dw 0
cc2 dw 0
ff1 dw 0
ff2 dw 0   

XC 	  DW 320      ; Posicion de X del centro
	YC 	  DW 240  ; Posicion de Y del centro
	TEMPO DW ?    ; Temporal
	
	COLOR DB 20   ; Color inicial
	LAST  DB "5"
	RAD   DW 40	  ; Radio del circulo
	HOR   DW ?
	VER   DW ?
	VID   DB ?	; Salvamos el modo de video 

         
ends
;Termina segmento de datos

;Empieza segmento del Stack

;Termina el segmento del Stack

;Elpieza el segmento de codigo
code segment

;La etiqueta general, se finaliza hasta que termina el programa
start:

                                   
                                       
;color inicial, azul (init le suma 1)
mov si,0 
MOV     AX, @data
MOV     DS, AX 

 






grafico:
mov al,13h   ;Tamano pantalla 320x200, 256 colores
mov ah,00h   ;Para establecer modo de video
int 10h      ;Interrupcion que activa modo de video 
mov ax,0000h ;valor para nicializar el mouse
int 33h      ;Interrupcion del Mouse
mov ax,0001h ;Mostrar el puntero
int 33h      ;Interrupcion del Mouse


cmp init,0
je rotar
;Aqui empieza un bucle infinito que siempre estara escuchando
;al mouse y al teclado, solo saldra cuando presionen ESC            
Mouse:
mov ax,0003h ;Asigno el valor a AX para validar clic 
int 33h      ;Interrupcion para leer el mouse
 
;Estamos dividiendo CX por corrimiento a la derecha
;Ejemplo: si CX = 110 (6) entonces luego del corrimiento quedaria asi
;CX = 11 (3), al haberlo corrido 1 bit a la derecha implicitamente
shr cx,1     ;lo estamos dividiendo entre dos    

;Con la interrupcion 16h y AH=01h estaremos escuchando siempre
;el teclado sin que nos intervenga en la escucha del mouse
leertecla:
mov ah,01h
int 16h
;Saltamos si no hay teclas presionadas a 'notecla'
jz notecla

;En caso de haber una tecla vuelvo a llamar a 16h con AH = 0 y comparo 
mov ah,0h
int 16h
cmp al,2bh   ;en caso de signo +
je rotar     ;cambio de color (color += 1) 

cmp al,2dh   ;en caso de signo -
je rotar2    ;cambio de color (color += 2)

cmp al,0dh   ;en caso de Enter
je reiniciar ;Reiniciamos

cmp al,9h    ;en caso de Tab
je start     ;Volvemos a los datos  

cmp al,63h   ;en caso de c
je cuadrado  ; saltamos a cuadrado   


cmp al,6ch   ; en caso de l
je linea     ; saltamos a linea  

cmp al,6fh
je circuloradio

cmp al,1bh   ;ESC = 1b, osea si presionamos ESC...
je fin       ;en caso de que se haya presionado ESC
             ;nos vamos al final del programa (salimos), sino...


;Seguimos como si nada se hubiera presionado 
notecla: 
;mov bx,01h
cmp bx,01h   ;comparo el valor de bx para validar si hizo clic
jz imprimir  ;Si hizo click izq. me voy a 'imprimir'

cmp bx,03h   ;comparo si se hizo click con los dos botones a la vez
jz borrar    ;Si se hizo click con ambos botones me voy a borrar

cmp bx,02h   ;comparo si se hizo click derecho
jz rotar     ;Si se hizo click derecho cambio de color

jmp Mouse    ;Si aun no se ha dado click ni presionado ESC volvemos a
             ;empezar de nuevo el ciclo desde 'Mouse'


;para dibujar linea


;marco  

cuadrado: 

      Mouse2:
mov ax,0003h ;Asigno el valor a AX para validar clic 
int 33h      ;Interrupcion para leer el mouse
 
;Estamos dividiendo CX por corrimiento a la derecha
;Ejemplo: si CX = 110 (6) entonces luego del corrimiento quedaria asi
;CX = 11 (3), al haberlo corrido 1 bit a la derecha implicitamente
shr cx,1     ;lo estamos dividiendo entre dos    

;Con la interrupcion 16h y AH=01h estaremos escuchando siempre
;el teclado sin que nos intervenga en la escucha del mouse
leertecla2:
mov ah,01h
int 16h
;Saltamos si no hay teclas presionadas a 'notecla'
jz notecla2

;En caso de haber una tecla vuelvo a llamar a 16h con AH = 0 y comparo 
mov ah,0h
int 16h 

cmp al,66h   ;en caso de signo +
je guardar 

cmp al,0dh   ;en caso de Enter
je reiniciar ;Reiniciamos

cmp al,63h   ;en caso de c
je cuadrado  ; saltamos a cuadrado   


cmp al,6ch   ; en caso de l
je linea     ; saltamos a linea  

cmp al,6fh
je circuloradio

cmp al,1bh   ;ESC = 1b, osea si presionamos ESC...
je fin       ;en caso de que se haya presionado ESC
             ;nos vamos al final del programa (salimos), sino...


;Seguimos como si nada se hubiera presionado 
notecla2: 

cmp bx,01h   ;comparo el valor de bx para validar si hizo clic
jz guardar  ;Si hizo click izq. me voy a 'imprimir'

cmp bx,03h   ;comparo si se hizo click con los dos botones a la vez
;jz borrar    ;Si se hizo click con ambos botones me voy a borrar

cmp bx,02h   ;comparo si se hizo click derecho
;jz rotar     ;Si se hizo click derecho cambio de color

jmp Mouse2    ;Si aun no se ha dado click ni presionado ESC volvemos a
             ;empezar de nuevo el ciclo desde 'Mouse'
       
guardar: 

cmp datos,0
jz dato0

cmp datos,1
 jz dato1   
 
 


 cua:    
     ; draw upper line:
 mov ax,si  
 ;mov cc1, 10
 ;mov cc2, 30
 ;mov ff1,10
 ;mov ff2,40
    mov cx, cc2  ; column
    mov dx, ff1     ; row
    ;mov al, 15     ; white
u1: mov ah, 0ch    ; put pixel
    int 10h
    
    dec cx
    cmp cx, cc1
    jae u1
 
; draw bottom line:

    mov cx, cc2  ; column
    mov dx, ff2   ; row
    ;mov al, 15     ; white
u2: mov ah, 0ch    ; put pixel
    int 10h
    
    dec cx
    cmp cx, cc1
    ja u2
 
; draw left line:

    mov cx, cc1    ; column
    mov dx, ff2   ; row
    ;mov al, 15     ; white
u3: mov ah, 0ch    ; put pixel
    int 10h
    
    dec dx
    cmp dx, ff1
    ja u3 
    
    
; draw right line:

    mov cx, cc2  ; column
    mov dx, ff2   ; row
    ;mov al, 15     ; white
u4: mov ah, 0ch    ; put pixel
    int 10h
    
    dec dx
    cmp dx, ff1
    ja u4 
    
   

dato0:
mov cc1,cx  
mov ff1,dx
mov datos,1
jmp Mouse2

dato1:

mov cc2,cx 
mov ff2,dx 
mov datos,2 
jmp cua
      
     
linea:
  
      Mouse3:
mov ax,0003h ;Asigno el valor a AX para validar clic 
int 33h      ;Interrupcion para leer el mouse
 
;Estamos dividiendo CX por corrimiento a la derecha
;Ejemplo: si CX = 110 (6) entonces luego del corrimiento quedaria asi
;CX = 11 (3), al haberlo corrido 1 bit a la derecha implicitamente
shr cx,1     ;lo estamos dividiendo entre dos    

;Con la interrupcion 16h y AH=01h estaremos escuchando siempre
;el teclado sin que nos intervenga en la escucha del mouse
leertecla3:
mov ah,01h
int 16h
;Saltamos si no hay teclas presionadas a 'notecla'
jz notecla3

;En caso de haber una tecla vuelvo a llamar a 16h con AH = 0 y comparo 
mov ah,0h
int 16h 

cmp al,66h   
je guardar3 

cmp al,0dh   ;en caso de Enter
je reiniciar ;Reiniciamos

cmp al,63h   ;en caso de c
je cuadrado  ; saltamos a cuadrado   


cmp al,6ch   ; en caso de l
je linea     ; saltamos a linea  

cmp al,6fh
je circuloradio

cmp al,1bh   ;ESC = 1b, osea si presionamos ESC...
je fin       ;en caso de que se haya presionado ESC
             ;nos vamos al final del programa (salimos), sino...


;Seguimos como si nada se hubiera presionado 
notecla3: 

cmp bx,01h   ;comparo el valor de bx para validar si hizo clic
jz guardar3  ;Si hizo click izq. me voy a 'imprimir'

cmp bx,03h   ;comparo si se hizo click con los dos botones a la vez
;jz borrar    ;Si se hizo click con ambos botones me voy a borrar

cmp bx,02h   ;comparo si se hizo click derecho
;jz rotar     ;Si se hizo click derecho cambio de color

jmp Mouse3    ;Si aun no se ha dado click ni presionado ESC volvemos a
             ;empezar de nuevo el ciclo desde 'Mouse'
       
guardar3: 

cmp datos,0
jz dato2

cmp datos,1
 jz dato3


 lin:    
  mov ax,si  

    mov cx, cc2  ; column
    mov dx, ff1     ; row
    ;mov al, 15     ; white
l1: mov ah, 0ch    ; put pixel
    int 10h
    
    dec cx
    cmp cx, cc1
    jae l1
 
; draw bottom line:
    mov ax,0
    mov cx, cc2  ; column
    mov dx, ff2   ; row
    ;mov al, 15     ; white
l2: mov ah, 0ch    ; put pixel
    int 10h
    
    dec cx
    cmp cx, cc1
    ja l2
 
; draw left line:

    mov cx, cc1    ; column
    mov dx, ff2   ; row
    ;mov al, 15     ; white
l3: mov ah, 0ch    ; put pixel
    int 10h
    
    dec dx
    cmp dx, ff1
    ja l3 
    
    
; draw right line:

    mov cx, cc2  ; column
    mov dx, ff2   ; row
    ;mov al, 15     ; white
l4: mov ah, 0ch    ; put pixel
    int 10h
    
    dec dx
    cmp dx, ff1
    ja l4 
     

dato2:
mov cc1,cx  
mov ff1,dx
mov datos,1
jmp Mouse3

dato3:

mov cc2,cx 
mov ff2,dx 
mov datos,2 
jmp lin



circuloradio: 
mov xc,cx
mov yc,dx  

    MOV     AH,2
        MOV     DL,0
        MOV     DH,0
        INT     10H

   lea dx,radio
   mov ah, 9   
int 21h 

   
   MOV     AH,1
     INT     21H
     sub al,30h
 mov ah,00 
 mov bl,10
 mul bl 
 mov rad,ax 
 
 


circulo: 
 mov color,al

       MOV CX,XC
	MOV DX,YC
	CALL PUNTEAR
	
	CALL INFI
INFI PROC NEAR
ITERA:
	CALL GRAFICAR
	CALL ESCUCHAR
	JNZ ATENDER ; Si no está vacío atiende el que está
	; Si está vacío atiende el último ingresado
	MOV AL,LAST 
	jmp mouse
	
ATENDER:
	CMP AL, "1"
	JNZ E2
	CALL MOVSWEST
	JMP ITERA
E2:	
	CMP AL, "2"
	JNZ E3
	CALL MOVSOUTH	
	JMP ITERA
E3:	
	CMP AL, "3"
	JNZ E4
	CALL MOVSEAST
	JMP ITERA
E4:	
	CMP AL, "4"
	JNZ E5
	CALL MOVWEST
	JMP ITERA
E5:	
	CMP AL, "5"
	JNZ E6
	CALL DONTMOVE
	JMP ITERA
E6:
	CMP AL, "6"
	JNZ E7
	CALL MOVEAST
	JMP ITERA
E7:	
	CMP AL, "7"
	JNZ E8
	CALL MOVNWEST	
	JMP ITERA
E8:	
	CMP AL, "8"
	JNZ E9
	CALL MOVNORTH	
	JMP ITERA
E9:	
	CMP AL, "9"
	JNZ E10
	CALL MOVNEAST	
	JMP ITERA
; Alteración del RADIO a tiempo real
E10:
	CMP AL,"+"
	JNZ E11
	CALL INCREASE
	JMP ITERA
E11:
	CMP AL,"-"
	JNZ CAMBIARC
	CALL DECREASE
	JMP ITERA
; Modificación del COLOR a tiempo real
CAMBIARC:
	CMP AL,"c"
	JNZ QUIT
	CALL CCOLOR
	JMP ITERA
QUIT:	
	CMP AL, "q"
	JNZ reiniciar
	RET
INFI ENDP

INCREASE PROC NEAR
	CALL BORRAR
	MOV AX,XC
	ADD AX,RAD
	SUB AX,640
	JZ DONTINC
	MOV AX,XC
	SUB AX,RAD
	JZ DONTINC
	MOV AX,YC
	SUB AX,RAD
	JZ DONTINC
	MOV AX,YC
	ADD AX,RAD
	SUB AX,480
	JZ DONTINC
	INC RAD
	; Si no colisiona al crecer, crece
DONTINC:
	RET
INCREASE ENDP

DECREASE PROC NEAR
	CALL BORRAR
	CMP RAD,10
	JE DONTDEC
	DEC RAD
	; Si no es diminuto puede seguir decreciendo
DONTDEC:
	RET
DECREASE ENDP	

CCOLOR PROC NEAR
	ADD COLOR,27
	;MOV LAST,"5" Que se detenga al cambiar de color
	RET
CCOLOR ENDP

MOVSWEST PROC NEAR
	MOV AX,XC
	SUB AX,RAD
	JNZ NO1
	CALL MOVSEAST
	RET
NO1:
	MOV AX,YC
	ADD AX,RAD
	SUB AX,480
	JNZ	NO2
	CALL MOVNWEST
	RET
NO2:
	CALL BORRARr
	INC YC
	DEC XC
	MOV LAST,"1"
	RET
MOVSWEST ENDP

MOVSOUTH PROC NEAR
	MOV AX,YC
	ADD AX,RAD
	SUB AX,480
	JNZ NO3
	CALL MOVNORTH
	RET
NO3:
	CALL BORRARr
	INC YC
	MOV LAST,"2"
	RET
MOVSOUTH ENDP

MOVSEAST PROC NEAR
	MOV AX,YC
	ADD AX,RAD
	SUB AX,480
	JNZ NO4
	CALL MOVNEAST
	RET
NO4:
	MOV AX,XC
	ADD AX,RAD
	SUB AX,640
	JNZ NO5
	CALL MOVSWEST
	RET
NO5:
	CALL BORRARr
	INC YC
	INC XC
	MOV LAST,"3"
	RET
MOVSEAST ENDP

MOVWEST PROC NEAR
	MOV AX,XC
	SUB AX,RAD
	JNZ NO6
	CALL MOVEAST
	RET
NO6:
	CALL BORRARr
	DEC XC
	MOV LAST,"4"
	RET
MOVWEST ENDP

MOVEAST PROC NEAR
	MOV AX,XC
	ADD AX,RAD
	SUB AX,640
	JNZ NO7
	CALL MOVWEST
	RET
NO7:
	CALL BORRARr
	INC XC
	MOV LAST,"6"
	RET
MOVEAST ENDP

MOVNWEST PROC NEAR
	MOV AX,XC
	SUB AX,RAD
	JNZ NO8
	CALL MOVNEAST
	RET
NO8:
	MOV AX,YC
	SUB AX,RAD
	JNZ NO9
	CALL MOVSWEST
	RET
NO9:
	CALL BORRARr
	DEC YC
	DEC XC
	MOV LAST,"7"
	RET
MOVNWEST ENDP

MOVNORTH PROC NEAR
	MOV AX,YC
	SUB AX,RAD
	JNZ NO10
	CALL MOVSOUTH
	RET
NO10:
	CALL BORRARr
	DEC YC
	MOV LAST,"8"
	RET
MOVNORTH ENDP

MOVNEAST PROC NEAR
	MOV AX,XC
	ADD AX,RAD
	SUB AX,640
	JNZ NO11
	CALL MOVNWEST
	RET
NO11:
	MOV AX,YC
	SUB AX,RAD
	JNZ NO12
	CALL MOVSEAST
	RET
NO12:
	CALL BORRARr
	DEC YC
	INC XC
	MOV LAST,"9"
	RET
MOVNEAST ENDP

DONTMOVE PROC NEAR
	; CALL GRAFICAR
	MOV AH,00h
	INT 16h
; Si deseamos que parpadee, eliminamos las 3 de arriba.
	MOV LAST,AL
	RET
DONTMOVE ENDP

BORRARr PROC NEAR
	MOV CX,0
	MOV CL,COLOR
	PUSH CX         ; Ya que en GRAFICAR se usan todos los registros
	MOV COLOR,00h
	CALL GRAFICAR
	POP CX
	MOV COLOR,CL
	RET
BORRARr ENDP

PUNTEAR PROC NEAR
	; Grafica un punto en CX,DX 
	MOV AH,0Ch		; Petición para escribir un punto
	MOV AL,COLOR	; Color del pixel
	MOV BH,00h		; Página
	INT 10H			; Llamada al BIOS
	RET
PUNTEAR ENDP

GRAFICAR PROC NEAR
; Graficamos todo el circulo !
	MOV HOR,0
	MOV AX,RAD
	MOV VER,AX
	
BUSQUEDA:
	CALL BUSCAR
	
    MOV AX,VER
	SUB AX,HOR
	CMP AX,1
	JA BUSQUEDA
	RET
GRAFICAR ENDP

BUSCAR PROC NEAR
; Se encarga de buscar la coord del pixel sgte.
	INC HOR ; Horizontalmente siempre aumenta 1
	
	MOV AX,HOR	
	MUL AX
	MOV BX,AX ; X^2 se almacena en BX
	MOV AX,VER
	MUL AX    ; AX almacena Y^2
	ADD BX,AX ; BX almacena X^2 + Y^2
	MOV AX,RAD
	MUL AX    ; AX almacena R^2
	SUB AX,BX ; AX almacena R^2 - (X^2+Y^2)
	
	MOV TEMPO,AX
	
	MOV AX,HOR	
	MUL AX
	MOV BX,AX ; BX almacena X^2
	MOV AX,VER
	DEC AX    ; una unidad menos para Y (¡VAYA DIFERENCIA!)
	MUL AX    ; AX almacena Y^2
	ADD BX,AX ; BX almacena X^2 + Y^2
	MOV AX,RAD
	MUL AX    ; AX almacena R^2
	SUB AX,BX ; AX almacena R^2 - (X^2+Y^2)
	
	CMP TEMPO,AX
	JB NODEC
	DEC VER
NODEC:
	CALL REPUNTEAR
	PUSH VER
	PUSH HOR
	POP VER
	POP HOR   ; Cambiamos valores
	CALL REPUNTEAR
	PUSH VER
	PUSH HOR
	POP VER
	POP HOR   ; Devolvemos originales 
	RET
BUSCAR ENDP
	
REPUNTEAR PROC NEAR
	; I CUADRANTE
	MOV CX,XC
	ADD CX,HOR
	MOV DX,YC
	SUB DX,VER
	CALL PUNTEAR
	; IV CUADRANTE
	MOV DX,YC
	ADD DX,VER
	CALL PUNTEAR
	; III CUADRANTE
	MOV CX,XC
	SUB CX,HOR
	CALL PUNTEAR
	; II CUADRANTE
	MOV DX,YC
	SUB DX,VER
	CALL PUNTEAR
	RET
REPUNTEAR ENDP
	
ESCUCHAR PROC NEAR
	MOV AH,06h     ; Peticion directa a la consola
 	MOV DL,0FFh    ; Entrada de teclado
 	INT 21h        ; Interrupcion que llama al DOS
	; Si ZF está prendido quiere decir que el buffer está vacío.
	RET
	; En AL queda el ASCII del caracter ingresado.
ESCUCHAR ENDP

  jmp circulo



;Aqui empieza la parte que imprime los pixeles para pintar    
imprimir:
cmp cx,0     ;Comparo si CX llego al limite de la pantalla
je putcx     ;Si da verdadero me voy a 'putcx'
jmp continue ;Si es falso continuo en 'continue'
cmp dx,5     ;Comparo DX con 5, poco antes del limite de la pantalla
je putdx     ;Si da verdadero me voy a 'putdx'
jmp continue ;Si es falso continuo en 'continue'

putcx:       ;Si llegue al limite en CX (eje X)
mov cx,5     ;Reseteo a 5 a CX
jmp continue ;Luego continuo

putdx:       ;Si llegue al limite en DX (eje Y)
mov dx,10    ;Reseteo a 10 DX
jmp continue ;Luego continuo

continue:    ;Etiqueta 'continue', cuando todo esta normal
;mov al,rojo  ;Le paso el color a AL 
mov ax,si
mov ah,0ch   ;Le mado la orden de imprimir caracter a AH 
int 10h      ;Aplico cambios con INT 10H, imprimo

;Como los pixeles son demasiado pequenhos, la brocha sale muy
;dispera, por eso procedemos a imprimir varios pixeles
;rodenado al pixel central 
;recordemos que el punto (0,0) no esta en el centro de la pantalla
dec cx       ;decremento la posicion en el eje X
int 10h      ;Imprimo

inc dx       ;incremento la posicion en el eje Y
int 10h      ;Imprimo

inc cx       ;incremento la posicion en el eje X
int 10h      ;Imprimo

inc dx       ;incremento la posicion en el eje Y
int 10h      ;Imprimo

dec cx       ;decremento la posicion en el eje X
int 10h      ;Imprimo

jmp Mouse    ;Regreso al bucle infinito que escucha al mouse
             ;(y al teclado)

;Esto sirve para pintar de color negro
;funciona como borrador y se activa con click derecho
borrar:
cmp cx,0      ;Comparo si CX llego al limite de la pantalla
je putcxb     ;Si da verdadero me voy a 'putcx'
jmp continue2 ;Si es falso continuo en 'continue'
cmp dx,5      ;Comparo DX con 5, poco antes del limite de la pantalla
je putdxb     ;Si da verdadero me voy a 'putdx'
jmp continue2 ;Si es falso continuo en 'continue'

putcxb:       ;Si llegue al limite en CX (eje X)
mov cx,5      ;Reseteo a 5 a CX
jmp continue2 ;Luego continuo

putdxb:       ;Si llegue al limite en DX (eje Y)
mov dx,10     ;Reseteo a 10 DX
jmp continue2 ;Luego continuo


;Aqui se empieza a borrar de verdad
continue2:
mov al,0     ;Le paso el color a AL
mov ah,0ch   ;Le mado la orden de imprimir caracter a AH  
int 10h      ;Aplico cambios con INT 10H, imprimo

;Como los pixeles son demasiado pequenhos, el borrador sale muy
;dispero, por eso procedemos a imprimir varios pixeles
;rodenado al pixel central 
;recordemos que el punto (0,0) no esta en el centro de la pantalla
dec cx       ;decremento la posicion en el eje X
int 10h      ;Imprimo
inc dx       ;incremento la posicion en el eje Y
int 10h      ;Imprimo
inc cx       ;incremento la posicion en el eje X
int 10h      ;Imprimo
inc dx       ;incremento la posicion en el eje Y
int 10h      ;Imprimo
dec cx       ;decremento la posicion en el eje X
int 10h      ;Imprimo
jmp Mouse    ;Regreso al bucle infinito que escucha al mouse
             ;(y al teclado) 
             
rotar2:
cmp si,0     ;Si el color actual es negro
jz reset2    ;me voy a reset 2
dec si       ;sino color = color - 1
jmp continue3;nos vamos a imprimir la palabra COLOR y su cuadrito

reset2:      ;vuelvo a empezar la vuelta de los colores
mov si,15    ;si llego a negro le asigno blanco
jmp continue3;nos vamos a imprimir la palabra COLOR y su cuadrito             
                         
rotar:
mov init,1       
cmp si,15    ;Si el color actual es blanco
jz reset     ;me voy a reset
inc si       ;sino color = color + 1
jmp continue3;nos vamos a imprimir la palabra COLOR y su cuadrito

reset:
mov si,0     ;si llego a blanco le vuelvo a asignar negro

continue3:   ;Empezamos con los paso para imprimir COLOR y su cuadrito
push cx      ;guardamos en la pila
push dx      ;guardamos en la pila

mov cx,306   ;306 es lo maximo para que se mire en la pantalla
mov dx,12    ;12 es lo minimo para que se mire en la pantalla

mov ax,si    ;Le paso el color actual a AX
mov ah,0ch   ;Le mado la orden de imprimir caracter a AH 
int 10h      ;Aplico cambios con INT 10H, imprimo

push ax      ;guardamos el color en turno
;Aqui estamos pintando el cuadrito del color seleccionado
dec cx
int 10h
dec cx
int 10h 
inc dx    
int 10h  
inc cx
int 10h
inc cx
int 10h
inc dx    
int 10h
dec cx
int 10h
dec cx
int 10h  
inc dx    
int 10h  
inc cx
int 10h
inc cx
int 10h
inc dx    
int 10h
dec cx
int 10h
dec cx
int 10h
add cx,3
int 10h
dec dx
int 10h
dec dx
int 10h
dec dx
int 10h
dec dx
int 10h


;Empiezo a pintar el marco blanco
mov al,15    ;color blanco
inc cx    
int 10h   
dec dx     
call dec3cx
int 10h  
dec cx 
int 10h  
dec cx       
call inc6dx    
call inc3cx   
int 10h         
inc cx     
int 10h    
inc cx       
int 10h     
dec dx       
int 10h     
dec dx     
int 10h      
dec dx      
int 10h    
dec dx       
int 10h
             
;empezamos a imprimir las letras de la palabra COLOR
;Aqui imprimimos la R 
pop ax       ;sacamos el color en turno
add cx,10
sub dx,6

int 10h
dec dx
int 10h
dec dx
int 10h
sub dx,2
int 10h
dec dx
int 10h
dec dx
int 10h
dec cx
int 10h
dec cx
call inc6dx
int 10h
inc cx
dec dx
dec dx
int 10h
dec dx
int 10h
dec dx
int 10h

;Aqui empezamos la O
sub dx,2
sub cx,4
int 10h
call pintarO

;Aqui empezamos la L
dec dx
sub cx,6
add dx,6
call dec3cx
call dec5dx
int 10h
dec dx
int 10h

;Aqui la otra O
sub cx,3
call pintarO

;Aqui la C
dec dx
sub cx,6
add dx,6
call dec3cx
call dec5dx
int 10h
dec dx
call inc3cx
int 10h
;terminamos la palabra COLOR

;Aqui empezamos la paleta
mov cx,posbarrax      ;posicion inicial de la paleta, en eje X, minimo 3
mov dx,posbarray    ;posicion inicial de la paleta, en eje Y, maximo 199
mov ax,15     ;color blanco
mov aux,cx
sub aux,1

push bx
mov bx,193
add bx,cx 
loop1:       ;primera linea inferior de la paleta
cmp cx,bx
jz continue4
mov ah,0ch   ;Le mando la orden de imprimir caracter a AH 
int 10h      ;Aplico cambios con INT 10H, imprimo
inc cx
jmp loop1

continue4:
pop bx       
int 10h      ;linea derecha de la paleta
sub dx,5     ;solo posicionado
jmp lineaSup

lineaSup:    ;pintamos la linea superior
cmp cx,aux
jz color1
mov ah,0ch  
int 10h     
dec cx
jmp lineaSup

color1:      ;el primer cuadro de color de la paleta (azul)
call lineaVert
mov al,0     ;color negro
inc cx
inc dx
inc cx
call pintarCuadro
mov al,1     ;color azul
call pintarCuadro
mov al,2     ;color verde 
call pintarCuadro
mov al,3     ;color celeste
call pintarCuadro
mov al,4     ;color rojo
call pintarCuadro
mov al,5     ;color magenta
call pintarCuadro
mov al,6     ;color cafe
call pintarCuadro
mov al,7     ;color gris claro
call pintarCuadro
mov al,8     ;color gris oscuro
call pintarCuadro
mov al,9     ;color azul claro
call pintarCuadro
mov al,10     ;color verde claro
call pintarCuadro
mov al,11     ;color celeste claro
call pintarCuadro
mov al,12     ;color rojo claro
call pintarCuadro
mov al,13     ;color magenta claro
call pintarCuadro
mov al,14     ;color amarillo claro
call pintarCuadro
mov al,15     ;color blanco 
call pintarCuadro
jmp finalCont

finalCont:
pop dx
pop cx
jmp Mouse

;Pinta 10 pixeles horizontales a la derecha
inc9cx proc near
    push bx
    mov bx,0
  a:
    inc cx
    int 10h
    inc bx
    cmp bx,10
    jz b
    jmp a
  b:
    pop bx
    inc dx
    inc cx    
ret
inc9cx endp 

;Pinta 9 pixeles horizontales a la izquierda
dec9cx proc
    push bx
    mov bx,10
  c:
    dec cx 
    int 10h
    dec bx
    cmp bx,0
    jz d
    jmp c
  d:
    pop bx
    inc dx
    dec cx    
ret
dec9cx endp

;Pinta las lineas intermedias blancas de la paleta
lineaVert proc
    pusha
    mov bh,0
    mov bl,0
    inc cx
  e:
    inc dx
    int 10h
    inc bh
    cmp bh,4
    jz f1
    jmp e
    
  f1:inc cx
     mov bh,0
     jmp f
  f:
    int 10h
    dec dx
    inc bh
    cmp bh,4
    jz g
    jmp f
  g:
   mov bh,0
   inc bl
   cmp bl,17
   jz h
   add cx,11
   jmp e
  h:
     popa    
ret
lineaVert endp

;Manda a llamar a los metodos que pintan lineas
pintarCuadro proc
    call inc9cx
    call dec9cx
    call inc9cx 
    call dec9cx
    add cx,12
    sub dx,4
ret
pintarCuadro endp 

;Metodo que imprime una letra O
;vale la pena debido a que usamos dos veces la letra O
;y el metodo es repetitivo
pintarO proc
call dec3cx
call inc6dx
call inc3cx
call dec5dx
int 10h
ret
pintarO endp

;Imprime tres pixeles en horizontal a la izquierda
dec3cx proc
 d31:  
    int 10h
    dec cx
    inc cont
    cmp cont,3
    jz d32
    jmp d31
 d32:
    mov cont,0  
ret
dec3cx endp

;Imprime cinco pixeles en vertical hacia arriba
dec5dx proc
 d51:  
    int 10h
    dec dx
    inc cont
    cmp cont,5
    jz d52
    jmp d51
 d52:
    mov cont,0  
ret
dec5dx endp

;Imprime tres pixeles en horizontal a la derecha
inc3cx proc
 i31:  
    int 10h
    inc cx
    inc cont
    cmp cont,3
    jz i32
    jmp i31
 i32:
    mov cont,0  
ret
inc3cx endp

;Imprime seis pixeles en vertical hacia abajo
inc6dx proc
 i61:  
    int 10h
    inc dx
    inc cont
    cmp cont,6
    jz i62
    jmp i61
 i62:
    mov cont,0 
ret
inc6dx endp

reiniciar:   ;Limpiar pantalla (y usar color siguiente)
mov init,0 
mov datos,0
jmp grafico

fin:         ;Etiqueta que me trae al final del programa
             ;Una vez lleguemos aqui no hay forma de regresar
            
lea dx,grax  ;manda el mensaje a DX, termina cuando encuentra $
             ;En realidad lo esta mandando a DS:DX
mov ah, 9    ;Para activar la interrupcion 21H
int 21h      ;Manda a imprimir el mensaje de agradecimiento
    
        
mov ah, 1    ;Esperamos que se presione una tecla
int 21h      ;Lee caracter desde la entrada estandar
    
mov ax, 4c00h;Regresamos al sistema operativo
             ;Se libera toda la memoria
int 21h      ;Si hubiesen archivos abiertos se cierran

ends         ;Marca el final del segmento de codigo

end start    ;Termina con la etiqueta principal y con ello termina
             ;con la ejecucion del programa  
             
;Malignant se despide             