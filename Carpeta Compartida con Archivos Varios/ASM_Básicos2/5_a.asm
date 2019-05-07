;**************************************************************
; Programa "5_a" Despliegue pantalla e ingresa datos a variables
; declaradas para luego mostrarlas en pantalla con suma-no ascii
;**************************************************************


.MODEL	SMALL				;modelo del programa
                                                       
.STACK	100H

.DATA
        MEN1    DB      'Digite el primer numero ','$'
        MEN2    DB      'Digite el segundo numero ','$'

        VA      DB      '?'
        VB      DB      '?'
	    X       DB      '?'
        Y       DB      '?'

.CODE

        MOV     AX,@DATA
        MOV     DS,AX

        MOV     AH,0
        MOV     AL,3
        INT     10H			; limpiar pantalla

        MOV     X,10        ; carga variables con las coordenadas
        MOV     Y,1
        MOV     AH,2
        MOV     DL,X
        MOV     DH,Y        
        INT     10H          ; coloca cursor para desplegar mensaje

        LEA     DX,MEN1
        MOV	    AH,9
        INT     21H 
	
	    MOV 	AH,01H		; se tiene entrada desde el KB 
	    INT 	21H			; el dato queda en AL
	    MOV 	VA,AL		; se traslada de AL a la memoria (VA)	

	    MOV     X,10
        MOV     Y,2
        MOV     AH,2
        MOV     DL,X
        MOV     DH,Y
        INT     10H         ; coloca cursor para desplegar mensaje
        LEA     DX,MEN2
	    MOV	    AH,9
        INT     21H 

	    MOV 	AH,01H		; se tiene otra entrada desde el KB 
	    INT 	21H
	    MOV 	VB,AL		; el dato se coloca de AL a memoria (VB)


    ;SE DESPLIEGA CONTENIDO DE LAS VARIABLES

	    MOV     AH,0
        MOV     AL,3
        INT     10H
       

	    MOV     X,5
        MOV     Y,5
	    MOV     AH,2
        MOV     DL,X
        MOV     DH,Y
        INT     10H         ; coloca cursor para desplegar mensaje
        
        ;se emplea el despligue de UN caracter, no una cadena
        
        MOV 	DL,VA		; se coloca en DL porque asi lo requiere 
	    MOV 	AH,2	    ; el servicio 02H de la INT 21H
	    INT 	21H
	
	    MOV     X,15
        MOV     Y,5
	    MOV     AH,2
        MOV     DL,X
        MOV     DH,Y
        INT     10H         ; coloca cursor para desplegar mensaje
	
	    MOV 	DL,VB		; nuevamente en DL para desplegar
	    MOV 	AH,2
	    INT 	21H

	    MOV     X,17
        MOV     Y,5
	    MOV     AH,2
        MOV     DL,X
        MOV     DH,Y
        INT     10H  
	
	    ; se realiza algun proceso a las variables
	
	    MOV 	DL,VB
	    add     dl,va
	
	
	    MOV 	AH,2
	    INT 	21H
	
	    MOV	    AH,7	;Espera tecla por medio del DOS
	    INT	    21H


	    MOV 	AH,4CH   	; VUELTA AL
        INT 	21H      	; DOS

END					; fin del programa	



