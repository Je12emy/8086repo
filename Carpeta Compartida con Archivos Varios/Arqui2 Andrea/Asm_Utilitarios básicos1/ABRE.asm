 ; ********************************************************************
    ; *  -----------------//////////////////////////------------------      *
    ; *  LA utilidad ABRE, sirve para visualizar el contenido de un archivo.*
    ; *  El programa puede abrir hasta 2000 caracteres de un Fichero .
    ; *  Es una utilidad sencilla, estudiada paso a paso con el Debug del DOS
    ; *  En ella se puede aprender el desarrollo del  programa .
    ; *  Fue ensamblado con:
    ; *  Microsoft (R) Macro Assembler Version 6.15.8803
    ; *  Copyright (C) Microsoft Corp 1981-2000.  
    ; *  Se usa: ML [ opciones ] lista de Ficheros  [ /link opciones de linkado]
    ; *  ejecutar "ML /help" or "ML /?" para más información
    ; *  se abre un fichero de texto que llamado HILARIO.TXT                                            *
    ; ********************************************************************
 .MODEL SMALL
 .STACK
 .DATA
 ContieneHandle          DW    0        ; ContieneHandle de control del fichero
;HANDLE
;A lo largo de la historia del msdos, han existido varios métodos para acceder
;al disco.En las antiguas versiones del DOS, las más utilizadas eran los famosos
;FCBs :Bloques de Control de Fichero.Este sistema requería la utilización de unas
;tablas llamadas como digimos FCBs.
;Es decir,cuando un programa necesita acceder a un fichero debe de preparar
;una de estas tablas que comprenden 37 bytes, y que contine varios campos , básicamente
;11 campos ejemplo:
;+00 Número de dispositivo
;+01 Nombre del archivo
;.
;.
;.
;Hasta la 21h en donde se fijan el número de bloques de datos para acceso libre
;El problema básico de las BCBs es que sólo puede acceder a ficheros que se encuentren
;en el directorio actual.
;Las funciones HANDLE TIENEN LA VENTAJA  de que no es necesario preparar una
;estructura de datos de la forma de un FCB, análogamente a las funciones del
;Sistema operativo UNIX, el acceso a un archivo se realiza  en un principio
;por su nombre, este se transfiere  a la función para abrir un archivo en forma
;de cadena ASCII , terminada con un carácter NULL.
;Existen numerosas funciones handle, nosotros aquí utilizaremos la 3D,4C abrir Y
;cerra archivo respectivamente.


;Reservamos memoria para mensajes y Datos.

     EntradaDelFichero       DB    13,10,"INTRODUCE EL NOMBRE DEL FICHERO: $"
     MensajeDeMostramosError DB    13,10," MostramosError.Mira si has escrito bien el fichero ***",13,10,10,"$"
     GuardarEntradaTeclado   DB    80 DUP (0)   ; BufferLeerDisco para leer desde el teclado
     BufferLeerDisco         DB    2000 DUP (0) ;   "     "     "     "  el disco
     BufferLeerDisco2        db    2 dup(0)

  .CODE

     ComenzandoElCodigo:
    MOV AX,@DATA
    MOV DS,AX
;***********************************************************************
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;Al desensamblar esta parte de código, vemos como se inicializa Ds
    ;y cómo quedan los datos en memoria.
    ;C:\ENSAMB~1\EJEMPLOS>DEBUG ABRE.EXE -->Este es el directorio en
    ;donde yo tenía el programa ensamblado.
;-T

;AX=0D2E  BX=0000  CX=092E  DX=0000  SP=0400  BP=0000  SI=0000  DI=0000
;DS=0D16  ES=0D16  SS=0DB9  CS=0D26  IP=0003   NV UP EI PL NZ NA PO NC
;0D26:0003 8ED8          MOV     DS,AX
;-T

;AX=0D2E  BX=0000  CX=092E  DX=0000  SP=0400  BP=0000  SI=0000  DI=0000
;DS=0D2E  ES=0D16  SS=0DB9  CS=0D26  IP=0005   NV UP EI PL NZ NA PO NC
;0D26:0005 8D160400      LEA     DX,[0004]                        DS:0004=0A
;Le pasamos a dx el contenido [EntradaDelFichero], es decir: DX,[0004]
;-T

