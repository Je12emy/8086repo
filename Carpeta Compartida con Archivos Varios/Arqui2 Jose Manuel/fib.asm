                             stack segment 
dw 500h 
stack ends 

data segment 

array dw 15h dup(0000h) 
disparray dw 10h dup(0000h) 

data ends 

code segment 
assume cs:code, ds:data ,ss:stack 
;.......................................................... 

begin: main proc far 

mov ax,data 
mov ds,ax 

call new_line 
call new_line 

mov array[0],0001h 
mov array[2],0001h 
mov si,0004h 

sss: 

mov ax,0000h 
mov ax,array[si-2] 
add ax,array[si-4] 
mov array[si],ax 
add si,0002h 
cmp si,001eh 
jnz sss 

;......muestra el arreglo.............. 

mov si,0000h 

loop6: 
mov ax,array[si] 
mov di,0000h 

loop4: 
mov dx,0000h 
mov bx,0ah 
div bx 
mov disparray[di],dx 
add di,0002h 
cmp ax,0000h 
jnz loop4 

loop8: 
sub di,0002h 
mov bx,disparray[di] 
mov disparray[di],0000h 

mov dl,bl 
and dl,0fh 
or dl,30h 
mov ah,02h 
int 21h 
cmp di,0000h 
jnz loop8 

add si,0002h 

mov ah,02h 
mov dl,20h 
int 21h 
cmp si,001eh 
jnz loop6 

call new_line 

ending: 

mov ax,4c00h 
int 21h 

main endp 
;........................................................ 
new_line proc near 
mov ah,02h 
mov dl,0dh 
int 21h 
mov ah,02h 
mov dl,0ah 
int 21h 
ret 
new_line endp 
;....................................................... 

code ends 
end begin