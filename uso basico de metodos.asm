.model small
.stack 100h
.data
    mensaje db "Este mensaje fue impreso con un metodo.$"
    mensaje2 db "Precione una tecla para terminar el programa:$"
    enter db 0AH,0DH,'$'            ;Se imprime esto para hacer un ENTER
.code
    inicio:                         ;Una forma de almacenar codigo, siempre sera ejecutado y puede ser llamado.
    mov ax,@data
    mov ds,ax
    
    programa:
    lea dx,mensaje
    call println()                  ;Llama al metodo println()
    
    call espacio                    ;Llama al metodo enter()
    
    lea dx,mensaje2
      
    call println()
    call readline()                 ;Llama al metodo readline()
    call clear()                    ;Llama al metodo clear()
    
    
    halt:
    mov ah,4CH
    int 21h


;**************** METODOS **************** 
                                    
println() PROC                      ;Funcion generica para imprimir un mensaje.
    mov ah,09h                      ;Cargar el servicio 9 en AH
    int 21h                    
    ret                             ;La palabra reservada RET se usa para volver al punto donde se llamo al metodo
ENDP

readline() PROC                     ;Funcion generica para leer una linea.
    mov ah,01h
    int 21h
    ret                             ;NOTA: Este metodo guarda la entrada por teclado en AL
ENDP

clear() PROC                        ;Fucion generica para limpiar la pantalla.
    mov ah,00h
    mov al,03h                                                                
    int 10h
    ret
ENDP
espacio PROC
    mov ah,09h
    lea dx,enter
    int 21h
    ret    
ENDP

end