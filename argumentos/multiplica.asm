; multiplica.asm
; Autor: German Alberto Verdugo
; Fecha: 27/03/17

%include '../funciones.asm'

section .text
	GLOBAL _start

_start:
	pop ECX		; sacamos el # de argumentos
	cmp ECX, 3	; compara si es menor a tres
	jl fin 		; jump if less
	pop EAX		; sacamos el nombre del programa

	pop EAX		; primer argumento
	call atoi	; convertimos primer argumento
	mov EBX, EAX	; lo guardamos
	pop EAX		; sacamos el segundo argumento
	call atoi	; convertimos segundo argumento
	imul EAX, EBX	; multiplicamos
	call iprintLF	; imprimimos resultado

fin:
	jmp quit		; salimos