;AX=0D2E  BX=0000  CX=092E  DX=0004  SP=0400  BP=0000  SI=0000  DI=0000
;DS=0D2E  ES=0D16  SS=0DB9  CS=0D26  IP=0009   NV UP EI PL NZ NA PO NC
;0D26:0009 B409          MOV     AH,09
;-D DS:0
;0D2E:0000  21 00 00 00 0D 0A 49 4E-54 52 4F 44 55 43 45 20   !.....INTRODUCE
;0D2E:0010  45 4C 20 4E 4F 4D 42 52-45 20 44 45 4C 20 46 49   EL NOMBRE DEL FI
;0D2E:0020  43 48 45 52 4F 3A 20 24-0D 0A 20 45 72 72 6F 72   CHERO: $.. MostramosError
;0D2E:0030  2E 4D 69 72 61 20 73 69-20 68 61 73 20 65 73 63   .Mira si has esc
;0D2E:0040  72 69 74 6F 20 62 69 65-6E 20 65 6C 20 66 69 63   rito bien el fic
;0D2E:0050  68 65 72 6F 20 2A 2A 2A-0D 0A 0A 24 00 00 00 00   hero ***...$....
;0D2E:0060  00 00 00 00 00 00 00 00-00 00 00 00 00 00 00 00   ................
;0D2E:0070  00 00 00 00 00 00 00 00-00 00 00 00 00 00 00 00   ................

 ;*******************************************************************************
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                   LEA   DX,EntradaDelFichero  ;Lo que hacemos con estas instrucciones
                   MOV   AH,9                  ;es pasar a la pantalla, el contenido
                   INT   21h                   ;de la memoria, apuntado por EntradaDelFichero


;Fijaros en el siguiente tramo tramo desensamblado
;que corresponde a:
                   ;LEA   DX,GuardarEntradaTeclado       
                   ;MOV   BYTE PTR [GuardarEntradaTeclado],80
                   ;MOV   AH,10   función de entrada por el teclado
                   ;INT   21h

;Lo que hacemos es apuntar con GuardarEntradaTeclado a 0D2E:005D
;pasndo 3C=60, que son los caracteres que permitiremos para el nombre
;del fichero en longitud.
;En este caso hemos introducido el Fichero: Hilario.txt por el teclado.
;Este nombre tiene 11 letras que sería OB el resto del desplazamiento
;corresponde al nombre.
;AX=0924  BX=0000  CX=092E  DX=005C  SP=0400  BP=0000  SI=0000  DI=0000
;DS=0D2E  ES=0D16  SS=0DB9  CS=0D26  IP=0016   NV UP EI PL NZ NA PO NC
;0D26:0016 B40A          MOV     AH,0A
;-p

;AX=0A24  BX=0000  CX=092E  DX=005C  SP=0400  BP=0000  SI=0000  DI=0000
;DS=0D2E  ES=0D16  SS=0DB9  CS=0D26  IP=0018   NV UP EI PL NZ NA PO NC
;0D26:0018 CD21          INT     21
;-p
;hilario.txt
;AX=0A0D  BX=0000  CX=092E  DX=005C  SP=0400  BP=0000  SI=0000  DI=0000
;DS=0D2E  ES=0D16  SS=0DB9  CS=0D26  IP=001A   NV UP EI PL NZ NA PO NC
;0D26:001A 8A1E5D00      MOV     BL,[005D]                          DS:005D=0B
;Al ver el contenido de la memoria del ordenador, comprobamos
;como el conjunto DS:DX apuntan al nombre del fichero

