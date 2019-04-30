;***************************** EJERCICIO # 2 **********************************
;                        JEREMY ZELAYA RODRIGUEZ
.MODEL SMALL
.STACK 100H
.DATA 
     espacio db 0AH,0DH,'$'     ;Arreglo base de numeros
     
     caracteres db "$"
               db "$"
               db "$"
               db "$"
               db "$"
               db "$"
               db "$"
               db "$"
               db "$"
               db "$" 
    mensaje db "Ingrese un caracter:$"
    
     numeros db "$"             ;Arreglo de numeros
             db "$"
             db "$"
             db "$"
             db "$"
             db "$"
             db "$"
             db "$"
             db "$"
             
     letras  db "$"             ;Arreglo de letras
             db "$"
             db "$"
             db "$"
             db "$"
             db "$"
             db "$"
             db "$"
             db "$"
               

    contador db 0Ah
    
    contador_numeros dw 0000H,"$"
    contador_letras dw 0000H,"$"
    
    mensaje_numeros db "Numeros:$"
    mensaje_letras db "Letras:$"
    
    cantidad db "Cantidad:$"

.CODE
inicio:
    mov ax,@data
    mov ds,ax 
    
programa:

;1. Permitir a un usuario ingresar 10 caracteres alfanumericos desde teclado,
;a un arreglo de espacios en memoria 


;1.1 CAPTURA DE LOS 10 NUMEROS EN UN ARREGLO DE MEMORIA
capturar_numeros:

    lea dx,mensaje          ;Imprimir el mensaje   
    call println()
    call readkey()          ;Capturar numero 1 en AL
    mov [caracteres],AL     ;Mover el numero a una posicion del arreglo
    call enter()            ;Imprime un ENTER
    
    lea dx,mensaje          ;Imprimir el mensaje   
    call println()
    call readkey()          ;Capturar numero 2 en AL
    mov [caracteres+1],AL   ;Mover el numero a una posicion del arreglo
    call enter() 
    
    lea dx,mensaje          ;Imprimir el mensaje   
    call println()
    call readkey()          ;Capturar numero 3 en AL
    mov [caracteres+2],AL   ;Mover el numero a una posicion del arreglo
    call enter()
    
    lea dx,mensaje          ;Imprimir el mensaje   
    call println()
    call readkey()          ;Capturar numero 4 en AL
    mov [caracteres+3],AL   ;Mover el numero a una posicion del arreglo
    call enter()
    
    lea dx,mensaje          ;Imprimir el mensaje   
    call println()
    call readkey()          ;Capturar numero 5 en AL
    mov [caracteres+4],AL   ;Mover el numero a una posicion del arreglo
    call enter()
    
    lea dx,mensaje          ;Imprimir el mensaje   
    call println()
    call readkey()          ;Capturar numero 6 en AL
    mov [caracteres+5],AL   ;Mover el numero a una posicion del arreglo
    call enter()
    
    lea dx,mensaje          ;Imprimir el mensaje   
    call println()
    call readkey()          ;Capturar numero 7 en AL
    mov [caracteres+6],AL   ;Mover el numero a una posicion del arreglo
    call enter()
    
    lea dx,mensaje          ;Imprimir el mensaje   
    call println()
    call readkey()          ;Capturar numero 8 en AL
    mov [caracteres+7],AL   ;Mover el numero a una posicion del arreglo
    call enter()
    
    lea dx,mensaje          ;Imprimir el mensaje   
    call println()
    call readkey()          ;Capturar numero 9 en AL
    mov [caracteres+8],AL   ;Mover el numero a una posicion del arreglo
    call enter()
    
    lea dx,mensaje          ;Imprimir el mensaje   
    call println()
    call readkey()          ;Capturar numero 10 en AL
    mov [caracteres+9],AL   ;Mover el numero a una posicion del arreglo
    call enter()    

;2.Colocar en 2 arreglos las letras y los numeros
    
   ;BASE MAS INDICE
   
   call readkey()
   comparacion_numeros:
   xor cx,cx
   mov cl,[caracteres]
   call compara_numero
   call compara_letra
   
   mov cl,[caracteres+1]
   call compara_numero
   call compara_letra
   
   mov cl,[caracteres+2]
   call compara_numero
   call compara_letra
   
   mov cl,[caracteres+3]
   call compara_numero
   call compara_letra 
   
   mov cl,[caracteres+4]
   call compara_numero
   call compara_letra 
   
   mov cl,[caracteres+5]
   call compara_numero 
   
   mov cl,[caracteres+6]
   call compara_numero
   call compara_letra
   
   mov cl,[caracteres+7]
   call compara_numero
   call compara_letra 
   
   mov cl,[caracteres+8]
   call compara_numero
   call compara_letra
   
   mov cl,[caracteres+9]
   call compara_numero
   call compara_letra

