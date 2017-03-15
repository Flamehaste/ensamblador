; funciones.asm
sys_exit    equ     1
sys_read    equ     3
sys_write   equ     4
stdin       equ     0
stdout      equ     1
stderr      equ     3

;------------------------------------------
; Funcion String Length (strlen)
; Calcula la longitud de una cadena
; Recibe en EAX
;------------------------------------------

strlen:
    push EBX                            ; salvamos el valor de EBX
    mov EBX, EAX                        ; copiamos la dirección

sigcar:
    cmp byte[EAX], 0                    ; comparamos el byte que apunta a EAX con 0 
    jz finalizar                        ; JUMP if Zero, salta a la etiqueta finalizar
    inc EAX                             ; incrementamos por 1 el valor en EAX
    jmp sigcar                          ; salto incondicional a la etiqueta sigcar

finalizar:
    sub EAX,EBX                         ; restamos al valor inicial EBX
    pop EBX                             ; establecer EBX
    ret                                 ; regresa al punto en cual llamaron a strlen

;------------------------------------------
; Funcion String Print (sprint)
; Recibe direccion de cadena en EAX
;------------------------------------------

sprint:
  push EDX                            ;------------------------------------------
  push ECX                            ; Guardamos los valores de estas direcciones
  push EBX                            ; en memoria para poder usarlas en la función
  push EAX                            ;------------------------------------------
  call strlen                         ; Llama a la función strlen para obtener la longitud de la cadena
    
  mov EDX,EAX                         ; Mueve la longitud a EDX
  pop EAX                             ; La cadena anteriormente guardada en EAX es recuperada del stack
  mov ECX,EAX                         ; Se mueve la cadena a EAX
  mov EBX,stdout                      ; stdout
  mov EAX,sys_write                   ; sys_writeđ
  int 80h                             ; llamada al kernel

  pop EBX                             ;------------------------------------------
  pop ECX                             ; Devuelven los valores en el stack a estas direcciones
  pop EDX                             ;------------------------------------------
  ret                                 ; Vuelve al punto donde llamaron a sprint

;------------------------------------------
; sprintLF imprimir en una nueva linea
;------------------------------------------
sprintLF:
  call sprint
  push EAX
  mov EAX,0xA
  push EAX
  mov EAX,ESP
  call sprint

; funcion iprintlf (integer print) o impresion de enteros
iprintLF:
  call iprint             ; imprimimos el numeros
  push EAX                ; guardamos el valor de EAX
  mov EAX,0xA             ; movemos un final de linea a EAX
  push EAX                ; guardamos el final de linea al stack
  mov EAX, ESP            ; copiamos el apuntador del stack a EAX
  call sprint             ; imprimimos el salto de linea
  pop EAX                 ; removemos el linefeed del stack
  pop EAX                 ; re-establecemos el valor de EAX
  ret                     ; regresamos

iprint:
  push EAX                ; salvamos EAX en el stack (acumulador)
  push ECX                ; salvamos ECX en el stack (contador)
  push EDX                ; guardamos el valor de EDX
  push ESI                ; valor de ESI
  mov ECX,0               ; establecemos ECX como 0

dividirloop:
  inc ECX                 ; Incrementamos en 1 ECX
  mov EDX,0               ; Limpiamos EDX
  mov ESI,10              ; asignamos 10 a ESI
  idiv esi
  add EDX,48
  push EDX
  cmp EAX,0
  jnz dividirloop

imprimirloop:
  dec ECX                 ; vamos a contar hacia abajo cada byte en el stack
  mov EAX,ESP             ; apuntador del stack a EAX
  call sprint             ; llamamos a la función sprint
  pop EAX                 ; removemos el ultimo caracter del stack
  cmp ECX,0               ; ya imprimimos todos los bytes del stack?
  jnz imprimirloop        ; todavia hay numeros que imprimir?
  pop esi                 ; re-establecemos el valor de ESI
  pop EDX                 ; re-establecemos el valor de EDX
  pop ECX                 ; re-establecemos el valor de ECX
  pop EAX                 ; re-establecemos el valor de EAX
  ret                     ; regresamos

; ASCII a entero
atoi:
  push EBX                ; preservamos EBX
  push ECX                ; preservamos ECX
  push EDX                ; preservamos EDX
  push ESI                ; preservamos ESI
  mov ESI,EAX             ; nuestro numero a convertir va a ESI
  mov EAX,0               ; inicializamos a cero EAX
  mov ECX,0               ; inicializamos a cero ECX

ciclomult:                ; ciclo de multiplicacion
  xor EBX,EBX             ; reseteamos a 0 EBX
  mov bl,[ESI+ECX]        ; movemos un solo byte
  cmp bl,48               ; comparamos con un ASCII 0
  jl  finalatoi           ; si es menor, saltamos al final
  cmp bl,57               ; comparamos con ASCII 9
  jg finalatoi            ; si es mayor, saltamos al final
  cmp bl,10               ; comparamos con un salto de linea
  je finalatoi            ; si es igual, saltamos al final
  cmp bl,0                ; comparamos con un caracter null
  jz finalatoi            ; si es igual a cero, saltamos al final
  sub bl,48               ; convertimos el caracter en un entero
  add EAX,EBX             ; agregamos el valor a EAX
  mov EBX,10              ; movemos el decimal 10
  mul EBX                 ; multiplicamos EAX por EBX
  inc ECX                 ; incrementamos ECX
  jmp ciclomult           ; seguimos nuestro ciclo de multiplicacion

finalatoi:
  mov EBX,10		  ; movemos el valor decimal 10 a EBX
  div EBX		  ; dividimos EBX entre 10
  pop ESI
  pop EDX
  pop ECX
  pop EBX
  ret

;------------------------------------------
; Función quit
; Sale del programa
;------------------------------------------

quit:
    mov EBX,0                           ; sale con 0
    mov EAX,sys_exit                    ; sys_exit
    int 80h                             ; llamada al kernel 