;-d ds:5c
;0D2E:0050                                      3C 0B 68 69               <.hi
;0D2E:0060  6C 61 72 69 6F 2E 74 78-74 0D 00 00 00 00 00 00   lario.txt.......
;0D2E:0070  00 00 00 00 00 00 00 00-00 00 00 00 00 00 00 00   ................
;0D2E:0080  00 00 00 00 00 00 00 00-00 00 00 00 00 00 00 00   ................
;0D2E:0090  00 00 00 00 00 00 00 00-00 00 00 00 00 00 00 00   ................
;0D2E:00A0  00 00 00 00 00 00 00 00-00 00 00 00 00 00 00 00   ................
;0D2E:00B0  00 00 00 00 00 00 00 00-00 00 00 00 00 00 00 00   ................
;0D2E:00C0  00 00 00 00 00 00 00 00-00 00 00 00 00 00 00 00   ................
;0D2E:00D0  00 00 00 00 00 00 00 00-00 00 00 00               ............

                   LEA   DX,GuardarEntradaTeclado        ; Puntero a la dirección para la entrada
                   MOV   BYTE PTR [GuardarEntradaTeclado],60  ; Fijamos los 60 caracteres
                   MOV   AH,10  ; función de entrada de teclado
                   INT   21h  ; LLamar a la interrupción del DOS
;***************************************************************************
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Ahora vamos a analizar el tramo de código siguiente:
                   ;MOV   BH,0              ; Para  BX
                   ;ADD   BX,OFFSET GuardarEntradaTeclado ; apuntar al final
                   ;MOV   BYTE PTR [BX+2],0 ; ponemos  un cero al final NULL

;AX=0A0D  BX=000B  CX=092E  DX=005C  SP=0400  BP=0000  SI=0000  DI=0000
;DS=0D2C  ES=0D14  SS=0DB7  CS=0D24  IP=001E   NV UP EI PL NZ NA PO NC
;0D24:001E B700          MOV     BH,00
;-t

;AX=0A0D  BX=000B  CX=092E  DX=005C  SP=0400  BP=0000  SI=0000  DI=0000
;DS=0D2C  ES=0D14  SS=0DB7  CS=0D24  IP=0020   NV UP EI PL NZ NA PO NC
;0D24:0020 81C35C00      ADD     BX,005C
;-t

;AX=0A0D  BX=0067  CX=092E  DX=005C  SP=0400  BP=0000  SI=0000  DI=0000
;DS=0D2C  ES=0D14  SS=0DB7  CS=0D24  IP=0024   NV UP EI PL NZ AC PO NC
;0D24:0024 C6470200      MOV     BYTE PTR [BX+02],00                DS:0069=0D
;-t

;AX=0A0D  BX=0067  CX=092E  DX=005C  SP=0400  BP=0000  SI=0000  DI=0000
;DS=0D2C  ES=0D14  SS=0DB7  CS=0D24  IP=0028   NV UP EI PL NZ AC PO NC
;0D24:0028 8D165E00      LEA     DX,[005E]                          DS:005E=696
;-t

;AX=0A0D  BX=0067  CX=092E  DX=005E  SP=0400  BP=0000  SI=0000  DI=0000
;DS=0D2C  ES=0D14  SS=0DB7  CS=0D24  IP=002C   NV UP EI PL NZ AC PO NC
;0D24:002C B000          MOV     AL,00
;-d ds:5e
;0D2C:0050                                            68 69                 hi
;0D2C:0060  6C 61 72 69 6F 2E 74 78-74 00 00 00 00 00 00 00   lario.txt.......
;0D2C:0070  00 00 00 00 00 00 00 00-00 00 00 00 00 00 00 00   ................
;0D2C:0080  00 00 00 00 00 00 00 00-00 00 00 00 00 00 00 00   ................
;0D2C:0090  00 00 00 00 00 00 00 00-00 00 00 00 00 00 00 00   ................
;0D2C:00A0  00 00 00 00 00 00 00 00-00 00 00 00 00 00 00 00   ................
;0D2C:00B0  00 00 00 00 00 00 00 00-00 00 00 00 00 00 00 00   ................
;0D2C:00C0  00 00 00 00 00 00 00 00-00 00 00 00 00 00 00 00   ................
;0D2C:00D0  00 00 00 00 00 00 00 00-00 00 00 00 00 00         ..............
;-

                   MOV   BL,[GuardarEntradaTeclado+1]    ; Esta es la longitud efectiva tecleada
                   MOV   BH,0              
                   ADD   BX,OFFSET GuardarEntradaTeclado ; apuntamos  al final
                   MOV   BYTE PTR [BX+2],0 ; ponemos el cero al final
