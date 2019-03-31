;*** PROGRAMA PARA OBTENER EL ASCII DE UN CARACTER ***
;NOTA: ESTE METODO SOLO FUNCIONA CON UN ASCII DE 2 NUMEROS OSEA UN ASCII MAYOR A 99 NO FUNCIONARA
.MODEL SMALL
.STACK 100H
.DATA
    pregunta db "Ingrese un caracter:$"
    respuesta db "El codigo ASCII en BCD de ese caracter es:$"
    caracter db "$"
    caracter2 db "$"

.CODE              
    inicio:
    mov ax,@data
    mov ds,ax  
    
    programa:
    
    lea dx,pregunta  
    
    call println()
    
    call readkey()      ;El caracter queda en AL como HEX
    
    AAM                 ;Convertir el caracter en BCD DH: Decimas y AL: Unidades
    
    mov caracter,ah     ;Muevo el caracter a una variable, inicio con ah pues lo ocupo para servicio
    mov caracter2, al   ;Muevo la otra parte caracter a otra variable
                        ;Revice el registro AX si no lo logra entender, el BCD se ve dentro de el
    call clear()
    
    lea dx,respuesta
    call println()
    
    mov dl,caracter     ;Muevo a DL el caracter y asi usar getchr()
    
    call getchr()       ;Imprime le caracter
    
    
    
    mov dl,caracter2
    call getchr()
    
    call readkey()
    
     
    halt:
    mov ah,4ch
    int 21h
;*** METODOS ***
println() proc 
    mov ah,09h
    int 21h
    ret
endp  

getchr() proc   ;Este metodo imprime el contenido en DL
    mov ah,02h
    add dl,30h  ;Sumar para obtener el numero real BCD
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
