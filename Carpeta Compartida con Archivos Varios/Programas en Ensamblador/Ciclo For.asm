

.model small

.stack 100h ; pila de 256 bytes

.data

    msg db '&','$'  
    msg1 db 'Digite un numero mayor a cero', '$'
       
.code 

   mov ax,@data ; carga la direccion en memoria del segmento de datos
   mov ds,ax    
  
Inicio:
   
   mov ah,1
   int 21h ; carga en AL el dato del teclado  
   cmp al, 30h
   je error
   
   sub al,30h ; convertir de ascii a binario 
   mov cl,al
   mov ch,00
    
ciclo:
 
   lea dx, msg    ;  igual  mov dx, offset msg
   mov ah,09
   int 21h 
   ;dec cl   ; decrementa en 1
   ;jnz ciclo      ; salto condicional si no es cero el resultado
   loop ciclo     ; loop trabaja con CX y decrementa/pregunta/salta
                                                                
    
   mov ah,4ch
   int 21h 
   
error:
    lea dx, msg1
    mov ah,09 
    int 21h
    jmp inicio
    
end