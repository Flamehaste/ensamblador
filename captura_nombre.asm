; captura_nombre.asm
; Autor: Germán Alberto Verdugo Arámbula
; Fecha: 18/04/2017

%include 'funciones.asm'

section .data
	intn DB "Introduzca su nombre: ", 0x0	; Mensaje de introducción de nombre
	inte DB "Introduzca su edad: ", 0x0		; Mensaje de introducción de edad

segment .bss
	name_buffer resb 20						; Buffer del nombre
	name_buffer_len equ $-name_buffer 		; Lengitud del buffer

	age_buffer resb 3						; Buffer de la edad
	age_buffer_len equ $-age_buffer 		; Lengitud del buffer

	name resb 20							; Nombre
	age	resb 4								; Edad

section .text
	GLOBAL _start

_start:
	mov EAX, intn 							; Mover el mensaje a EAX para imprimirlo
	call sprint								; Imprimir el mensaje
	mov ECX, name_buffer 					; Movemos el buffer del nombre a ECX para leerlo
	mov EDX, name_buffer_len 				; Movemos la longitud a EDX, por la misma razón
	call LeerTexto							; Leemos el texto
	mov EAX, name_buffer 					; Movemos el nombre a EAX
	mov ESI, name 							; Movemos el nombre a ESI para la función stringcopy
	call stringcopy							; Copiamos el nombre

	mov EAX, inte 							; Movemos el mensaje a EAX para imprimirlo
	call sprint								; Imprimimos el mensaje
	mov ECX, age_buffer
	mov EDX, age_buffer_len 				; Movemos age_buffer y age_buffer_len para poder leer
	call LeerTexto							; Leemos el texto
	mov EAX, age_buffer 					; Movemos la edad a EAX
	call atoi								; Lo convertimos a entero
	mov [age], EAX							; Movemos el entero a age

	mov EAX, name
	call sprint								; Imprimimos el nombre
	mov EAX, [age]
	call iprintLF							; Imprimimos la edad

	jmp quit