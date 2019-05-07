; multi-segment executable file template.

data segment    ; Declarar previo todo lo que se va a utilizar antes de utilizarlo abajo.
    ; add your data here!  }
    otro dw 6  ; Desplaza 2 lugares de la memoria
    pkey db "press any key...$" ; Identificador por nombre   
    msg db " Hola!!$"
    msj db " Jahaira Morales Vargas...!!!$" 
    
ends

stack segment
    dw   128  dup(0)  ;Tenemos 128 de 2 bits y todas las posiciones contiene cero "0", preparación de pila.
ends

code segment
start:
; set segment registers:
    mov ax, data         ;Inicializar el data
    mov ds, ax      ;Carga de la posición del segmento de datos en memoria en el registro os
    mov es, ax    ;Carga el segmento extra
               
    mov dx,offset pkey
    mov ah,09
    int 21h
    
    
    mov dx,offset msg
    mov ah,09 ; No es necesario ponerla 
    int 21h   
    
    mov dx,offset msj
    int 21h       
    
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.
