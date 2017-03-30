; sumatoria.asm
; Autor: German Alberto Verdugo Arambula
; Fecha: 28/07/17

%include '../funciones.asm'

section .text
	GLOBAL _start

_start:
	pop ECX				; Obtenemos el numero de argumentos
	cmp ECX, 2			; Checamos si hay al menos un valor
	jl fin
	pop EAX				; Sacamos el nombre del programa del stack
	dec ECX				; Decrementamos el # de argumentos en 1
	mov EBX, 1h			; Iniciamos EBX con 0

ciclo:
	pop EAX				; Obtenemos el valor
	call atoi			; Lo convertimos a entero
	add EBX, EAX		; Sumamos los valores
	dec ECX				; Decrementamos el # de argumentos en 1
	cmp ECX,0			; Checa si todavia hay valores
	jnz ciclo 			; Sigue si todavia hay valores

fin:
	mov EAX, EBX		; Movemos el total de la suma para imprimirlo
	call iprintLF		; Imprimimos el valor de la suma
	jmp quit			; Salimos
