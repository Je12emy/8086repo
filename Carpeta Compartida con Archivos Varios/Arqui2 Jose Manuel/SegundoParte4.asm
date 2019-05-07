.model small
.stack 100h
.data

  cadena1   db     50,0,50 dup (0aah) 
  cadena2   db     50,0,50 dup (0aah)  
  cadena   dw        0
  
  msj1 db 'El numero de caracteres es:$'
  msj2 db 'Digite una contrasena $'      
  otre db 'Repitala contrasena $'  
  val db 'La contrasena debe tener mas de 8 caracteres$' 
  val1 db 'La contrasena esta bien$'
  cont dw ?
  c    db 0                
    erro      db    'error','$'
	bien      DB    'correcto','$'
    ENTER   DB 0AH,0dh,'$'  
 
.code
inicio:
   mov ax,@data
   mov ds,ax  
   push    ds	
	pop     es
   call LIMPIA_PANTALLA
   call POSICIONA_CURSOR

    mov dx,offset msj2
    call lee
  
    MOV DX,OFFSET CADENA1  ; Guardar caracter en la cadena
	MOV AH,0AH
    INT 21H
       
    mov bx,0000h
    lea SI,cadena1 ; Coloca en SI la direccion del primer espacio de la cadena1
    mov cx,50      ; inicio el registro del contador en 50  
    
 
;*********************** ESCRIBE PALABRA		
	cld                    
	mov si,offset cadena1 + 1 
	lodsb				;extrae el byte con la cantidad de letras leidas desde el KB => AL
	
	mov ah,00h
	mov di,offset cadena1 + 2  ; DI contiene el inicio de la palabra
	add di,ax             ;se suma al inicio de la palabra digitada
		                   ; se tiene ahora apuntando DI al final de la palabra
	mov al,'$'
	
	stosb
	
	;MOV DX, OFFSET cadena1 + 2
	;CALL LEE  
	;call tecla 
	
;****************** digita numero **********
	mov si,offset cadena1 + 1  
	   
	  	
	
	MOV al,[SI] 
	MOV c,al
	lodsb				;extrae el byte con la cantidad de letras leidas desde el KB
	 
	cmp c,07
    jb tres
    jae correcto 
	
	add al,30H
	mov dl,al			;prepara el despligue
 	mov ah,02h
	int 21h		
;********************************************	        
	        
 
    correcto:
      call LIMPIA_PANTALLA   
    call POSICIONA_CURSOR
    lea dx, val1 ; mov dx,offset msj1
    call lee 
    call tecla
      lea dx, enter ; mov dx,offset msj1
    call lee 
   
   mov dx,offset otre
    call lee
  
    MOV DX,OFFSET CADENA2  ; Guardar caracter en la cadena
	MOV AH,0AH
    INT 21H
       
    mov bx,0000h
   lea SI,cadena1 ; Coloca en SI la direccion del primer espacio de la cadena1
   mov cx,50      ; inicio el registro del contador en 50 
;************************* Escribir la palabra ********************
    
	cld                     ; Activa DF para conteo ascendente en SI-DI
	mov si,offset cadena2 + 1 
	lodsb				;extrae el byte con la cantidad de letras leidas desde el KB => AL
	
	mov ah,00h
	mov di,offset cadena2 + 2  ; DI contiene el inicio de la palabra
	add di,ax             ;se suma al inicio de la palabra digitada
		                   ; se tiene ahora apuntando DI al final de la palabra
	mov al,'$'
	
	stosb
	
	;MOV DX, OFFSET cadena2 + 2
	;CALL LEE  
	call tecla  
	
		
	cld
	mov di,offset cadena1 + 2 
	mov si,offset cadena2 + 2 
	mov cl,04 
	
otro:	
	cmpsb       ; comaparar el byte
	jnz error   ; saltar si no es cero
	dec cl
	jnz otro 
	
	lea dx, bien ;mov dx,offset bien
	call lee
	jmp salir
		
	error:
	
	lea dx, erro;mov dx,offset erro
	call lee

salir:
	MOV	AH,4CH
	INT	21H  
	
	  
regresa:
  call TECLA
  cmp al,13  ; Compara al con enter
  je termina ; salta solo si la tecla oprimida es enter    
  
 
 
 termina:
  
  mov cont,bx
  
 mov ah,02
 mov dx,0702h
 mov bh,00
 int 10h      ; Posiciona cursor

; lea dx, msj1 ; mov dx,offset msj1
; call lee
  
 call TECLA
 
mov ah,4ch
int 21h  

tres:
    call LIMPIA_PANTALLA   
    call POSICIONA_CURSOR
    lea dx, val ; mov dx,offset msj1
    call lee 
    call tecla
   jmp inicio
                   
                   
;************************** ETIQUETAS ************************************       

LIMPIA  PROC
        MOV AH,0          
        MOV AL,3        
        INT 10H   
        RET
ENDP 

;*************************************************************************** 
 
LEE PROC
      	MOV	AH,9
        INT 21H                     
        RET
ENDP  


LIMPIA_PANTALLA PROC NEAR    ; poner el color a la pantalla
     MOV AX, 0600H ; ah 06... al 00
     MOV BH, 57H       ;color
     MOV CX, 0000H
     MOV DX, 184Fh  
 
     INT 10H
     RET
LIMPIA_PANTALLA ENDP   
   

 POSICIONA_CURSOR PROC NEAR
     mov ah,02
     mov dx,0402h
     mov bh,00
     int 10h
     RET
  POSICIONA_CURSOR ENDP 
 
TECLA   PROC
        MOV AH,07  ; si se quiere q aparesca es 01 
        INT 21H   
        RET
ENDP 

  

     ;cierre del programa
end


;black       (0)
;blue        (1)
;green       (2)
;cyan        (3)
;red         (4)
;magenta     (5)
;brown       (6)
;white       (7)  
;grey        (8)





     mov ax,cont

  aam			; Hace un ajuste decimal: AH = decenas, AL = unidades

  mov bx,ax

     
 mov 	ah,2		; Opcion para utilizar el display en la interrupcion 21h
 mov 	dl,bh		; las decenas se cargan en DL
 add 	dl,30h		; se le suma un 30h al numero para mostrar el caracter
 int 	21h		; llamada a utilizar display, se muestra caracter en DL
    
 mov 	dl,bl		; las unidades se cargan en DL
 add 	dl,30h		; se repite el proceso anterior
 int 	21h

 
 
 