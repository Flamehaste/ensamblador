; ftoc.asm
; Convierte el argumento dado de fahrenheit a centigrados
; Autor: Germán Alberto Verdugo Arámbula
; Fecha: 30/03/17

%include '../funciones.asm'

section .data
	neam DB "No hay suficientes argumentos", 0x0
	msg DB " C°", 0x0

section .text
	GLOBAL _start

_start:
	pop ECX			; Obtenemos el # de argumentos
	cmp ECX, 2		; Minimo 2 argumentos (el nombre del archivo y lo que se quiere convertir)
	jl nea 			; Salta a nea(Not Enough Arguments)
	pop EAX			; No necesitamos el nombre del archivo, lo sacamos del stack
	pop EAX			; Obtenemos el valor en fahrenheit que se quiere convertir
	call atoi		; Convertimos el valor a entero
	call ftoc		; Llamamos a la funcion ftoc para convertirlo
	call iprint		; Imprimimos el resultado
	mov EAX, msg 	; Movemos la unidad de medida a EAX
	call sprintLF	; imprimimos la unidad de medida
	jmp quit		; Salimos

nea:
	mov EAX, neam 	; Movemos el mensaje a EAX
	call sprintLF	; Lo imprimimos
	jmp quit		; Salimos
