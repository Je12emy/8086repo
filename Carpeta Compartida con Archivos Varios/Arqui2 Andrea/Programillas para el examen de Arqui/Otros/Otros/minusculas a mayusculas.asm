
name "upper"

org 100h


jmp start:


string db 20, 22 dup('?') ;buffer

new_line db 0Dh,0Ah, '$'  ; nueva linea de codigo

start:


lea dx, string

mov ah, 0ah
int 21h

mov bx, dx
mov ah, 0
mov al, ds:[bx+1]
add bx, ax ; punto del fin de la cadena.

mov byte ptr [bx+2], '$' ; poner signo dolar final de la cadena.


lea dx, new_line
mov ah, 09h
int 21h


lea bx, string

mov ch, 0
mov cl, [bx+1] ; obtiene el tamaño de la cadena

jcxz null ; la cadena esta vacia

add bx, 2 ; saltar caracteres de control

upper_case:

;checkear si una letra es minuscula
cmp byte ptr [bx], 'a'
jb ok
cmp byte ptr [bx], 'z'
ja ok

;convertir a mayusc
and byte ptr [bx], 11011111b

ok:
inc bx ; ;siguiente caracter
loop upper_case



lea dx, string+2
mov ah, 09h
int 21h
 

mov ah, 0
int 16h 
 
 
null:
ret  
 
 
 
 