;*******************************************************************
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;AX=0A00  BX=0067  CX=092E  DX=005E  SP=0400  BP=0000  SI=0000  DI=0000
;DS=0D2C  ES=0D14  SS=0DB7  CS=0D24  IP=002E   NV UP EI PL NZ AC PO NC
;0D24:002E B43D          MOV     AH,3D
;-t

;AX=3D00  BX=0067  CX=092E  DX=005E  SP=0400  BP=0000  SI=0000  DI=0000
;DS=0D2C  ES=0D14  SS=0DB7  CS=0D24  IP=0030   NV UP EI PL NZ AC PO NC
;0D24:0030 CD21          INT     21
;-p

;AX=0005  BX=0067  CX=092E  DX=005E  SP=0400  BP=0000  SI=0000  DI=0000
;DS=0D2C  ES=0D14  SS=0DB7  CS=0D24  IP=0032   NV UP EI PL NZ AC PO NC
;0D24:0032 723A          JB      006E ;El salto no es efectivo,porque
                                      ;hay presencia de un fichero llamado
                                      ;Hilario.txt
;-t
;En AX=0005, TENEMOS EL HANDLE
;AX=0005  BX=0067  CX=092E  DX=005E  SP=0400  BP=0000  SI=0000  DI=0000
;DS=0D2C  ES=0D14  SS=0DB7  CS=0D24  IP=0034   NV UP EI PL NZ AC PO NC
;0D24:0034 A30200        MOV     [0002],AX                          DS:0002=0000
;Movemos el handle al puntero ContieneHandle, como véis :MOV     [0002],AX



                   LEA   DX,GuardarEntradaTeclado+2    ; offset 
                   MOV   AL,0              ; Lo abrimos para  lectura
                   MOV   AH,3Dh            ; Esta función nos abrirá el fichero
                   INT   21h               ; Y ahora llamamos al DOS
                   JC    MostramosError     ; Mirando los flags si CF=1 Mostrariamos un error
                   MOV   ContieneHandle,AX   ; En el buffer reservado guardamos
                                             ;el handle, para futuras utilizaciones
;*****************************************************************************
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 ;CODIGO DE ACCESO AL FICHERO

   LeemosElFichero: MOV   BX,ContieneHandle ;Movemos a BX el handle contenido en Contiene Hanndle        
                   MOV   CX,2000           ; 2000 será el número de bytes a leer
                   LEA   DX,BufferLeerDisco         ; dirección del BufferLeerDisco
                   MOV   AH,3Fh            ; Esta función es para leer del fichero
                   INT   21h               ; Y aquí llamamos  al DOS
                   JC    MostramosError    ;Si el flag  CF=1 --> MostramosError
                   MOV   CX,AX             ; bytes leídos realmente
                   JCXZ  CerramosElFichero  ;Si es 0 leidos entonces no hay nada que i
                   PUSH  AX                ; preservarmos ax en La Pila
                   LEA   BX,BufferLeerDisco  ; imprimir BufferLeerDisco ...

;AX=0005  BX=0067  CX=092E  DX=005E  SP=0400  BP=0000  SI=0000  DI=0000
;DS=0D2C  ES=0D14  SS=0DB7  CS=0D24  IP=0037   NV UP EI PL NZ AC PO NC
;0D24:0037 8B1E0200      MOV     BX,[0002]                          DS:0002=0005
;-t

;AX=0005  BX=0005  CX=092E  DX=005E  SP=0400  BP=0000  SI=0000  DI=0000
;DS=0D2C  ES=0D14  SS=0DB7  CS=0D24  IP=003B   NV UP EI PL NZ AC PO NC
;0D24:003B B90008        MOV     CX,0800
;-t

;AX=0005  BX=0005  CX=0800  DX=005E  SP=0400  BP=0000  SI=0000  DI=0000
;DS=0D2C  ES=0D14  SS=0DB7  CS=0D24  IP=003E   NV UP EI PL NZ AC PO NC
;0D24:003E 8D16AC00      LEA     DX,[00AC]                          DS:00AC=0000
;-t

