%include '../funciones.asm'

section .data
  numero	DD 543		; numero entero
  cadena	DB "783",0x0	; cadena de numeros

section .text
  GLOBAL _start			; punto de entrada

_start:
; imprimimos 1er mensaje
  mov EAX, [numero]		; imprimir entero a EAX
  call iprintLF			; Imprimir numero entero
  
  mov EAX, cadena		; cadena de numeros a convertir
  call atoi			; convertimos el numero
  call iprintLF			; y lo imprimimos

  call quit
