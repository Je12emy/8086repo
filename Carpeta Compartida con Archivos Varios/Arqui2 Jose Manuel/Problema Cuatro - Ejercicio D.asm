include Libreria.txt
.model small
.stack 100h
.data

msg1    db  "Ingrese una cadena: $"
cadena1 db 50 dup(' '),'$'
a       db 0
b       db 0
c       db 0
d       db 0
e       db 0
f       db 0
g       db 0
h       db 0
i       db 0
j       db 0
k       db 0
l       db 0
n       db 0
m       db 0
o       db 0
p       db 0
q       db 0
r       db 0
s       db 0
t       db 0
u       db 0
v       db 0
w       db 0
x       db 0
y       db 0
z       db 0 
cero    db 0
uno     db 0
dos     db 0
tres    db 0
cuatro  db 0
cinco   db 0
seis    db 0
siete   db 0
ocho    db 0
nueve   db 0 
spa     db 0




msgA    db "A : $"
msgB    db "B : $"
msgC    db "C : $"
msgD    db "D : $"
msgE    db "E : $"
msgF    db "F : $"
msgG    db "G : $"
msgH    db "H : $"
msgI    db "I : $"
msgJ    db "J : $"
msgK    db "K : $"
msgL    db "L : $"
msgM    db "M : $"
msgN    db "N : $"
msgO    db "O : $"
msgP    db "P : $"
msgQ    db "Q : $"
msgR    db "R : $"
msgS    db "S : $"
msgT    db "T : $"
msgU    db "U : $"
msgV    db "V : $"
msgW    db "W : $"
msgX    db "X : $"
msgY    db "Y : $"
msgZ    db "Z : $"
msgcero  db "Cero: $"
msguno  db "Uno : $" 
msgdos  db "Dos : $"   
msgtres db "Tres : $" 
msgcuatro db "Cuatro : $"   
msgcinco db "Cinco : $"
msgseis  db "Seis : $" 
msgsiete db "Siete : $"   
msgocho  db "Ocho : $" 
msgnueve db "Nueve : $"
msgespacio db "Espacio Vacio : $"   
   
   
.code
       
    MOV     AX, @data
    MOV     DS, AX
    ajustar 3,0          		
    lea dx,msg1
    escribir
    mov bx,0000h
    lea SI,cadena1 
    mov cx,50     
    
Principal:
  mov ah,07h 
  int 21h        
  cmp al,13         
  je fin      
  mov [SI],al
  inc SI      
  add cadena1 , al
  mov dl, al  
  call compare
  mov ah,02h 
  int 21h    
  loop Principal 
          
compare proc
     cmp dl, 61h
     je letraa
     cmp dl, 62h
     je letrab
     cmp dl, 63h
     je letrac
     cmp dl, 64h
     je letrad
     cmp dl, 65h
     je letrae
     cmp dl, 66h
     je letraf
     cmp dl, 67h
     je letrag
     cmp dl, 68h
     je letrah
     cmp dl, 69h
     je letrai  
     cmp dl, 6Ah
     je letraj
     cmp dl, 6Bh
     je letraK
     cmp dl, 6Ch
     je letral
     cmp dl, 6Dh
     je letram
     cmp dl, 6Eh
     je letran
     cmp dl, 6fh
     je letrao 
     cmp dl, 70h
     je letrap
     cmp dl, 71h
     je letraq
     cmp dl, 72h
     je letrar
     cmp dl, 73h
     je letras
     cmp dl, 74h
     je letrat
     cmp dl, 75h
     je letrau
     cmp dl, 76h
     je letrav
     cmp dl, 77h
     je letraw
     cmp dl, 78h
     je letrax
     cmp dl, 79h
     je letray
     cmp dl, 7Ah
     je letraz 
     cmp dl, 30h
     je numerocero
     cmp dl, 31h
     je numerouno
     cmp dl, 32h
     je numerodos
     cmp dl, 33h
     je numerotres
     cmp dl, 34h
     je numerocuatro
     cmp dl, 35h
     je numerocinco
     cmp dl, 36h
     je numeroseis
     cmp dl, 37h
     je numerosiete
     cmp dl, 38h
     je numeroocho
     cmp dl, 39h
     je numeronueve 
     cmp dl, 20h
     je vacio
     ;jmp suma
     ret
endp

          
letraa proc;call
    inc a
    ret
endp
     
letrab proc
   inc b
   ret
endp 

letrac proc
   inc c
   ret
endp

letrad proc
   inc d
   ret
endp
     
letrae proc
    inc e
    ret
endp

letraf proc
    inc f
    ret
endp 

letrag proc
    inc g
    ret
endp

letrah proc
    inc h  
    ret
endp

letrai proc  
    inc i
    ret
endp

letraj proc
    inc j
    ret
endp

letrak proc
    inc k
    ret
endp  

letral proc
    inc l
    ret
endp 

letram proc
    inc m
    ret
endp
     
letran proc
    inc n
    ret
endp   
     
letrao proc
    inc o
    ret
endp

letrap proc
    inc p
    ret
endp 

letraq proc
    inc q
    ret
endp

letrar proc
    inc r
    ret
endp 

letras proc
    inc s
    ret
endp

letrat proc
    inc t
    ret
endp
          
     
letrau proc
    inc u
    ret
endp

letrav proc
    inc v
    ret
endp

letraw proc
    inc w
    ret
endp

