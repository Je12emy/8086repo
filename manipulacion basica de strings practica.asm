                    ;Practica de manipulacion basica de strings
.model small
.data
    mensaje1 db "Imprimir un mensaje$"   
    mensaje2 db "Esperar e imprimir otro mensaje$"
    mensaje3 db "Imprimir un segundo mensaje$"
.stack 100h
.code
   mov ax,@data
   mov ds,ax
   
   mov ah,09h       ;imprimir(mensaje1)
   lea dx,mensaje1
   int 21H                    
   
   mov ah,01h       ;readline()
   int 21h       
   
   
   mov ah,00h       ;Limpiar()
   mov al,03h
   int 10h
   
   mov ah,09h       ;imprimir(mensaje2)
   lea dx,mensaje2
   int 21h                    
   
   mov ah,01h       ;readline()
   int 21h
   
   mov ah,00h       ;limpiar()
   mov al,03h
   int 10h
   
   mov ah,09h       ;print(mensaje3)
   mov dx, offset mensaje3 ;localizar el offset
   int 21h
   
   mov ah,01h       ;readline()
   int 21h                     
   
   mov ah,00h       ;clear()
   mov al,03h
   int 10h
          
   mov ah, 4CH      ;halt()
   int 21h

end