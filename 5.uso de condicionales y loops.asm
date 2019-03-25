;*********** METODO PARA IMPRIMIR UNA LETRA N CANTIDAD DE VECES EN N FILAS ***********
 

.model small
.stack 100h
.data
    mensaje1 db "Preciona una tecla:$"
    pregunta db "Cuantas veces desea imprimir esa tecla?:$"
    pregunta2 db "En cuantas filas desea imprimir esa tecla?:$" 
    aviso db "Ingreso 0, terminando el programa...$"
    tecla db "$"
    numero db "$"
    num_filas db "$"
    auxiliar db "$"
    espacio db 0AH,0DH,'$'
    
    coordenada_x db "$"
    coordenada_y db "$"
    
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
    
    call compara()
    
    mov auxiliar, AL
    
    sub numero,30H           ;Quito el ascii
    sub auxiliar, 30H
    call clear()
    
    lea dx,pregunta2
    call println()
    call readline()
    
    mov num_filas,AL
    
    
    sub num_filas,30h        ;Remover el ascii
    call clear()
       
    call imprimir_filas()

    halt:
    mov ah,4ch
    int 21h
    
   
   
;******** METODOS ********

println() proc              ;Metodo generico para imprimir      
    mov ah,09h
    int 21h
    ret
endp  

printtecla() proc           ;Metodo para imprimir la tecla. 
    mov ah,02h              ;El servicio 02h imprime el contenido en DL, eso lo hace mas optimo para este caso.
    int 21h
    ret
    endp

readline() proc             ;NOTA: Este metodo guarda la entrada por teclado en AL.
    mov ah,01h
    int 21h
    ret        
endp

enter() proc                ;Metodo generico para crear un enter.
    lea dx,espacio
    mov ah,09h
    int 21h
    ret
endp

clear() proc                ;Metodo generico para limpiar la pantalla
    mov ah,00h
    mov al,03h
    int 10h
    ret
endp
       
imprimir_filas() proc           ;Metodo para imprimir n cantidad de filas 
     
    call imprimir_n_cantidad()  ;Imprimir n cantidad de letras
    call enter()
    
    mov al,auxiliar
    mov numero, al 
        
    dec num_filas
    JNZ imprimir_filas()
    ret  
endp 

imprimir_n_cantidad() proc ;Metodo para imprimir la tecla n cantidad de veces.
    
    mov  dl,tecla          ;Mueve tecla a DL para prepararla para printtecla().
    call printtecla()
    
    dec numero
    JNZ imprimir_n_cantidad()
    ret        
endp
compara() proc
    cmp numero, 30h         ;Compara numero con 30h(el hex para el numero 0).
    je igual_cero()         ;Si es verdadero(numero==0)
    ret                     ;Si no es igual a 0, vuelve a donde lo llamaron y continua el programa.
endp
igual_cero() proc           ;Metodo para terminar el programa
    call clear()
    call centrar()
    lea dx, aviso
    call println()
    jmp halt                ;Salta a halt para parar la ejecucion
endp

centrar() proc              ;Metodo para posicionar el cursor en (x,y) posicion.
    mov coordenada_x,15h
    mov coordenada_y, 25h
    
    mov ah,02h
    mov dh, coordenada_x
    mov dl, coordenada_y
    int 10h
    
    ret
endp
end
