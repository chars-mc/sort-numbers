; Programa:  Ordenar números
; Objetivo: Elaborar un programa en ensamblador usando macros con un menú de 3 opciones:
;           Que solicite al usuario 20 números
;              1. Los ordene de menor a mayor, 
;              2. los muestre ordenados de mayor e menor. 
;              3. Salir.


INCLUDE macros.lib ; Incluir ó importar la libreria de macros
.MODEL SMALL      ; Definir modelo de memoria

.DATA             ; Segmento de datos
   welcomeMsg     DB 13, 10, '     Bienvenido!', 13, 10, '$'               ; Mensaje de bienvenida
   enterNumber    DB '  >> Ingrese numeros de "2" digitos (NO PRESIONE ENTER)', 13, 10, '$' ; Instrucción
   menuOptions    DB ' <1> Ordenar de mayor a menor', 13, 10
                  DB ' <2> Ordenar menor a mayor', 13, 10
                  DB ' <3> Ingresar otros numeros', 13, 10
                  DB ' <4> Salir', 13, 10, 13, 10
                  DB '  >> Ingrese una opcion: $'
   getNumberMSG   DB '  >  Ingrese un numero: $'
   error          DB '  >  Ingrese una opcion valida! (1 - 3) $'  ; Mensaje de error
   borrar         DB '                                        $'  ; Espacios en blanco
   space          DB ' $'           ; Espacio en blanco
   endLine        DB 13, 10, '$'    ; Salto de línea
   userNumbers    DB '[NUMBERS]: $'
   opt1           DB ' Numeros orden descendente >>>>>>>>>>>>>>>> $' ; Detalles sobre la opción 1
   opt2           DB ' Numeros orden ascendente  <<<<<<<<<<<<<<<< $' ; Detalles sobre la opción 2

   unidad         DB 0           ; Almacena la unidad de un número
   decena         DB 0           ; Almacena la decena de un número
   number         DB 0           ; Almacena la unidad y decena
   numbers        DB 20 DUP(0)   ; Arreglo de números

.CODE    ; Segmento de código
   START:            ; Etiqueta de comienzo del programa
      mov ax, @DATA  ; Inicializa DS con la dirección de @DATA
      mov ds, ax     ; Mueve AX a DS
      push ds        ; Pone DS a al pila
      pop es         ; Saca ES de la pila

      clearScreen
      showMessage welcomeMsg  ; Muestra mensaje de bienvenida

      mov si, 0   ; Posición del arreglo
      mov cx, 20  ; Cantidad de iteraciones
      showMessage enterNumber ; Muestra el mensaje para ingrsar números
      
   GETNUMBERS:                   ; Otiene los números ingresados por el usuario
      showMessage getNumberMSG   ; Muestra el mensaje para indicar que ingrese un número
      setNumber                  ; Obtiene los números ingresados y los procesa

      mov numbers[si], al  ; Guarda el número ya procesado y lo guarda en numbers[si], si = índice
      showMessage endLine  ; Imprime un salto de línea
      inc si               ; incrementa SI en 1, si++
      loop GETNUMBERS

      sortNumber            ; Ordena los números una vez terminado el ciclo de obtención de números
      clearScreen             ; Limpia la pantalla
      showMessage welcomeMsg  ; Imprime el mensaje de bienvenida
      showMessage menuOptions ; Imprime el menú de opciones

   GETOPTION:        ; Obtiene la opcion que digitó el usuario
      cursorPos 25, 7   ; Posiciona el cursor 
      mov ah, 0
      int 16h

      eraseLine         ; Borra la línea donde se muestran los mensajes de error
      
      cmp al,31h 	      ; ¿Es igual a 1?
      je OPTION1        ; Si es igual entrar a opcion 1
      cmp al,32h        ; caso contrario, ¿Es igual a 2?
      je OPTION2        ; Si es igual entrar a opcion 2
      cmp al,33h        ; caso contrario, ¿Es igual a 3?
      je START          ; Si es igual, reiniciar el programa
      cmp al,34h        ; caso contrario, ¿Es igual a 4?
      je CLOSEPROGRAM   ; Si es igual, cerar el programa
      jne OPTIONERROR   ; Caso contrario mostrar mensaje de error de opciones

   OPTION1:             ; Ordenar de forma ascendente
      cursorPos 1, 12   ; Posiciona el cursor para imprimir detalles sobre la opción
      showMessage opt1  ; Imprime detalles sobre la opción
      printDescendente  ; Imprime los números de mayor a menor
      jmp GETOPTION     ; Vuelve a la instrucción de ingresar una opción

   OPTION2:          ; Ordenar en orden descendente
      cursorPos 1, 12   ; Posiciona el cursor para imprimir detalles sobre la opción
      showMessage opt2  ; Imprime detalles sobre la opción
      printAscendente   ; Imprime los números de menor a mayor
      jmp GETOPTION     ; Vuelve a la instrucción de ingresar una opción

   OPTIONERROR:      ; Si el usuario ingresa una opción no válida se muestra un mensaje de error y regresa al menu
      showError      ; Mostrar mensaje de error
      jmp GETOPTION  ; Salta a al instrucción GETOPTION para que el usuario ingrese nuevamente una opción
   
   CLOSEPROGRAM:  ; Limpia la pantalla y cierra el programa
      clearScreen
      exitProgram ; Cierra el programa
   
   .STACK
END START