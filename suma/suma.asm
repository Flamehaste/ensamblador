; suma.asm
; suma 2 byte
; autor: German Alberto Verdugo
; fecha: 1/marzo/2017

section .data
	a DB '5'		; declarar a con el valor 5 en ASCII
	b DB '4'		; declarar b con el valor 4 en ASCII

section .bss
	sum resb 1		; declarar sum para guardar la suma

section .text
	global _start	; decirle al linker donde esta el punto de partida

_start:				; punto de partida
	mov EAX,[a]		; mover los valores
	sub EAX,'0'		; restar 0 en ASCII
	mov EDX,[b]		; mover los valores
	sub EDX,'0'		; restar 0 en ASCII
	add EAX,EDX		; sumar ambos numeros, el resultado queda en EAX
	add EAX,'0'		; sumar 0 en ASCII
	mov [sum],EAX	; mover el valor de la suma a sum
	mov ECX,sum		; mover el valor a ECX para imprimir 
	mov EDX,1		; longitud 1
	mov EBX,1		; stdout
	mov EAX,4		; sys_write
	int 0x80		; llamada al kernel
	mov EAX,1		; sys_exit
	mov EBX,0		; sale con 0
	int 0x80		; llamada al kernel