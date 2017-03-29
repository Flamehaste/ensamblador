; promedio.asm
; Autor: German Alberto Verdugo Arambula
; Fecha: 28/03/17

%include 'funciones.asm'

section .data
	neam DB "No hay suficientes argumentos", 0x0
	msg DB "El promedio es: ", 0x0

segment .bss
	num_arg RESB 4

section .text
	GLOBAL _start

_start:
	pop ECX				; Obtenemos el numero de argumentos
	cmp ECX, 2			; Checamos si hay al menos un valor
	jl nea
	pop EAX				; Sacamos el nombre del programa del stack
	dec ECX				; Decrementamos el # de argumentos en 1
	mov [num_arg], ECX	; Movemos el valor de ECX a num_arg
	mov EBX, 1h			; Iniciamos EBX con 0

ciclo:
	pop EAX				; Obtenemos el valor
	call atoi			; Lo convertimos a entero
	add EBX, EAX		; Sumamos los valores
	dec ECX				; Decrementamos el # de argumentos en 1
	cmp ECX,0			; Checa si todavia hay valores
	jnz ciclo 			; Sigue si todavia hay valores

fin:
	mov EAX, msg 		; Movemos el mensaje del promedio
	call sprint			; Imprimimos
	mov EAX, EBX		; Movemos el total de la suma para imprimirlo
	mov EBX, [num_arg]	; Mover el numero de argumentos al registro EBX
	idiv EBX			; Dividimos entre ECX
	call iprintLF		; Imprimimos el valor de la suma
	jmp quit			; Salimos

nea:					; Not enough arguments
	mov EAX, neam 		; Mensaje de error
	call sprintLF
	jmp quit			; Salimos
