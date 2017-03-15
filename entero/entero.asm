; entero.asm
%include 'funciones.asm'
section .data
    numero DD 543       ; numero entero

section .text
    GLOBAL _start       ; punto de entrada

_start:
    ; Imprimimos el mensaje
    mov EAX,[numero]    ; numero a imprimir
    call iprint         ; Imprimir numero entero
    jmp quit            ; salida