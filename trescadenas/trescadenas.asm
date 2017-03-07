; trescadenas.asm
; autor: Germán Alberto Verdugo
; fecha: 06/Marzo/2017

section .data
    msj1 db "¡Hola mundo!",0xA,0x0      ; primer mensaje
    msj2 db "Hello world!",0xA,0x0      ; segundo mensaje
    msj3 db "Salut monde!",0xA,0x0      ; tercer mensaje

section .text
    global _start                       ; punto de inicio

_start:
    mov EAX,msj1                        ; mueve el mensaje a EAX
    call sprint                         ; imprime la cadena

    mov EAX,msj2                        ; mueve el mensaje a EAX
    call sprint                         ; imprime la cadena

    mov EAX,msj3                        ; mueve el mensaje a EAX
    call sprint                         ; imprime la cadena

    call exit

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
    mov EBX,1                           ; stdout
    mov EAX,4                           ; sys_write
    int 80h                             ; llamada al kernel

    pop EBX                             ;------------------------------------------
    pop ECX                             ; Devuelven los valores en el stack a estas direcciones
    pop EDX                             ;------------------------------------------
    ret                                 ; Vuelve al punto donde llamaron a sprint

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
; Función exit
; Sale del programa
;------------------------------------------

exit:
    mov EBX,0                           ; sale con 0
    mov EAX,1                           ; sys_exit
    int 80h                             ; llamada al kernel