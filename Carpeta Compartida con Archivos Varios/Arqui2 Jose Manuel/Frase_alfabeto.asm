;*******************************************
;*********Oscar Alvarez Cubillo*********
;*******Universidad Hispanoamericana********
;*******************************************
 
include Libreria.txt
.model small
.stack 100h
.data

msg1    db  "Ingrese una cadena: $"
s1      db   100,?, 100 dup(' ')
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


msgA    db "A : $"
msgB    db "B : $"
msgC    db "C : $"
msgD    db "D : $"
msgE    db "F : $"
msgF    db "G : $"
msgG    db "H : $"
msgH    db "I : $"
msgI    db "J : $"
msgJ    db "K : $"
msgK    db "L : $"
msgL    db "M : $"
msgM    db "N : $"
msgN    db "O : $"
msgO    db "P : $"
msgP    db "Q : $"
msgQ    db "R : $"
msgR    db "S : $"
msgS    db "T : $"
msgT    db "U : $"
msgU    db "V : $"
msgV    db "W : $"
msgW    db "X : $"
msgX    db "Y : $"
msgY    db "Z : $"
msgZ    db "A : $"
 
   
 
   
   
   
   
.code
       
    MOV     AX, @data
    MOV     DS, AX
    
    ajustar 3,0          	
 	
    lea dx,msg1
    escribir
    
    lea dx,s1  
    capturar
    
    xor cx, cx
    mov cl, s1[1] 
 ;   inc cl
                  
    lea bx,s1[2] 

suma proc

     mov dl, [bx]
      
     inc bx
     dec cl 
     jz fin 
     call compare
     loop suma 
endp    

          
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
     je letral
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
     jmp suma
     ret
endp

          
letraa proc;call
    
    inc a
    call suma
endm
     
letrab proc
    
    inc b
    call suma
endm 

letrac proc
    
    inc c
    call suma
endm

letrad proc
    
    inc d
    call suma
endm
     
letrae proc
    
    inc e
    call suma
endm

letraf proc
    
    inc f
    call suma
endm 

letrag proc
    
    inc g
    call suma
endm

letrah proc
    
    inc h
    call suma
endm

letrai proc  
    
    inc i
    call suma
endm

letraj proc
    
    inc j
    call suma
endm

letrak proc
    
    inc k
    call suma
endm  

letral proc
    
    inc l
    call suma
endm 

letram proc
    
    inc m
    call suma
endm
     
letran proc
    
    inc n
    call suma
endm   
     
letrao proc
    
    inc o
    call suma
endm

letrap proc
    
    inc p
    call suma
endm 

letraq proc
    
    inc q
    call suma
endm

letrar proc
    
    inc r
    call suma
endm 

letras proc
    
    inc s
    call suma
endm

letrat proc
    
    inc t
    call suma
endm
          
     
letrau proc
    
    inc u
    call suma
endm

letrav proc
    
    inc v
    call suma
endm

letraw proc
    
    inc w
    call suma
endm

letrax proc
    
    inc x
    call suma
endm

letray proc
    
    inc y
    call suma
endm

letraz proc
    
    inc z
    call suma
endm


                  
fin proc
    
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
    
    posicion 5,5 
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
            
    posicion 9,5
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
    
    posicion 18,10
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
    add g,30h
    mov dl,g
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
    
    MOV AH,4CH      
    INT 21H
    
    ret         
end
