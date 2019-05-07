.model small
.stack 100h
.data
       
x db ?
y db ?
carac db '?'
aux db  ?
ancho db ?
largo db ?
str db 'Digite un caracter','$'
str1 db 0AH,0DH,'Digite las dimensiones','$'
str2 db 0AH,0DH,'Digite el Ancho: ','$'
str3 db 0AH,0DH,'Digite el Largo: ','$' 
ENTER   DB 0AH,0DH,'$' 

.code

mov ax,@data
mov ds,ax

mov ah,0
mov al,3
int 10h

lea dx,str
call mensaje

mov ah,01h
int 21h
mov carac,al

lea dx,str1
call mensaje
call Ancho_matrix
call Largo_matrix
mov ah,0
mov al,3
int 10h

mov x,5
mov y,5
call cursor
mov dl,carac
mov al,largo
mov ah,00
push ax

for1:
mov cl,ancho 

    for2:
    call men
    dec cl
    jnz for2
push dx
add y,1
call cursor
pop dx
pop ax
dec ax
push ax
jnz for1

mov x,25
mov y,5      
call cursor
mov dl, carac
mov al, largo
mov ah, 00
push ax


mov ah,4ch
int 21h 

Ancho_matrix proc
 lea dx,str2
 call mensaje
 mov ah,01h 
 int 21h
 sub al,30h
 
 mov bl,10
 mul bl
 mov aux,al
 
 mov ah,01h   
   int 21h      
   sub al,30h 
 
add aux,al
mov bl,aux
mov ancho,bl
ret
endp

Largo_matrix proc
lea dx,str3
call mensaje
mov ah,01h
int 21h
sub al,30h

mov bl,10
mul bl
mov aux,al

mov ah,01h
int 21h
sub al,30h

add aux,al
mov bl,aux
mov largo,bl
ret
endp

mensaje proc
mov ah,9
int 21h
ret
endp

cursor proc
mov ah,2
mov dl,x
mov dh,y
int 10h
ret
endp

men proc
    mov ah,2
    int 21h
    ret
endp
end
