;Esta espiral decrementa por cada linea impresa.
.MODEL SMALL
.STACK 100H
.DATA
    menu_titulo db "Ingrese 1 para iniciar el programa o 0 para salir del programa:$"
    menu_salida db "Esta seguro de salir del programa?(Y/N):$"
    
    
    
    simbolo db 03 
    enter db 0AH,0DH,'$'
    mensaje db "Ingrese un numero (use dos digitos) menor de 21:$"
    digito1 db "$"
    digito2 db "$"
    numero db "$"
    mayor_21 db "El numero ingresado es mayor que 21!$"
    contador db "$"
    coordenada_x db "$"
    coordenada_y db "$" 
    
    mensaje_limpiar db "Presione una tecla para limpiar el espiral:$"
    numero_aux db "$"

.CODE
inicio:
    mov ax,@data
    mov ds,ax
    
;4. Menu de inicio
menu:
    call clear()
    lea dx,menu_titulo
    call println()
    call getchr()

comparar_menu:
    cmp al,00h
    je salida
    cmp al,01H
    je programa
salida:
    call espacio()
    lea dx,menu_salida
    call println()
    call getascii()
    cmp al,59h
    je halt
    cmp al,4EH
    je menu
    jmp salida
    


programa:
    call clear() 
;1. Capturar dos digitos, menor de 21.
    lea dx,mensaje
    call println()
    
    call getchr()
    mov digito1,al
    
    call getchr() 
    mov digito2,al

    mov ah,digito1
    mov al,digito2
    
    AAD                 ;Se convierte el numero a su equivalente 
                        ;Hexadecimal
    
    mov numero,al       ;Guardo el numero en una variable
    mov numero_aux,al   ;Guardo el numero en una variable auxiliar
                         
    call getchr()
    
    call maximo()       ;Metodo para asegurar que el numero sea menor o igual que 21.
    
                        ;Posicionar el cursor

;2.Imprimir espiral
    
    
    mov coordenada_x,1Fh
    mov coordenada_y,03h
     
    call goto()
        
    call draw() 
              
    call getchr()
     


;3. Limpiar espiral, siguiendo el mismo orden que la formo

    mov coordenada_x,00H
    mov coordenada_y,01h 
    call goto()
    
    lea dx,mensaje_limpiar
    call println() 
    call getchr()

    mov simbolo,00h
    
    mov coordenada_x,1Fh
    mov coordenada_y,03h
        
    call goto()
    
    mov cl,numero_aux
    mov numero,cl
    
    call draw()
    
    jmp menu

        
    
    
halt:
    mov ah,4ch
    int 21h  
;***** METODOS *****
clear() proc
    mov ah,00h
    mov al,03h
    int 10h
    ret
endp
getascii() proc
    mov ah,01h
    int 21h
    ret
endp    
    
espacio() proc
    lea dx,enter
    call println()
    ret
endp

println() proc
    mov ah,09h
    int 21h
    ret
endp


getchr() proc 
    mov ah,01h
    int 21h
    sub al,30h
    ret
endp

maximo() proc
    jmp compara_maximo
    
    menor_21:
       
    ret                 
endp

compara_maximo:
    cmp numero,15h      ;Se compara el numero con el maximo en el enunciado
    jle menor_21
    jmp mayor
    
mayor:
    call espacio()
    lea dx,mayor_21
    call println()
    call getchr()
          
    jmp programa

goto() proc 
    mov ah,02h
    mov dh,coordenada_y
    mov dl,coordenada_x
    int 10h  
    ret
endp
;Metodos para imprimir espiral
draw() proc
    jmp espiral
    fin_espiral:
    ret
    endp


espiral:
    
    cmp numero,00H              ;Condicional de salida
    jle fin_espiral    


    mov dl,numero
    mov contador,dl
   
    
    jmp imprimir_linea_derecha
    
    fin_linea_derecha:
    
    dec numero
    cmp numero,00H              ;Condicional de salida
    jle fin_espiral

;***********************************************
    
    cmp numero,01h              ;Condicional para imprimir el ultimo punto
    je  llenar_columna_abajo  
    
  
    ;dec coordenada_x
    dec coordenada_y
    
    mov dl,numero               
    mov contador,dl
    
    jmp imprimir_columna_abajo
    
    fin_columna_abajo:
    
    dec numero
    cmp numero,00H              ;Condicional de salida
    
    jle  fin_espiral
    
;***************************************    
    cmp numero,01h              ;Condicional para imprimir el ultimo punto
    je  llenar_linea_izquierda  
    
      
    
    inc coordenada_x
    ;dec coordenada_y
    
    mov dl,numero
    mov contador,dl
    
    jmp imprimir_linea_izquierda
    
    fin_linea_izquierda:
    
    dec numero
    cmp numero,00H              ;Condicional de salida
    jle  fin_espiral
    
;**************************************
    
    cmp numero,01h              ;Condicional para imprimir el ultimo punto
    je  llenar_columna_arriba  
            
    
    ;inc coordenada_x
    inc coordenada_y            ;Incrementa para que cuando vuelva
                                ;a imprimir caiga en la misma posicion
    mov dl,numero
    mov contador,dl 
    
    jmp imprimir_columna_arriba
    fin_columna_arriba:
      
    dec numero
    cmp numero,00H              ;Condicional de salida 
    jle  fin_espiral                                   

;****************************************    
    cmp numero,01h              ;Condicional para imprimir el ultimo punto
    je  llenar_linea_derecha  
    
    
    dec coordenada_x
    
    mov dl,numero
    mov contador,dl
    
    jmp espiral
    
imprimir_simbolo proc
    mov dl,simbolo          ;Mover un *
    mov ah,02h
    int 21h
    ret
endp


imprimir_linea_derecha:         ;Imprimir una linea horizontal
                                ;hacia la derecha
    inc coordenada_x            
    dec contador
                                        
    call goto()  
    call imprimir_simbolo
    
 
    
    jnz imprimir_linea_derecha
    jmp fin_linea_derecha
        


imprimir_columna_abajo:         ;Imprimir una linea horizontal
                                ;hacia la derecha        
    
    inc coordenada_y
    dec contador
    
    call goto()  
    call imprimir_simbolo
    
        
    
    jnz imprimir_columna_abajo
    jmp fin_columna_abajo 
    
imprimir_linea_izquierda:       ;Imprimir una linea horizontal
                                ;hacia la derecha        
    dec coordenada_x
    dec contador 
    
    call goto()  
    call imprimir_simbolo
    
    jnz imprimir_linea_izquierda
    jmp fin_linea_izquierda

imprimir_columna_arriba:         ;Imprimir una linea horizontal
                                 ;hacia la derecha
    dec coordenada_y
    dec contador                         
    
    call goto()  
    call imprimir_simbolo
           
    jnz imprimir_columna_arriba
    jmp fin_columna_arriba
    
llenar_columna_abajo:           ;Estos metodos saltan el ajuste final de 
    mov dl,numero               ;las coordenadas
    mov contador,dl
    jmp imprimir_columna_abajo
llenar_linea_izquierda:
    mov dl,numero
    mov contador,dl
    jmp imprimir_linea_izquierda
llenar_columna_arriba:
    mov dl,numero
    mov contador,dl
    jmp imprimir_columna_arriba
llenar_linea_derecha:
    mov dl,numero
    mov contador,dl
    jmp imprimir_linea_derecha
end



