;1. Un cuadro que se mueva en un plano.
;2. Ingresar las coordenadas de inicio del cuadrado.
.model small
.stack 100h
.data 
    salir dw "Saliendo...$"
    msg_largo dw "Ingrese el largo de la figura:$"
    msg_ancho dw "Ingrese el ancho de la figura:$"
    input_with dw "$"
    input_length dw "$"
    x dw "$"
    y dw "$"
    xx dw "$"
    yy dw "$"
    length dw "$"
    width dw "$"
    length_aux dw "$"
    x_aux dw "$"
    xx_aux dw "$"
    
    opcion1 db "[1] Iniciar el juego.$"
    opcion2 db "[2] Ingresar las coordenadas de inicio.$"
    opcion3 db "[3] Marcar coodenadas de inicio.$"
    opcion4 db "[4] Perseguir mouse.$"
    opcion5 db "[S] Salir.$"
    
    
    
    input db "Ingrese una opcion:|$"
    
    mouse_input db "Haga click derecho en alguna posicion:$"
        
    input_x db "Ingrese la coordenada de X:$"
    input_y db "Ingrese la coordenada de Y:$" 
    
    input_1_x db "$"
    input_2_x db "$"
    input_3_x db "$" 
    
    input_1_y db "$"
    input_2_y db "$"
    input_3_y db "$"
    
    resultado_x dw "$"
    resultado_x_2 dw "$"
    coordenadas_x dw "$"  
    
    resultado_y dw "$"
    resultado_y_2 dw "$" 
    coordenadas_y dw "$"
    
    bandera db "$"
.code
inicio:
    mov ax,@data
    mov ds,ax
menu: 
    mov ah,00h      ;limpiar
    mov al,03h
    int 10h

    mov dh,005h    ;row
    mov dl,013h    ;col
    call goto()
    
    lea dx,opcion1
    call println()
    
    mov dh,008h    ;row
    mov dl,013h    ;col
    call goto()   
    
    lea dx,opcion2
    call println()
    
    mov dh,00bh    ;row
    mov dl,013h    ;col
    call goto()   
    
    lea dx,opcion3
    call println()
    
    mov dh,00eh    ;row
    mov dl,013h    ;col
    call goto()   
    
    lea dx,opcion4
    call println()
    
    mov dh,011h    ;row
    mov dl,013h    ;col
    call goto()   
    
    lea dx,opcion5
    call println()
    
    mov dh,013h    ;row
    mov dl,013h    ;col
    call goto()   
    
    lea dx,input
    call println()
      
    call readkey()
    cmp al,31h
    je programa
    cmp al,32h
    je coordenadas
    cmp al,33h
    je mouse_xy
    cmp al,34h
    je follow
    cmp al,53h
    je halt
    cmp al,73h
    je halt
    jmp halt
    
coordenadas:                    ;Captura las coordenadas de inicio del cuadrado. 
                                ;consiste de 3 unidades
                                
    mov ah,00h
    mov al,03h
    int 10h
    
    mov dh,008h    ;row
    mov dl,013h    ;col
    call goto()
    
    lea dx,input_x
    call println()
    ;Captura de X, 3 unidades. 
    
    call readkey()
    sub al,30h    
    mov input_1_x,al
    
    ;sub al,30h
    call readkey()
    sub al,30h
    mov input_2_x,al
    
    call readkey()
    sub al,30h
    mov input_3_x,al
    
    call unir_coordenadas_x()
    
    
    mov ah,00h
    mov al,03h
    int 10h
    
    xor ax,ax
    
    mov dh,008h    ;row
    mov dl,013h    ;col
    call goto()   
    
    lea dx,input_y
    call println()
    
    call readkey()
    sub al,30h
    mov input_1_y,al
    
    call readkey()
    sub al,30h
    mov input_2_y,al
    
    call readkey()
    sub al,30h
    mov input_3_y,al
    
    call unir_coordenadas_y()
    
    mov ax,coordenadas_x
    mov x,ax
    mov ax,coordenadas_y
    mov y,ax
    
    call setup()
    jmp juego 
mouse_xy:
    call setup()
    mov ax,0h                   ;MouseStatus
    int 33h                                 
    
    lea dx,mouse_input
    mov ah,09h
    int 21h
    
    mov ax,01h                  ;DisplayMouse
    int 33h
    jmp show_mouse_xy                                  
show_mouse_xy:
    mov ax,03h
    int 33h
    cmp bx,01h
    je set_xy_mouse
    jmp show_mouse_xy
set_xy_mouse:
    mov x,cx
    mov y,dx   
    jmp juego
follow:
    call setup()
    mov ax,0h                   ;MouseStatus
    int 33h                                 
    
    mov ax,01h                  ;DisplayMouse
    int 33h
    
    mov bandera,01h
    jmp juego 
    
follow_mouse:
    show_mouse_xy_follow:
;    mov ah,07h                  ;readkey sin echo      
;    int 21h
;    cmp al,71h
;    je menu
    
    
    call clear_cuadrado()
    mov ax,03h
    int 33h
    mov x,cx
    mov y,dx 
    ;call clear_cuadrado()
    jmp juego 
            
    
programa:
;1.1 Dibujar el cuadro
    
    mov x,2Ah                   ;Coordenadas predeterminadas 
    mov y,2Ah                   ;del cuadrado
    call setup()
juego:
    
    
    call character()
    
    dibujo_cuadro:
    
    call drawline()
    call reset_length()
    inc y
    dec width
     
    jnz dibujo_cuadro
    call character()
