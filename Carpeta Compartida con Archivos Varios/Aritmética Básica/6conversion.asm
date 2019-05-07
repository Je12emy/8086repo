;*************************************************************************
;Programa "6conversion" para convertir un ingreso en decimal por teclado
;en un numero binario y mostrarlo en pantalla
;*************************************************************************

.model small
.stack 100h

.data

   cad  db 9 dup (' '),'$'
   num  db ?
   aux  db ?
  
.code

   mov ax,@data
   mov ds,ax

   mov ah,01h   
   int 21h      ;Ingreso por teclado
   sub al,30h   ;convierte de ascii a binario
  
   mov bl,10    ;Movemos a bl un 10
   mul bl       ;Multiplicar por 10 el numero a convertir
   mov aux,al   ;se pasa a aux el resultado

    
   mov ah,01h   ;Para segundo digito se repite
   int 21h      
   sub al,30h   ;convierte de ascii a binario
   
   
   add aux,al   ;se suma al numero anterior multiplicado por 10
   mov bl,aux   ;este ya no necesita ser multiplicado por 10
   mov num,bl   ;El numero resultante queda en la variable "num"
   
   mov ah,02h    ;Se despliega el signo '='
   mov dl,'='
   int 21h

   mov SI,6      ;Comienzan los ciclos de division entre 2
  
   bin:         

      mov ah,00h ;Aseguramos residuo de 0
      mov al,num ;se trae de la memoria el numero a convertir
      mov bl,2
      div bl
      mov dl,ah  ;el residuo se coloca en DL
      mov num,al ;se actualiza en memoria el valor con el cociente

                 
      add dl,30h ;convierte de binario a ascii el residuo

      mov cad[SI],dl;Concatenamos resultados dentro de la cadena a desplegar
      dec SI
      cmp num,1  ;se compara si se llego al final
     
      jne bin    ;Indicamos volver a etiqueta bin o:
     

      mov dl,num ;se pasa a la cadena con el resultado, el ultimo digito
      add dl,30h 

      mov cad[SI],dl  ;Proceso para imprimir cadena final como numero binario

  mov ah,09h
  lea Dx,cad
  int 21h

  mov ah,4ch
  int 21h

end
