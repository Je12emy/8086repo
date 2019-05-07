.model small

.stack 100h

.data
	
	uno dw 1
	mens2 db 'hola','$'
	saludo db '****Arquitectura II de Computadores****','$'   
	
	
.code

	mov ax,@data		;direc de inicio del segmento
	mov ds,ax	
		
	mov dx,offset saludo	;ubica el mensaje 
	mov ah,09h
	int 21h

    mov bx,offset mens2
    int 21h
    
    int 21h

	      			;despliega en pantalla
	mov ah,4ch
	int 21h			;sale al DOS	

	end

