.model small
.stack
.data
string1 db "ARQUITECTURA 2","$" 
.code
inicio:
mov ax,@data
mov ds,ax
lea bx,string1
mov si,bx
sigte:
cmp [si],"$"
je fin
inc si  
lea dx,string1
mov ah,09h
int 21h
jmp sigte
fin:
dec si
rev:
cmp bx, si
jae listo
mov al,[bx]
mov ah,[si]
mov [si],al
mov [bx],ah
inc bx
dec si
lea dx,string1
mov ah,09h
int 21h
jmp rev
listo:
lea dx,string1
mov ah,09h
int 21h
mov ah,0
int 16h
mov ah, 4ch
int 21h
end