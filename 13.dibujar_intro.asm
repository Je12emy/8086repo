.MODEL SMALL
.STACK 110H
.DATA
    x dw "$"
    y dw "$"
    contador db "$"
    length dw "$"
    

.CODE
inicio:    
    mov ax,@data
    mov ds,ax
programa:
    call setup()    
    mov x,01h
    mov y,02h
    mov length,0013eh  
    
    call drawline()
    
halt:
    mov ah,4ch
    int 21h
;*********** METODOS *************
setup proc      ;Set Up de pantalla para modo grafico
    
    mov ah, 0   ; set display mode function.
    mov al, 13h ; mode 13h = 320x200 pixels, 256 colors.
    int 10h     ; set it
    
    ret
    endp

drawline() proc
    
    loop_dibujo:
    
    call drawpixel()
    inc x
    dec length   
    jnz loop_dibujo
    
    ret
endp
drawpixel() proc
    mov cx, x   ; column
    mov dx, y   ; row
    mov al, 15  ; white
    mov ah, 0ch ; put pixel
    int 10h
    ret
endp
end