letrax proc
    inc x
    ret
endp

letray proc
    inc y
    ret
endp

letraz proc
    inc z 
    ret
endp 

numerocero proc
    inc cero  
    ret
endp 

numerouno proc
    inc uno  
    ret
endp

numerodos proc
    inc dos 
    ret
endp 

numerotres proc
    inc tres 
    ret
endp        

numerocuatro proc
    inc cuatro
    ret
endp          

numerocinco proc
    inc cinco  
    ret
endp         

numeroseis proc
    inc seis  
    ret
endp      

numerosiete proc
    inc siete  
    ret
endp       

numeroocho proc
    inc ocho 
    ret
endp      

numeronueve proc
    inc nueve 
    ret
endp 

vacio proc
    inc spa
    ret
endp
                  
fin: 
    ajustar 3,0 

    posicion 1,0
    lea dx,msgA
    escribir
    add a,30h
    mov dl,a
    escribir2
    
    posicion 2,0
    lea dx,msgB
    escribir
    add b,30h
    mov dl,b
    escribir2
    
    posicion 3,0
    lea dx,msgC
    escribir
    add c,30h
    mov dl,c
    escribir2
    
    posicion 4,0
    lea dx,msgD
    escribir
    add d,30h
    mov dl,d
    escribir2
    
    posicion 5,0 
    lea dx,msgE
    escribir  
    add e,30h
    mov dl,e
    escribir2
    
    posicion 6,0
    lea dx,msgF
    escribir
    add f,30h
    mov dl,f
    escribir2
    
    posicion 7,0
    lea dx,msgG
    escribir
    add g,30h
    mov dl,g
    escribir2
            
    posicion 8,0
    lea dx,msgH
    escribir
    add h,30h
    mov dl,h
    escribir2
            
    posicion 9,0
    lea dx,msgI
    escribir 
    add i,30h
    mov dl,i
    escribir2
    
    posicion 10,0
    lea dx,msgJ
    escribir
    add j,30h
    mov dl,j
    escribir2
    
    posicion 11,0
    lea dx,msgK
    escribir
    add k,30h
    mov dl,k
    escribir2
    
    posicion 12,0
    lea dx,msgL
    escribir
    add l,30h
    mov dl,l
    escribir2
    
    posicion 13,0
    lea dx,msgM
    escribir
    add m,30h
    mov dl,m
    escribir2
    
    posicion 14,0
    lea dx,msgN
    escribir
    add n,30h
    mov dl,n
    escribir2
    
    posicion 15,0
    lea dx,msgO
    escribir  
    add o,30h
    mov dl,o
    escribir2
    
    posicion 16,0
    lea dx,msgP
    escribir
    add p,30h
    mov dl,p
    escribir2
    
    posicion 17,0
    lea dx,msgQ
    escribir
    add q,30h
    mov dl,q
    escribir2
    
    posicion 18,0
    lea dx,msgR
    escribir
    add r,30h
    mov dl,r
    escribir2
    
    posicion 19,0
    lea dx,msgS
    escribir
    add s,30h
    mov dl,s
    escribir2
    
    posicion 20,0
    lea dx,msgT
    escribir 
    add t,30h
    mov dl,t
    escribir2
    
    posicion 21,0
    lea dx,msgU
    escribir
    add u,30h
    mov dl,u
    escribir2
    
    posicion 22,0
    lea dx,msgV
    escribir
    add v,30h
    mov dl,v
    escribir2
    
    posicion 23,0
    lea dx,msgW
    escribir
    add w,30h
    mov dl,w
    escribir2
    
    posicion 24,0
    lea dx,msgX
    escribir
    add x,30h
    mov dl,x
    escribir2
    
    posicion 25,0
    lea dx,msgY
    escribir
    add y,30h
    mov dl,y
    escribir2
    
    posicion 26,0
    lea dx,msgZ
    escribir
    add z,30h
    mov dl,z
    escribir2
    
    posicion 27,0
    lea dx,msgcero
    escribir
    add cero,30h
    mov dl,cero
    escribir2 
    
    posicion 28,0
    lea dx,msguno
    escribir
    add uno,30h
    mov dl,uno
    escribir2 
    
    posicion 29,0
    lea dx,msgdos
    escribir
    add dos,30h
    mov dl,dos
    escribir2
    
    posicion 30,0
    lea dx,msgtres
    escribir
    add tres,30h
    mov dl,tres
    escribir2  
    
    posicion 31,0
    lea dx,msgcuatro
    escribir
    add cuatro,30h
    mov dl,cuatro
    escribir2  
    
    posicion 32,0
    lea dx,msgcinco
    escribir
    add cinco,30h
    mov dl,cinco
    escribir2  
    
    posicion 33,0
    lea dx,msgseis
    escribir
    add seis,30h
    mov dl,seis
    escribir2  
    
    posicion 34,0
    lea dx,msgsiete
    escribir
    add siete,30h
    mov dl,siete
    escribir2  
    
    posicion 35,0
    lea dx,msgocho
    escribir
    add ocho,30h
    mov dl,ocho
    escribir2  
    
    posicion 36,0
    lea dx,msgnueve
    escribir
    add nueve,30h
    mov dl,nueve
    escribir2
    
     posicion 37,0
    lea dx,msgespacio
    escribir
    add spa,30h
    mov dl,spa
    escribir2        
               
    MOV AH,4CH      
    INT 21H        
end
