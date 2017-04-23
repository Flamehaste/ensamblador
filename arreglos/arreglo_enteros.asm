; Arreglo enteros
; Autor: Germán Alberto Verdugo Arámbula
; Fecha 06/04/17

%include '../funciones.asm'

segment .bss
	array RESB 100

section .text
	GLOBAL _start

_start:
	pop ECX
	cmp ECX, 2
	jl salida
	cmp ECX, 26
	jg salida
	pop EAX
	dec ECX
	mov EDX, ECX
	mov ESI, array

; Pasar los miembros de los argumentos a el arreglo
ciclo:
	pop EAX
	call atoi
	mov [ESI], EAX
	ADD ESI, 4
	dec ECX
	cmp ECX, 0
	jne ciclo
	mov ECX, EDX
	mov ESI, array

impresion:
	mov EAX, [ESI]
	call iprintLF
	add ESI, 4
	dec ECX
	cmp ECX, 0
	jne impresion

salida:
	jmp quit

