.model small
.data
 msg db "BIENVENIDOS!$"


.stack 100h
.code                 
    mov ah,02h  ;goTo(x,y)
    mov dh,7    ;Coordenada Y
    mov dl,12   ;Coordenada X 
    int 10h
    
    mov ah,09h  ;print(msg), se imprime sobre la posicion marcado por goTo(x,y)
    lea dx,msg
    int 21h
    
    mov ah, 4ch
    int 21h
end