include macros.txt ;Se incluye a la libreria con los macros

.MODEL SMALL
.STACK 100h
.DATA
    informacion db "Hola, eso se imprime con un macro$"
.CODE  
inicio:                                      
    mov ax,@data
    mov ds,ax  
programa:
    println() informacion   ;Llama al macro dentro del .txt y le pasa el parametro
           
halt:    
    mov ah,4ch
    int 21h
end