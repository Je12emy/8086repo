.MODEL SMALL       
.STACK 100H

.DATA
 
	MEN1    DB 0AFH,'$'
	MEN2    DB 'digite S para incrementar','$'
	MEN3    DB 0AH,0DH,'Digite B para reducir','$'
	MEN4    DB 0AH,0DH,'Digite F para finalizar','$' 
	MEN5    DB '-20^^^^^-10^^^^^0^^^^^10^^^^^20^^^^^30^^^^^40','$'       
	MEN6    DB ' ','$'  
	MEN7    DB  0AEH,'$'
    X DB 0
    Y DB 0
    
    
.CODE

  INICIO:
  
	 MOV     AX,@DATA
     MOV     DS,AX

     MOV     AH,0
     MOV     AL,3
     INT     10H	
	 LEA     DX,MEN2
     CALL    MENSAJE 
      
     LEA DX ,MEN3 
     CALL    MENSAJE
     LEA DX, MEN4 
     CALL MENSAJE
     
      
     MOV X, 0 
     MOV Y, 12
     CALL MCURSOR  
             
     LEA DX, MEN5 
     CALL MENSAJE 
     
     MOV X , 16
     MOV Y , 11           
     
OTRO: 
      
     CALL MCURSOR 
     CALL TECLAZO
	 CALL COMPARA 
	  
	  
	       
	 
	    
  
   FINAL:  MOV     AH,4CH      
    INT     21H             
    
 
    
COMPARA PROC
        CMP     AH,1FH                  
        JE      SUBE             	
        CMP     AH,30H                  
        JE      BAJA  
        CMP     AH ,21H
        JE      FINAL 
        RET
ENDP           
	     

;***********************PANTALLA*******************************


 
 
MENSAJE PROC
      	MOV	AH,9
        INT     21H                     
        RET
ENDP	  
 


subirABAJO:
        call mcursor 
        
        call mcursor  
        LEA DX,MEN6 
        CALL MENSAJE 
        INC X
        JMP  OTRO
 
bajarARRIBA:
        
        call mcursor 
        LEA DX,MEN6
        CALL MENSAJE
        DEC X
        JMP  OTRO 
SUBE:
        CMP X, 16
        JE  SUBIR
        CMP X,16 
        JB subirABAJO
        cmp x,44
        je noArriba
        
SUBIR:  INC X
        CALL MCURSOR 
        LEA DX , MEN1
        CALL MENSAJE 
        JMP OTRO  
BAJA: 
        CMP X,16 
        JE  BAJAR
        CMP X, 16
        JA bajarARRIBA 
        CMP X,0
        JE  noAbajo
BAJAR:      
             dec x 
            call mcursor 
            lea dx, men7 
            call mensaje 
            jmp otro 
noAbajo: 
        MOV X, 0
        CALL MCURSOR
        JMP OTRO
noArriba: 
          MOV X,44
          CALL MCURSOR
          jmp otro         
            
MCURSOR  PROC
        MOV     AH,2
        MOV     DL,X
        MOV     DH,Y
        INT     10H                     
        RET 
ENDP
LIMPIAR PROC 
        MOV     AH,0			
        MOV     AL,3			
        INT     10H  
        RET
ENDP 

   
    TECLAZO PROC
        MOV AH,00
        INT 16H  
        RET
       ENDP

END

