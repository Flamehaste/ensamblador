; multiply.asm
; Autor: German Alberto Verdugo Arambula
; 27/03/17

%include 'funciones.asm'

section .text
	GLOBAL _start

_start:
	pop ECX
	pop EAX
	dec ECX
	mov EBX, 1h

ciclo:
	pop EAX
	call atoi
	imul EBX, EAX
	dec ECX
	cmp ECX, 0
	jnz ciclo
	mov EAX, EBX
	call iprintLF
	jmp quit