;AX=0005  BX=0005  CX=0800  DX=00AC  SP=0400  BP=0000  SI=0000  DI=0000
;DS=0D2C  ES=0D14  SS=0DB7  CS=0D24  IP=0042   NV UP EI PL NZ AC PO NC
;0D24:0042 B43F          MOV     AH,3F
;-t

;AX=3F05  BX=0005  CX=0800  DX=00AC  SP=0400  BP=0000  SI=0000  DI=0000
;DS=0D2C  ES=0D14  SS=0DB7  CS=0D24  IP=0044   NV UP EI PL NZ AC PO NC
;0D24:0044 CD21          INT     21
;-p

;AX=0022  BX=0005  CX=0800  DX=00AC  SP=0400  BP=0000  SI=0000  DI=0000
;DS=0D2C  ES=0D14  SS=0DB7  CS=0D24  IP=0046   NV UP EI PL NZ AC PO NC
;0D24:0046 7226          JB      006E
;-t
;AX=0022  BX=0005  CX=0800  DX=00AC  SP=0400  BP=0000  SI=0000  DI=0000
;DS=0D2C  ES=0D14  SS=0DB7  CS=0D24  IP=0048   NV UP EI PL NZ AC PO NC
;0D24:0048 8BC8          MOV     CX,AX
;-t

;AX=0022  BX=0005  CX=0022  DX=00AC  SP=0400  BP=0000  SI=0000  DI=0000
;DS=0D2C  ES=0D14  SS=0DB7  CS=0D24  IP=004A   NV UP EI PL NZ AC PO NC
;0D24:004A E314          JCXZ    0060
;-t

;AX=0022  BX=0005  CX=0022  DX=00AC  SP=0400  BP=0000  SI=0000  DI=0000
;DS=0D2C  ES=0D14  SS=0DB7  CS=0D24  IP=004C   NV UP EI PL NZ AC PO NC
;0D24:004C 50            PUSH    AX
;-t

;AX=0022  BX=0005  CX=0022  DX=00AC  SP=03FE  BP=0000  SI=0000  DI=0000
;DS=0D2C  ES=0D14  SS=0DB7  CS=0D24  IP=004D   NV UP EI PL NZ AC PO NC
;0D24:004D 8D1EAC00      LEA     BX,[00AC]                DS:00AC=454D

;DS:00AC=454D <---Con esta indicación el debug nos dice que en esa
;posición está contenido 454D

;Los valores de los registros parecen no coincidir, y esto es que
;he vuelto a desensamblar el programa, y lo he reanudado en donde lo dejé
;el día anterior.Significa esto que algunos segmentos del registro se
;han modificado.
;No obstante, podeís ver como la dirección:0D2E:00B0, apunta
;al mensaje que se encuentra en el fichero abierto Hilario.txt


;0D2E:00B0                 45 4C 20-43 4F 44 49 47 4F 20 45        EL CODIGO E
;0D2E:00C0  4E 53 41 4D 42 4C 41 44-4F 52 20 45 53 20 49 4D   NSAMBLADOR ES IM
;0D2E:00D0  41 47 49 4E 41 54 49 56-4F 20 59 20 50 4F 54 45   AGINATIVO Y POTE
;0D2E:00E0  4E 54 45 00 00 00 00 00-00 00 00 00 00 00 00 00   NTE.............
;0D2E:00F0  00 00 00 00 00 00 00 00-00 00 00 00 00 00 00 00   ................
;0D2E:0100  00 00 00 00 00 00 00 00-00 00 00 00 00 00 00 00   ................
;0D2E:0110  00 00 00 00 00 00 00 00-00 00 00 00 00 00 00 00   ................
;0D2E:0120  00 00 00 00 00 00 00 00-00 00 00 00 00 00 00 00   ................
;0D2E:0130  00 00 00 00 00                                    .....


;**************************************************************************
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SacamosPorPantalla: MOV   DL,[BX]        ; carácter a carácter
                    MOV   AH,2              ; ir llamando al servicio 2 del
                    INT   21h               ; DOS para imprimir en pantalla
                    INC   BX                ; siguiente carácter
                    LOOP  SacamosPorPantalla           ; acabar caracteres
                    POP   AX                ; recuperar nº de bytes leídos
                    CMP   AX,2000           ; ¿leidos 2000 bytes?
                    JE    LeemosElFichero           ; sí, leer otro LeemosElFichero más
