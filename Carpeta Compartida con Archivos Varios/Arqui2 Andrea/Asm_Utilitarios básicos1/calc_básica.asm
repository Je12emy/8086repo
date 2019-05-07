;**************************************************************************
;Calculadora Aritmetica Basica
;El siguiente programa realiza las 
;funciones basicas de una calculadora, opera con 2 digitos
;**************************************************************************

.model small
.stack 100h  

.data

titulo DB  "*  CALCULADORA ARITMETICA LOGICA BASICA  *$"
solicitar dB "operacion:$"

.code 

MOV AX,@DATA
mov ds,ax

;marco principal 
mov ax,0600h
mov bh,4eh    ;nibble alto: color del fondo  / nibble bajo: color del texto
mov cx,0610h
mov dx,1234h
int 10h   

;HEX    BIN        COLOR

;0      0000      black
;1      0001      blue
;2      0010      green
;3      0011      cyan
;4      0100      red
;5      0101      magenta
;6      0110      brown
;7      0111      light gray
;8      1000      dark gray
;9      1001      light blue
;A      1010      light green
;B      1011      light cyan
;C      1100      light red
;D      1101      light magenta
;E      1110      yellow
;F      1111      white   

;posicionar el cursor para titulo
mov dx,0814h
mov ah,02h
mov bh,00h
int 10h
;escribir string de titulo
mov ah,09h
mov cx,01h
mov dx,offset titulo; dir. base string CALCULADORA
int 21h
;posicionar el cursor para texto
mov dx,0A14h
mov ah,02h
mov bh,00h
int 10h
;escribir string de solicitud de operación
mov ah,09h
mov cx,01h
mov dx,offset solicitar; dir string de solicitar operación
int 21h
;marco de datos
mov ax,0600h
mov bh,0e0h ;70
mov cx,0A20h
mov dx,0B36h
Int 10h
;marco de símbolo &
mov ax,0600h
mov bh,0D7h
mov cx,1014h
mov dx,1118h
int 10h
;posicionar cursor
mov dx,1016h
mov ah,02h
mov bh,00h
int 10h
;escribir simbolo
mov ah,02h
mov cx,01h
mov dl,26h; simbolo &
int 21h
;marco de simbolo +
mov ax,0600h
mov bh,0D7h
mov cx,1020h
mov dx,1124h
int 10h
;posicionar cursor
mov dx,1022h
mov ah,02h
mov bh,00h
int 10h
;escribir simbolo
mov ah,02h
mov cx,01h
mov dl,2Bh; simbolo +
int 21h
;marco de simbolo -
mov ax,0600h
mov bh,0D7h
mov cx,1028h
mov dx,112Ch
int 10h
;posicionar cursor
mov dx,102Ah
mov ah,02h
mov bh,00h
int 10h
;escribir simbolo
mov ah,02h
mov cx,01h
mov dl,2Dh; simbolo -
int 21h
;marco de simbolo *
mov ax,0600h
mov bh,0D7h
mov cx,1030h
mov dx,1134h
int 10h
;posicionar cursor
mov dx,1032h
mov ah,02h
mov bh,00h
int 10h
;escribir simbolo
mov ah,02h
mov cx,01h
mov dl,2Ah; simbolo *
int 21h
;marco de simbolo /
mov ax,0600h
mov bh,0D7h
mov cx,1038h
mov dx,113Ch
int 10h
;posicionar cursor
mov dx,103Ah
mov ah,02h
mov bh,00h
int 10h
;escribir simbolo
mov ah,02h
mov cx,01h
mov dl,2Fh; simbolo /
int 21h
;posicionar cursor
mov dx,0A22h
mov ah,02h
mov bh,00h
int 10h
;capturar operacion 
call CALC
;posicionar cursor
mov dx,1400h
mov ah,02h
mov bh,00h
int 10h
mov ah,01h
int 21h
mov ah,4Ch
int 21h


;funciones de la calculadora 
CALC:
CALL    CAPT; llamar a capturar operando
PUSH    AX;  guarda dato 1 en pila
MOV     AH,01h; capturar operador
INT     21h
MOV     DL,AL; lo guarda el DL
CALL    CAPT; llamar a capturar operando
MOV     BX,AX;  guarda dato 2 en BX
POP     AX; recupera dato 1

;comparacion del operador para llamar al procedimiento de la operación escogida

CMP     DL,2Bh; (+)
JZ      SUMA ;salta a sumar
CMP     DL,2Dh;(-)
JZ      RESTA ; salta a restar
CMP     DL,2Ah;(*)
JZ      MULT;salta a multiplicar
CMP     DL,2Fh; (/)
JZ     DIVISION; salta a dividir
CMP     DL,26h;(&)
JZ     AND_LOGICA; salta a and

RESULTADO:
MOV     AH,02h; posición de retorno de calculo
MOV     DL,3Dh; (=)
INT     21h; imprime caracter
MOV     DL,CL; acarreo o signo negativo
INT     21h; imprime caracter
MOV     DL,BH; digito mas significativo
INT     21h; imprime caracter
MOV     DL,BL; digito menos significativo
INT     21h; imprime caracter
RET; retornar a la interfase gráfica que lo llamo

;capturar operando
CAPT:
MOV     AH,01h
INT     21h
MOV     BH,AL
INT     21h
MOV     AH,BH
SUB     AX,3030h    ;convierte de ascii a binario natural
RET

SUMA:
MOV     CL,00
ADD     AX,BX
CMP     AL,0Ah
JB      DIGITO
DAA
INC     AH
DIGITO:
MOV     BL,AL
MOV     AL,AH
CMP     AL,0Ah
JB     DECENA
DAA
MOV     CL,31h
DECENA:
MOV     BH,AL
AND     BX,0F0Fh
OR      BX,3030h
JMP     RESULTADO

resta:
MOV     CL,00
CMP     AX,BX
JGE     restar
XCHG    AX,BX
MOV     CL,2Dh
restar:
SUB     AX,BX
CMP     AL,0Ah
JB      listo
DAS
listo:
MOV     BX,AX
AND     BX,0F0Fh
OR      BX,3030h
JMP     RESULTADO

;nota: multiplicaciones de operandos de un digito 
MULT:
MOV     CL,00
MUL     BL
AAM
MOV     BX,AX
AND     BX,0F0Fh
OR      BX,3030h
JMP     RESULTADO

;divisiones de numeros resultado de productos de un digito DIV es rervada no se usa como etiqueta
DIVISION:
MOV     CL,00
AAD
DIV     BL
MOV     BL,AL
OR      BL,30h
JMP     RESULTADO

AND_LOGICA:
AND     BX,AX
OR      BX,3030h
MOV     CX,0000h
JMP     RESULTADO

END
