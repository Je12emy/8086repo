
.model small

.stack 100h

.data

.code

	mas:
	 	mov ah,01	;espera entrada de teclado
		int 21h		;despliega en pantalla
		cmp al,'*'	;determina si es un *
		jnz mas		;si no lo es salta a otra entrada por teclado
		mov ah,4ch	;si es igual sale
		int 21h		; y retorna al DOS
	end