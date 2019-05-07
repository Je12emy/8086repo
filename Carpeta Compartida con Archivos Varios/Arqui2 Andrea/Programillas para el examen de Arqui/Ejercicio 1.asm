.model small
.stack 100h

.data 
    x db ?
    y db ?
    carac db '?'
    aux   db ?
    ancho db ? 
    largo db ? 
    str  db 'Digite el caracter de la matriz: ','$'
    str1 db 0AH,0DH,'Digite las dimensiones de la matriz: ','$'
    str2 db 0AH,0DH,'Digite el Ancho: ','$'
    str3 db 0AH,0DH,'Digite el Largo: ','$' 
    ENTER   DB 0AH,0DH,'$'
.code

   mov ax,@data
   mov ds,ax 
    
   MOV     AH,0
   MOV     AL,3
   INT     10H 
   
   lea   dx,str
   call mensaje
   
   mov ah,01h   
   int 21h
   mov carac,al   
   
   lea     dx, str1             
   call mensaje
   call Ancho_matrix 
   call Largo_matrix
   MOV     AH,0
   MOV     AL,3
   INT     10H
   
   
   mov x,5
   mov y,5
   call cursor  
   mov dl, carac
   mov al ,largo
   mov ah ,00  
   push ax      
            
for1:
    MOV CL,ancho
	for2:
   	    CALL MEN
   	    DEC CL
   	    JNZ for2
   	push dx
   	add y,1
   	call cursor 
	pop dx      
    pop  aX 
    DEC  aX 
    PUSH aX
	JNZ	    for1
	
	 mov x,25
   mov y,5
   call cursor
   mov dl, carac
   mov al ,largo
   mov ah ,00  
   push ax      
            
for3:
    MOV CL,ancho
	for4:
   	    CALL MEN
   	    DEC CL
   	    JNZ for4
   	push dx
   	add y,1
   	call cursor 
	pop dx      
    pop  aX 
    DEC  aX 
    PUSH aX
	JNZ	    for3
	
	mov x,45
   mov y,15
   call cursor
   mov dl, carac
   mov al ,largo
   mov ah ,00  
   push ax      
            
for5:
    MOV CL,ancho
	for6:
   	    CALL MEN
   	    DEC CL
   	    JNZ for6
   	push dx
   	add y,1
   	call cursor 
	pop dx      
    pop  aX 
    DEC  aX 
    PUSH aX
	JNZ	    for5
   
   MOV     AH, 4Ch
   INT     21h 

      
Ancho_matrix PROC 
   lea     dx, str2
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
   RET
ENDP  

Largo_matrix PROC 
   lea     dx, str3
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
   RET
 ENDP      
    
   
   MENSAJE PROC
   	MOV	    AH,9
    INT     21H                     
    RET
   ENDP 
   
   CURSOR  PROC			
        MOV     AH,2
        MOV     DL,X
        MOV     DH,Y
        INT     10H     
        RET				
   ENDP
   
   MEN PROC
      	MOV	    AH,2
        INT     21H                     
        RET
   ENDP
    
    
END   