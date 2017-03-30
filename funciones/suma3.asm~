; suma_variables.asm

%include 'funciones.asm'

section .data
	numero1	DD 543		; numero entero
	cadena1	DB "789",0x0	; cadena de numeros
	numero2	DD 888		; numero entero

section .text
	GLOBAL _start			; punto de entrada

_start:
	mov EAX,cadena1		; cadena a convertir
	call atoi				; convertir a entero
	mov EBX,[numero1]		; guardamos en suma el numero
	add EAX,EBX			; sumamos sum y numero1
	mov EBX,[numero2]		; sumamos sum y numero2
	add EAX,EBX			; movemos el contenido de la suma a EAX
	call iprintLF			; imprimos el entero
	jmp quit
  