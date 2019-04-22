;Programa para obtener el largo de un string de texto.
;funciona hasta nueve caracteres
.model small
.stack 100h
.data
    enter db 0AH,0DH,'$' 
    msg db "Ingrese una cadena de texto:$"
    cadena1 db 50,0,50 dup(?)                   ;primer byte: tamaño maximo, segundo byte
                                                ;tamaño de lo ingresado, tercer byte
                                                ;contenido del mensaje
.code                                                                 
inicio:    
    mov ax,@data
    mov ds,ax
    
    
    mov ah,09h
    lea dx, msg
    int 21h
    
    mov ah,0ah                                  ;Leer un string de caracteres, queda en dx -> cadena1
    lea dx,cadena1
    int 21h
    
    cld                                         ;Ajustar el direction flag para leer de forma ascendente
    
    mov si,offset cadena1 + 1                   ;Mover largo (2do byte) del mensaje ingresado a si
    lodsb                                       ;extraer el byte del mensaje hacia AL
    
    add al,30h                                  ;agregar el ascii
      
    mov dl,al                                   ;Metodo getchr() para sacar por pantalla el contenido
    mov ah,02h                                  ;en dl
    int 21h
    
       
    
halt:
    mov ah,4ch
    int 21h    
    
    
    