;1.2 Movimiento del cuadrado
    
    cmp bandera,01h
    je follow_mouse
    jmp movimiento
    
movimiento:
    mov ah,07h                  ;readkey sin echo      
    int 21h                     ;queda capturado en AL
    
    cmp al,77h                  ;w
    je mov_arriba
    cmp al,73h                  ;s
    je mov_abajo
    cmp al,64h                  ;d
    je mov_derecha                
    cmp al,61h                  ;a
    je mov_izquierda
    cmp al,71h
    je menu
     
    jmp halt
    
    
    
    mov_arriba:
    call clear_cuadrado()
    call dec_y()
    jmp dibujo_cuadro 
    
    mov_abajo:
    call clear_cuadrado()       
                                ;La coordenada y queda abajo del cuadrado
                                ;como el cuadrado se dibuja hacia abajo
    jmp dibujo_cuadro           ;con solo llamarlo denuevo da la ilusion de moverse
                                ;hacia abajo
    mov_derecha:
    call clear_cuadrado()
    
    call inc_x()
    call character()
    jmp dibujo_cuadro   
    
    mov_izquierda:
    call clear_cuadrado()
    call dec_x()
    call character()
    jmp dibujo_cuadro              
    

    





    
    
halt:
    mov dh,016h    ;row
    mov dl,013h    ;col
    call goto()
    
    lea dx,salir
    mov ah,09h
    int 21h
    mov ah,4ch
    int 21h
   
    
setup() proc
    mov ah,00h
    mov al,12h
    int 10h
    ret
endp
;Dibujo Normal
drawpixel() proc  
    mov ah,0ch
    mov al,0fh
    mov cx,x
    mov dx,y
    int 10h
    ret
endp
drawline() proc
    loop_line:     
    call drawpixel()
    inc x
    dec length    
    jnz loop_line    
    ret    
endp
;Limpiar el cuadrado anterior

clear_cuadrado() proc
      
    mov dx,x
    mov xx,dx
    
    mov dx,y
    mov yy,dx  
    
    xor dx,dx
    mov dx,yy
    sub dx,width
    mov yy,dx
    xor dx,dx
    
    
    call character()
    clear_dibujo_cuadro:
    
    call clear_drawline()
    call reset_length()
    inc yy
    dec width
     
    jnz clear_dibujo_cuadro
    call character()
    ret
endp 

clear_drawpixel() proc  
    mov ah,0ch
    mov al,00h
    mov cx,xx
    mov dx,yy
    int 10h
    ret
endp
clear_drawline() proc
    clear_loop_line:     
    call clear_drawpixel()
    inc xx
    dec length    
    jnz clear_loop_line    
    ret    
endp


character() proc            ;Parametros del personaje
    
    
    mov length,000Fh 
    
    mov dx,length           ;Guardar en un auxiliar el largo del personaje
    mov length_aux,dx 
    
    mov dx,x                ;Guardar en un auxiliar el largo del personaje
    mov x_aux,dx 
    
    mov dx,xx                ;Guardar en un auxiliar el largo del personaje
    mov xx_aux,dx
    
    mov width,000Fh
    ret
endp
reset_length() proc
    mov dx,length_aux
    mov length,dx 
    
    mov dx,x_aux
    mov x,dx
    
    mov dx,xx_aux
    mov xx,dx
    ret
endp
dec_y() proc                ;Ajustar las coordenadas 2 cuadrantes arriba
    xor dx,dx
    mov dx,y
    sub dx,width
    sub dx,width
    mov y,dx
    xor dx,dx
    ret
endp
inc_y() proc
    inc y
    ret
endp

inc_x() proc                ;Ajustar las coordenadas un cuadrante hacia la derecha
    
    mov dx,y
    sub dx,width
    mov y,dx
    xor dx,dx
    
    xor dx,dx
    mov dx,x
    add dx,width
    mov x,dx
    xor dx,dx
    ret
endp
dec_x() proc                ;Ajustar las coordenadas un cuadrante hacia la derecha
    mov dx,y                
    sub dx,width
    mov y,dx
    xor dx,dx
    
    xor dx,dx
    mov dx,x
    sub dx,width
    mov x,dx
    xor dx,dx  
  ret
endp 
println() proc
    mov ah,09h
    int 21h
    ret
endp



readkey() proc 
    mov ah,01h
    int 21h
    ret
endp


goto() proc
    mov ah,02h
    int 10h
    
    ret
endp
unir_coordenadas_x() proc
    ;call readkey()
    xor ax,ax
    mov ax,100
    mul input_1_x           ;queda en ax el input_1_x * 10.
    mov resultado_x,ax
    
    xor ax,ax
    mov al,10
    mul input_2_x                                       
    mov resultado_x_2, ax
    
    xor ax,ax
    mov ax,resultado_x
    add ax,resultado_x_2
    
    add al,input_3_x
    mov coordenadas_x, ax
    ;add al,30h
    call readkey()
    
    ret
endp
unir_coordenadas_y() proc
    call readkey()
    xor ax,ax
    mov ax,100
    mul input_1_y           ;queda en ax el input_1_x * 10.
    mov resultado_y,ax
    
    xor ax,ax
    mov al,10
    mul input_2_y                                       
    mov resultado_y_2, ax
    
    xor ax,ax
    mov ax,resultado_y
    add ax,resultado_y_2
    
    add al,input_3_y
    mov coordenadas_y, ax
    
    ;add al,30h
    ;call readkey()
    
    ret
endp
cargar_parametros_character proc
    mov ah,00h
    mov al,03h
    int 10h
    
    lea dx,msg_largo
    call readkey()
    
    
    ret
endp


end
