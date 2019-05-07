;Programa "texto5.asm" para ingresar una clave ocultando en pantalla
;el ingreso mediante ***
;hace uso sencillo de colores en pantalla.


.model small
.stack 100h
.data

  cadena1 db 50 dup(' '),'$'; espacio para recibir la cadena 
  
  msj1 db 'El numero de caracteres es:$'
  msj2 db 'Hola este programa cuenta caracteres de la cadena: $' 
  cont dw ?

.code
  mov ax,@data
  mov ds,ax

  mov ah,06h         ; peticion de recorrido de la pantalla
  mov al,00h         ; indica la pantalla completa para el color
  mov bh,57h         ; attributos de color de fondo y texto   7 blanco 0 negro    
  mov cx,0000h       ; esquina superior izquierda renglon-columna (25x80)
  mov dx,184Fh       ; esquina inferior derecha renglon-columna
  int 10h            ; llamada a la interrupcion de video BIOS

  ;posicion del cursor
  mov ah,02
  mov dx,0402h
  mov bh,00
  int 10h

  mov ah,09          ;Despliega mensaje en pantalla
  mov dx,offset msj2
  int 21h

  mov bx,0000h
  lea SI,cadena1 ; Coloca en SI la direccion del primer espacio de la cadena1
  mov cx,50      ; inicio el registro del contador en 50 
  
regresa:
  mov ah,07h ; Recoje por teclado un carater y lo coloca en AL sin eco en pantalla
  int 21h    ; ejecuta la funcion del DOS    
  cmp al,13  ; Compara al con enter
  je termina ; salta solo si la tecla oprimida es enter
  mov [SI],al; AL se coloca en la direccion a la que apunta SI
  inc SI     ; Inc SI
  inc bx     ; Inc el contador
  mov dl,'*' ; coloca en dl un * para que aparezca en pantalla
  mov ah,02h ; Funcion de mostrar por pantalla el contenido de dl
  int 21h    ; ejecuta la funcion del DOS
  loop regresa ; En contenido de CX disminuye en 1 y salta a regresa

 
 termina:
  
  mov cont,bx
  
 mov ah,02
 mov dx,0702h
 mov bh,00
 int 10h      ; Posiciona cursor

 mov ah,09    ; Escribir cadena
 mov dx,offset msj1
 int 21h
 
 mov ah,02
 mov dx,071eh
 mov bh,00
 int 10h      ;Posiciona cursor
 
 
 mov ax,cont

  aam			; Hace un ajuste decimal: AH = decenas, AL = unidades

  mov bx,ax

     
 mov 	ah,2		; Opcion para utilizar el display en la interrupcion 21h
 mov 	dl,bh		; las decenas se cargan en DL
 add 	dl,30h		; se le suma un 30h al numero para mostrar el caracter
 int 	21h		; llamada a utilizar display, se muestra caracter en DL
    
 mov 	dl,bl		; las unidades se cargan en DL
 add 	dl,30h		; se repite el proceso anterior
 int 	21h

 mov	ah,1		; Espera tecla por medio del DOS
 int 21h 


  

mov ah,4ch
int 21h      ;cierre del programa
end


;black       (0)
;blue        (1)
;green       (2)
;cyan        (3)
;red         (4)
;magenta     (5)
;brown       (6)
;white       (7)  
;grey        (8)






