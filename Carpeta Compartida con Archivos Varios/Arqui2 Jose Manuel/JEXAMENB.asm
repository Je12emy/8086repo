;JOSE MANUEL ROJAS FALLAS
;EXAMEN 3 PROBLEMA B

;.MODEL tiny
;.CODE
;Inicio: ;Punto de entrada al programa
;Mov AX,0 ;AX=0
;Mov BX,1 ;BX=1 Estos son los dos primeros elementos 0+1=1
;Mov CX,10 ;Repetir 10 veces
;Repite:
;Mov DX,AX ;DX=AX
;Add DX,BX ;DX=AX+BX
;Mov AX,BX ;Avanzar AX
;Mov BX,DX ;Avanzar BX
;Loop Repite ;siguiente número
;Mov AX,4C00h ;Terminar programa y salir al DOS
;Int 21h ;
;END Inicio
;END


.MODEL	SMALL		
.STACK	100H			
.DATA
MENSAJE   DB 'Digite N: ','$' 
FIBN DB ?;3,0,3 dup (?)
   .CODE    

   INI: 
      
   MOV	AX,@DATA
	MOV	DS,AX 
	 
   MOV DX, OFFSET MENSAJE
   MOV AH, 09H
   INT 21H
     
   MOV     AH,01H
   INT     21H         
   SUB     AL,30H
   MOV   FIBN,AL
   ;	mov dx,OFFSET NUMERO;offset NUMERO
;	mov ah,0ah            ;almacena en cadena
	;int 21h
     
   MOV     CX,[0200]
   MOV     AX,0001
   MOV     BX,0001
   MOV     [0300],AX
   MOV     [0302],BX
   LEA     SI,[0304]
   ADD     AX,BX
   XCHG    AX,BX
   MOV     [SI],BX
  INC     SI
  INC     SI
  DEC     CX
  CMP     CX,+00
  ;JG      0115
  NOP
  NOP
   
  ;MOV     AH,01H
  ;LEA     DX,NUMERO
  ;INT     21H	  
	
  ; MOV AH,00
  
  ; LEA CX,NUMERO
   ;     INT 16H
  ; MOV CX,DX;NUMERO 
    
   MOV CX,8;FIBN
   MOV AX,1
    MOV BX,0
 
   CICLO:
   MOV DX,AX
   ADD DX,BX
   MOV AX,BX
   MOV BX,DX
  ;AAA
   ;LEA DX.MSG 
   ;MOV AH, 09H
  ; INT 21H 
   ;MOV AH, 09H
   ;INT 21H 
   add Bl,    30h                  ; Convertimos resultado a ASCII
   mov DX,BX                   ; Copiamos BX a DX para presentar en
   mov ah,02h                  ; Int 02h mostrar caracter
   int 21h  
   LOOP CICLO 
   mov AH,02h 
   int 21h
   
   ;MOV AH,4CH 

   INT 21H
   END 
   


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