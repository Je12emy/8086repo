.model small
.stack 100h
.data
    mensaje1 db "Preciona una tecla:$"
    pregunta db "Cuantas veces desea imprimir esa tecla?:$"
    tecla db "$"
    numero db "$"
    espacio db 0AH,0DH,'$'
    
.code
    inicio:
    mov ax,@data
    mov ds,ax
    
    lea dx,mensaje1
    call println()           
    call readline()          ;El caracter se guarda en AL
    
    mov tecla,AL
    call clear()
    
    lea dx, pregunta
    call println()           ;El numero se guarda en AL
    call readline()
    
    mov numero,AL
    sub numero,30H           ;Quito el ascii
    call clear()
    

    
    call imprimir_n_cantidad()
    
;    nothing():
;    call enter()

    halt:
    mov ah,4ch
    int 21h
    
   
   
;******** METODOS ********

println() proc  ;Metodo generico para imprimir      
    mov ah,09h
    int 21h
    ret
endp

readline() proc ;NOTA: Este metodo guarda la entrada por teclado en AL.
    mov ah,01h
    int 21h
    ret        
endp

enter() proc    ;Metodo generico para crear un enter.
    lea dx,espacio
    mov ah,09h
    int 21h
    ret
endp

clear() proc    ;Metodo generico para limpiar la pantalla
    mov ah,00h
    mov al,03h
    int 10h
    ret
endp

imprimir_n_cantidad() proc
    lea dx,tecla   
    call println()
    
    dec numero
    JNZ imprimir_n_cantidad()
   ; call nothing()
    ret         ;Se encicla por que cuando retorna vuelve al punto donde lo llamaron.
endp
end
