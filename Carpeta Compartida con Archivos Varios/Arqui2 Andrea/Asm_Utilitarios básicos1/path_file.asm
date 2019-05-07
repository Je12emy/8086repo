;********************************************************************
; Programa "path_file.asm" para ubicar el path del archivo
;********************************************************************

.model small
.stack 100h
.data
	msg1 db 'El programa esta en $'
	unidad db 'ABCDEFGH'
	dospuntos db ':\$'
	ruta db 30 dup(' '),'$'
 
.code
    mov ax,@data
    mov ds,ax
    
	mov ah,19h ;Se obtiene en que unidad esta el directorio
	int 21h
	push ax
	mov ah,09h
	lea dx,msg1	;se despliega msg1
	int 21h
	pop ax
	mov bl,al
	mov dl,unidad[BX] ;posiciono la direccion en la cadena,
					  ;de la letra donde esta el directorio
	mov ah,02h
	int 21h           ;se despliega la unidad
	
	lea dx,dospuntos
	mov ah,09h
	int 21h
 
	mov ah,47h	;servicio 47h para obtener nombre de la carpeta 
	mov dl,03h	;Unidad donde se require conocer el directorio
	lea si,ruta	;En "ruta" se guarda el nombre de directorio:se usa SI 
	int 21h
 
	mov ah,09h 
	LEA DX, ruta
	int 21h      ; se despliega la cadena con el nombre del directorio
 
    mov ah,4ch    
    int 21h      ;fin del programa
end
