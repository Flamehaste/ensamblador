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
    call strlen                         ; llama a strlen
    mov EDX,EAX                         ; mueve la longitud (en EAX) a EDX
    mov ECX,msj1                        ; mueve el mensaje
    mov EBX,1                           ; stdout
    mov EAX,4                           ; sys_write
    int 80h                             ; llamada al kernel

    mov EAX,msj2                        ; mueve el mensaje a EAX
    call strlen                         ; llama a strlen
    mov EDX,EAX                         ; mueve la longitud (en EAX) a EDX
    mov ECX,msj2                        ; mueve el mensaje
    mov EBX,1                           ; stdout
    mov EAX,4                           ; sys_write
    int 80h                             ; llamada al kernel

    mov EAX,msj3                        ; mueve el mensaje a EAX
    call strlen                         ; llama a strlen
    mov EDX,EAX                         ; mueve la longitud (en EAX) a EDX
    mov ECX,msj3                        ; mueve el mensaje
    mov EBX,1                           ; stdout
    mov EAX,4                           ; sys_write
    int 80h                             ; llamada al kernel

    mov EBX,0                           ; sale con 0
    mov EAX,1                           ; sys_exit
    int 80h                             ; llamada al kernel

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