;En este tramo del programa comenzaremos a poner en pantalla el contenido
;apuntado en el tramo anterior . Observar, como al desensamblar la primera letra
;que aparece es la apuntada por 0D2E:00B0.Ver las posiciones en memoria
;del tramo anterior:

;AX=002E  BX=00B5  CX=002E  DX=00B5  SP=03FE  BP=0000  SI=0000  DI=0000
;DS=0D2E  ES=0D16  SS=0DB7  CS=0D26  IP=0051   NV UP EI PL NZ AC PO NC
;0D26:0051 8A17          MOV     DL,[BX]                            DS:00B5=45
;-t

;AX=002E  BX=00B5  CX=002E  DX=0045  SP=03FE  BP=0000  SI=0000  DI=0000
;DS=0D2E  ES=0D16  SS=0DB7  CS=0D26  IP=0053   NV UP EI PL NZ AC PO NC
;0D26:0053 B402          MOV     AH,02
;-t

;AX=022E  BX=00B5  CX=002E  DX=0045  SP=03FE  BP=0000  SI=0000  DI=0000
;DS=0D2E  ES=0D16  SS=0DB7  CS=0D26  IP=0055   NV UP EI PL NZ AC PO NC
;0D26:0055 CD21          INT     21
;-p
;E <---Carárcter que aparece en la consola apuntado en : 0D2E:00B0

;AX=0245  BX=00B5  CX=002E  DX=0045  SP=03FE  BP=0000  SI=0000  DI=0000
;DS=0D2E  ES=0D16  SS=0DB7  CS=0D26  IP=0057   NV UP EI PL NZ AC PO NC
;0D26:0057 43            INC     BX

;Para seguir poniendo caracteres en la pantalla, bastará repetir el bucle
;LOOP  "SacamosPorPantalla". Fijaros como va disminuyendo el contador CX, a medida
;que el bucle se va repitiendo.El valor de CX, viene dado por el número de caracteres
;encontrados en el fichero.

;*****************************************************************************
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Bueno, este tramo sería redundante el colocarlo en formato debug
;En el recuperamos el handle del fichero abierto, y lo cerramos
;como se indica en el código.

CerramosElFichero: MOV   BX,ContieneHandle  ;Handle de acceso al fichero hilario.txt
                   MOV   AH,3Eh            ; CerramosElFichero 
                   INT   21h               ; Llamaremos  al DOS
                   JC    MostramosError
                                           ; sI EL FLAG CF = 1, QUE ESTARÍA EN CY --> MostramosError
                   MOV AH,4CH
                   INT   21h               ; Y llegamos al fin del programa

MostramosError:    LEA   DX,MensajeDeMostramosError     ;  MostramosError
                   MOV   AH,9              ; función de escribir en consola
                   INT   21h               ; Llamaremos al DOS
                   CMP   ContieneHandle,0  ;Coparamos si el handle está 0 "!fichero abierto"!
                   JNE   CerramosElFichero
                   MOV AH,4CH            ; sí: CerramosElFicherolo
                   INT 21H                ; Y fin del programa
                   END ComenzandoElCodigo
                   
;*************************************************************************
;*************************************************************************

;COMANDOS DEL DEBUG.EXE
;assemble     A [dirección]
;compare      C intervalo de direcciones
;dump         D [intervalo]
;enter        E dirección [lista]
;fill         F lista de rango
;go           G [=dirección] [direcciones]
;hex          H valor1 valor2
;input        I puerto
;load         L [dirección] [unidad] [primer sector] [número]
;move         M intervalo de direcciones
;name         N [ruta] [lista de argumentos]
;output       O byte de puerto
;proceed      P [=dirección] [número]
;quit         Q
;register     R [registro]
;search       S lista de rango
;trace        T [=dirección] [valor]
;unassemble   U [intervalo]
;write        W [dirección] [unidad] [primer sector] [número]
;allocate expanded memory        XA [N.páginas]
;deallocate expanded memory      XD [identificador]
;ap expanded memory pages       XM [páginaL] [páginaP] [identificador]
;display expanded memory status  XS

;***********************************************************************
;***********************************************************
