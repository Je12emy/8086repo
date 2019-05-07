.model small
.stack 100h
.data
a dw 0
b dw 0
c dw 0
temp dw 0
zeroizq dw 0
convierte dw 10000,1000,100,10,1
linefeed db 13,10,'$'
inicioprog db 'serie fibonacci Mod sergioor.',13,10,'$'
peticion db 'introdusca numero de elementos de la serie (1-25):','$'
buffer db 32,32,'$'
longitud dw 0
tecla db 0
finprog db 13,10,'fin del programa.',13,10,'$'

.code
inicio:
mov ax,@data
mov ds,ax
mov ah,0
mov al,2
int 10h
mov ah,09h
lea dx,inicioprog
int 21h
mov ah,09h
lea dx,peticion
int 21h
call entrada
mov ah,09h
lea dx,linefeed
int 21h
mov a,0
mov b,1
cmp cx,0
je final
cmp cx,1
je final1
dec cx

ciclo:
mov ax,a
mov bx,b
add ax,bx
mov c,ax
push cx
call printa
pop cx
mov ax,b
mov a,ax
mov ax,c
mov b,ax
loop ciclo
final1:
call printa

final:
mov ah,09h
mov dx,offset finprog
int 21h
mov ah,4ch
int 21h
ret
entrada proc near
inient:
mov longitud,0
mov buffer,50
mov buffer+1,50
cicloent:
mov ah,02h
mov bh,0
mov dh,1
mov dl,50
int 10h
mov ah,09h
lea dx,buffer
int 21h
mov ah,07h
int 21h
cmp al,39h
jg cicloent
cmp al,0dh
je finentrada
cmp al,08h
jne siguiente
cmp longitud,0
jne quitacar
mov buffer,32
jmp cicloent

quitacar:
lea bx,buffer
mov si,longitud
mov dl,32
mov [bx+si],dl
dec longitud
jmp cicloent
siguiente:
cmp al,30
jl cicloent
cmp longitud,2
je cicloent
lea bx,buffer
mov si,longitud
mov [bx+si],al
inc longitud
jmp cicloent

ayudasalto:
jmp inient

finentrada:
cmp longitud,0
je inient
cmp longitud,1
je convierteuno
mov al,buffer
sub al,30h
mov bl,10
mul bl
cmp ah,0
jne ayudasalto
add al,buffer+1
sub al,30h
cmp al,25
jg ayudasalto
mov cl,al
mov ch,0
ret

convierteuno:
mov al,buffer
sub al,30h
mov cl,al
mov ch,0
ret
entrada endp

printa proc near
mov zeroizq,0
mov bx,offset convierte
mov di,0
mov ax,a
mov temp,ax

cicloprint:
mov ax,temp
mov dx,0
mov cx,[bx+di]
div cx
mov temp,dx
add ax,48
cmp al,48
je imprime
mov zeroizq,1
imprime:
cmp zeroizq,0
jz noimprimir
mov dl,al
call iprim1r2

noimprimir:
inc di
inc di
cmp di,8
jl cicloprint
mov zeroizq,1
cmp di,8
je cicloprint
mov dl,'='
call iprim1r2
mov dl,' '
call iprim1r2
mov bx,a
mov al,bh
call printhexa
mov al,bl
call printhexa
mov dl,'h'
call iprim1r2
mov ah,09h
mov dx,offset linefeed
int 21h
ret
m21hP:


printa endp

printhexa proc near
push ax
and al,240
shr al,1
shr al,1
shr al,1
shr al,1
call printhexachar
pop ax
and al,0fh
call printhexachar
ret
printhexa endp


printhexachar proc near
cmp al,0ah
jge letra
add al,30h
mov dl,al
call iprim1r2
ret
letra:
add al,37h
mov dl,al
call iprim1r2
ret
printhexachar endp


iprim1r2 proc near
mov ah,2
int 21h
ret
iprim1r2 endp

end inicio