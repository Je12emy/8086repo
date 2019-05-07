.model small
.stack 100h
.data

Var1 DB 0AH,0DH,'Titulo','$'
Var2 DB 0AH,0DH,'Esteban Gutierrez','$'
Var3 DB 0AH,0DH, 48h, 6Fh, 6Ch, 61h, 20h, 4Dh, 75h, 6Eh, 64h,6Fh,24h


.code

Inicio:
        Mov AX,@data
        Mov DS,AX
        
        Mov Ah,09
        Mov DX,OFFSET  Var1
        INT 21h
        
        LEA DX, Var2
        INT 21h
        
        LEA DX, Var3
        INT 21h
        
   MOV  AH, 4Ch
   INT  21h
END Inicio