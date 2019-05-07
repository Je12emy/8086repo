

.model small

.stack 100h ; pila de 256 bytes

.data

    msg db '&','$'  
       
.code 

   mov ax,@data ; carga la direccion en memoria del segmento de datos
   mov ds,ax    
  
Inicio:
   
   mov ah,1
   int 21h ; carga en AL el dato del teclado  
   sub al,30h ; convertir de ascii a binario 
   mov ch,al
   
   mov ah,1
   int 21h ; carga en AL el dato del teclado  
   sub al,30h ; convertir de ascii a binario 
   mov cl,al  
   
   mov ax,cx
   
   aad    ; convierte de BCD a binario natural
   
   mov cx,ax      ;
    
ciclo:
 
   lea dx, msg    ;  igual  mov dx, offset msg
   mov ah,09
   int 21h 
   loop ciclo     ; loop trabaja con CX y decrementa/pregunta/salta
                                                                
    
   mov ah,4ch
   int 21h 
   
    
end