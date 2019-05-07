;Programa Notas.asm que muestra otra forma de declarar el vector para la INT21h serv 0AH
;y luego convertir de ascii a binario y procesar el valor para definir la aprobacion o no
;de la nota del curso.
;Usa la declaracion ampliada de segmentos 




PILA    SEGMENT PARA STACK 'PILA'
        DB      1024    DUP (?)
PILA    ENDS

DATOS   SEGMENT PARA 'DATOS'
        PREGUNTA        DB 10,13,'Digite un n£mero entre 0 y 100: ','$'
        FRASE_PASO      DB 10,13,'Usted paso! ',10,13,'$'
        FRASE_QUEDO     DB 10,13,'Usted se quedo! ',10,13,'$'
        CONTINUA        DB 10,13,'Desea continuar [S/N]?: ',10,13,'$'
        NUMERO          LABEL   BYTE
        MAXIMO          DB      4
        TAMANO          DB      ?
        VALOR           DB      4 DUP (?)

DATOS   ENDS

CODIGO  SEGMENT PARA 'CODIGO'
        

PRINCIPAL       PROC FAR

                ASSUME  CS:CODIGO,DS:DATOS,SS:PILA
        
	INICIO:
                MOV     AX,DATOS
                MOV     DS,AX
                MOV     AH,09H
                LEA     DX,PREGUNTA
                INT     21H

                MOV     AH,0AH
                LEA     DX,NUMERO
                INT     21H

                CALL    ASCII2HEX
                
                CMP     AL,100
                JA      INICIO
                CMP     AL,70
                JAE     PASO
                MOV     AH,09H
                LEA     DX,FRASE_QUEDO
                INT     21H
                JMP     FIN

        
        
        PASO:   MOV     AH,09H
                LEA     DX,FRASE_PASO
                INT     21H

        FIN:    MOV     AH,09H
                LEA     DX,CONTINUA
                INT     21H
                MOV     AH,01H
                INT     21H

                CMP     AL,'S'
                JE      INICIO
                CMP     AL,'S'
                JE      INICIO
                MOV     AX,04C00H
                INT     21H
        PRINCIPAL       ENDP

        ASCII2HEX       PROC
                PUSH    SI
                PUSH    BX
                MOV     AL,TAMANO
                CMP     AL,00H
                JE      FINAL
                CMP     AL,01H
                JE      UNO
                CMP     AL,02H
                JE      DOS
                CMP     AL,03H
                JE      TRES
                JMP     FINAL

        TRES:   XOR     AH,AH
                LEA     SI,VALOR
                MOV     AL,[SI]
                SUB     AL,30H
                MOV     BL,100
                MUL     BL
                PUSH    AX
                INC     SI
                MOV     AL,[SI]
                SUB     AL,30H
                MOV     BL,10
                MUL     BL
                PUSH    AX
                INC     SI
                MOV     AL,[SI]
                SUB     AL,30H
                POP     BX
                ADD     AL,BL
                POP     BX
                ADD     AL,BL
                JMP     FINAL

        DOS:    XOR     AH,AH
                LEA     SI,VALOR
                MOV     AL,[SI]
                SUB     AL,30H
                MOV     BL,10
                MUL     BL
                PUSH    AX
                INC     SI
                MOV     AL,[SI]
                SUB     AL,30H
                POP     BX
                ADD     AL,BL
                JMP     FINAL

        UNO:    XOR     AH,AH
                LEA     SI,VALOR
                MOV     AL,[SI]
                SUB     AL,30H

        FINAL:  POP     BX
                POP     SI
                RET
        ASCII2HEX       ENDP

CODIGO  ENDS
        
        END     PRINCIPAL

        
