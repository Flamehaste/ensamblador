; trescadenas.asm
; autor: Germán Alberto Verdugo
; fecha: 08/Marzo/2017

%include 'funciones.asm'

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

    call quit