;3. Imprimir los contenidos y cantidad


    call imprimir_numero()
    
    lea dx,espacio
    call println()

    call imprimir_letras()

    
  
      
halt:
    mov ah,4ch
    int 21h
;********** METODOS Y ETIQUETAS DE SALTO ***********

;************* COMPARACION CONTRA NUMEROS ***********************
compara_numero proc         ;Metodo para comparar con el rango de 0 a 9
    
    jmp compara_numero_0    ;Puede hacer saltos en un metodo?
    
    fin_compara_numero:     ;Puedo tener etiquetas en metodos? 
    ret
endp

 
compara_numero_0:
    cmp cx,0030h              ;Compara con el hex del num 0
    jge compara_numero_9
    jmp fin_compara_numero

   
compara_numero_9:
    cmp cx,0039H               ;Compara con el hex del num 9
    jle agregar_numero
    jmp fin_compara_numero


agregar_numero:
    mov si, contador_numeros
    lea bx,numeros             ;Mover el puntero del arreglo de numeros a bx
    mov [bx+si],cl      ;Moverle al espacio apuntado por bx+si, el dato
    inc si                     ;Incremetar para apuntar al siguiente 
    mov contador_numeros,si
    xor si,si
    jmp fin_compara_numero
    
;************************ COMPARACION CONTRA LETRAS *********************

compara_letra proc              ;Metodo para comparar con el rango de letras de a - z
    
    jmp compara_letra_a         
    
    fin_compara_letra:           
    ret
endp

 
compara_letra_a:
    cmp cx,0061h                ;Compara con el hex de la letra a
    jge compara_letra_z
    jmp fin_compara_letra

   
compara_letra_z:
    cmp cx,007AH                ;Compara con el hex de la letra z
    jle agregar_letra
    jmp fin_compara_letra


agregar_letra:
    mov si,contador_letras
    lea bx,letras               ;Mover el puntero del arreglo de numeros a bx
    mov [bx+si],cl              ;Moverle al espacio apuntado por bx+si, el dato.
    inc si                      ;Incremetar para apuntar al siguiente
    mov contador_letras,si
    xor si,si
    jmp fin_compara_letra    
    
     call readkey()
     call espacio()
     
imprimir_numero() proc
     lea dx,mensaje_numeros
     call println()    

;    xor contador_numeros,contador_numeros       ;Limpiar al contador
;    xor si,si                                   ;Limpiar si
    
     mov dl,[numeros]                               ;Mover la posicion de memoria del array a CX
     call getchr()
     
     mov dl,[numeros+1]                               ;Mover la posicion de memoria del array a CX
     call getchr()
     
     mov dl,[numeros+2]                               ;Mover la posicion de memoria del array a CX
     call getchr()
     
     mov dl,[numeros+3]                              
     call getchr()
     
     mov dl,[numeros+4]                               
     call getchr()
     
     mov dl,[numeros+5]                               
     call getchr()
     
     mov dl,[numeros+6]                               
     call getchr()
     
     mov dl,[numeros+7]                              
     call getchr()
     
     mov dl,[numeros+8]                               
     call getchr() 
     
     mov dl,[numeros+9]                               
     call getchr()
     
     
     lea dx,cantidad
     call println()
     
     add contador_numeros,30h
     lea dx,contador_numeros
          
     call println()
        
     
;    lea bx,[cx+si]                              ;Mover la posicion de memoria a bx
;    call println()                              ;Imprimir el contendo
        
    ret
endp

imprimir_letras() proc 
    
     lea dx,mensaje_letras
     call println()    

;    xor contador_numeros,contador_numeros       ;Limpiar al contador
;    xor si,si                                   ;Limpiar si
    
     mov dl,[letras]                               ;Mover la posicion de memoria del array a CX
     call getchr()
     
     mov dl,[letras+1]                               ;Mover la posicion de memoria del array a CX
     call getchr()
     
     mov dl,[letras+2]                               ;Mover la posicion de memoria del array a CX
     call getchr()
     
     mov dl,[letras+3]                              
     call getchr()
     
     mov dl,[letras+4]                               
     call getchr()
     
     mov dl,[letras+5]                               
     call getchr()
     
     mov dl,[letras+6]                               
     call getchr()
     
     mov dl,[letras+7]                              
     call getchr()
     
     mov dl,[letras+8]                               
     call getchr() 
     
     mov dl,[letras+9]                               
     call getchr()   
     
     lea dx,cantidad
     call println()
     
     add contador_letras,30h
     lea dx,contador_letras
          
     call println()
     
ret
endp 

recorrer_lista:

getchr_especial() proc
    mov ah,02h
    add dl,30h
    int 21h
    ret
endp


       
println() proc 
    mov ah,09h
    int 21h
ret
endp
getchr() proc
    mov ah,02h
    int 21h
    ret
endp
readkey() proc
    mov ah,01h
    int 21h
    ret
endp
enter() proc
    lea dx,espacio
    call println()
    ret
endp
end
