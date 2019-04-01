; EJERCICIO 3: PRACTICA
; MODIFICACIONES EN LINEA 49 POR FAVOR REVISAR
.model small

.data 
   
        HDEC    db ?
        HUNI    db ?
        MDEC    db ?
        MUNI    db ?
        SDEC    DB ?
        SUNI    DB ?
        

.stack 100h

.code 

; set segment registers:
         
START:
    
    MOV	AX,@DATA
    MOV	DS, AX
    MOV AL,3          ; MODO DE VIDEO
    MOV AH,0          ; 80 X 25
    INT 10H           
     
    ; add your code here
            
INICIO:

    MOV AH,2CH        ; LLAMA LA INT QUE CAPTURA EL RELOJ DE LA MAQUINA
    INT 21H
     
    CALL VARIABLES
        
    MOV AH,2            
    MOV DL,35         ; POSICIONA EL CURSOR
    MOV DH,10         ; EN LA FILA 10, COLUMNA 35
    INT 10H        
    
           
    MOV AH,02H
    MOV DL,HDEC
    INT 21H
    MOV DL,HUNI
    INT 21H
     
;*************************************************************     
;**                 MODIFICACIONES ACA                      **
;*************************************************************    
; La logica basica aca es borrar un caracter para que el codigo
; lo inserte por su propia cuenta
      
    ; ACA SE AGREGAR EL : 
    
    MOV AH,02H
    MOV DL,58
    INT 21H
    
    MOV AH,2            
    MOV DL,37         ; POSICIONA EL CURSOR
    MOV DH,10         ; EN LA FILA 10, COLUMNA 37
    INT 10H           ; ESTA ES LA POSICION DEL :
                      
                      
                      ; BORRA EL CONTENIDO EN LA FILA
    MOV AH,02H
    MOV DL,00h
    INT 21H
    
    MOV AH,2            
    MOV DL,38         ; POSICIONA EL CURSOR
    MOV DH,10         ; EN LA FILA 10, COLUMNA 38
    INT 10H   
          
        
    MOV AH,02H
    MOV DL,MDEC
    INT 21H
    MOV DL,MUNI
    INT 21H
    
    
 
    
    ;ACA SE AGREGAR EL : **************
    
    
    MOV AH,02H
    MOV DL,58
    INT 21H
    
;   MOV AH,02H        ; SI AGREGAN ESTO DESPUES DE PONER EL : 
;   MOV DL,58         ; PARPADEA EL NUMERO SIGUIENTE AL :
;   INT 21H           ; PARA EXPANDIR PONGA EN DIFERENTES POSICIONES
    
    MOV AH,2            
    MOV DL,40         ; POSICIONA EL CURSOR
    MOV DH,10         ; EN LA FILA 10, COLUMNA 40
    INT 10H           ; ESTA ES LA POSICION DEL :
                      
                      ; BORRA EL CONTENIDO EN LA FILA
    MOV AH,02H
    MOV DL,00h
    INT 21H
    
   
    
 
    
    
    MOV AH,2            
    MOV DL,41          ; POSICIONA EL CURSOR
    MOV DH,10          ; EN LA FILA 10, COLUMNA 41
    INT 10H   
    
      
    MOV AH,02H
    MOV DL,SDEC
    INT 21H
    MOV DL,SUNI
    INT 21H   
     
    MOV AH,1           ; VERIFICA SI SE
    INT 16H            ; HA PRESIONADO TECLA 
    JZ  INICIO         ; SINO SALTA A INICIO
    
    cmp al,51h
    je salir 
    MOV AH,0CH
    INT 21H
    jmp INICIO
    
    salir:
    mov ax, 4c00h      ; exit to operating system.
    int 21h    
     
    
VARIABLES PROC
        
    MOV AL,CH         ; SE TIENEN LAS HORAS (0-23)
    AAM               ; SE AJUSTA A BCD DESEMPAQUETADO
        
    ADD AX,3030H      ; SE CONVIERTE EN ASCII PARA ENVIAR A PANTALLA
    
    MOV HDEC,AH       ; SE PASA A MEMORIA PARA TRABAJAR EN LOS OTROS DATOS
    MOV HUNI,AL
    
    MOV AL,CL         ; SE TIENEN LOS MINUTOS
    AAM               ; SE DESEMPAQUETA EN BCD
        
    ADD AX,3030H      ; SE CONVIERTE A ASCII
    
    MOV MDEC,AH
    MOV MUNI,AL
    
    MOV AL,DH         ; SE TIENEN LOS SEGUNDOS
    AAM
        
    ADD AX,3030H      ; SE CONVIERTE EN ASCII
    
    MOV SDEC,AH
    MOV SUNI,AL
    
    RET     
     
    ENDP 
     
end START              ; set entry point and stop the assembler.
