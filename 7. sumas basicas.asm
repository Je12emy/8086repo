.MODEL SMALL
.STACK 100H
.DATA                
;***** ESTO ES UN ARRAY *****
    array   db  10
            db  20
            db  40
            db  15  
;***** ESTO ES UN ARRAY ***** 

    resultado db 0
    mensaje db "El resultado es:$" 
    
.CODE
    inicio:
    mov ax,@data
    mov ds,ax
    
    programa:
    mov al,[array]      ;Apuntar a distintos indices del array.
    mov bl,[array+1]
    
    add al,bl           ;Suma ambos registro, el resultado queda en AL  
                        ;add [destino],[operando] suma el operando en el destino.
    mov resultado, al   ;Mueve la sumatoria a resultado
    AAM                 ;Covierte el numero de HEX a BC. 
                        ;Queda en AX el resultado AX; AH: Decenas y AL: Unidades
    mov cx,ax           ;Mueve el resultado a CX, sigue el mismo almacenamiento original
    
    lea dx,mensaje
    call println()
    
    mov dl,ch           ;Mueve las decenas a DL para ser impresas.
    call getchr()       ;Imprime el caracter el DL,
                        
    mov dl,cl           ;Mueve las unidades a DL para ser impresas,
    call getchr()       ;Imprime el caracter en DL,
    
    ;xor cx,ax
    
    call readkey()
    call clear()
    
    ; Repetir el mismo proceso
    
    mov al,[array+2]
    mov bl,[array+3]
    
    add al,bl
    
    mov resultado,al
    AAM
     
    mov cx,ax
    
    lea dx,mensaje
    call println()
    
    mov dl,ch
    call getchr()
    
    mov dl,cl
    call getchr()
    call readkey()
        
    halt:
    mov ah,4ch
    int 21h

println() proc 
    mov ah,09h
    int 21h
    ret
endp  

getchr() proc   ;Este metodo imprime el contenido en DL
    mov ah,02h
    add dl,30h  ;Sumar para obtener el numero real
    int 21h
    ret   
endp

readkey() proc  ;Este metodo espera un input por teclado
    mov ah, 01h
    int 21h
    ret
endp


clear() proc
    mov ah,00h
    mov al,03h
    int 10h 
    ret
endp

end 
