.model small
.stack 100h
.data

var1 db 'Primer numero','$'

var2 db 'Segundo numero','$'

va db '?'
vb db '?'
x db '?'
y db '?'

.code

mov ax,@data
mov ds,ax

mov ah,0
mov al,3
int 10h

mov x,10
mov y,1
mov ah,2
mov dl,x
mov dh,y
int 10h

lea dx,var1
mov ah,9
int 21h

mov ah,01h
int 21h
mov va,al

mov x,10
mov y,2
mov ah,2
mov dl,x
mov dh,y
int 10h

lea dx,var2
mov ah,9
int 21h

mov ah,01h
int 21h         
mov vb,al

inc va
add vb,02

mov ah,0
mov al,3
int 10h

mov x,5
mov y,5
mov ah,2
mov dl,x
mov dh,y
int 10h

mov dl,va
mov ah,2
int 21h

mov x,15
mov y,5
mov ah,2
mov dl,x
mov dh,y
int 10h

mov dl,vb
mov ah,2
int 21h

mov ah,1
int 21h

mov ah,4ch
int 21h
end