; Captura de datos
; Autor: Germán Alberto Verdugo A
; Fecha: 20/04/17

%include 'funciones.asm'

section .data
	menu DB "**MENU**", 0xA, "1.Capturar Nombre", 0xA, "2.Capturar Edad", 0xA,"3.Imprimir", 0xA,"4.Salir", 0xA,"> ", 0x0
	intn DB "Introduzca su nombre: ", 0x0
	inte DB "Introduzca su edad: ", 0x0

segment .bss
	buffer_opcion resb 20
	buffer_opcion_lon equ $-buffer_opcion

	buffer_nombre resb 20
	buffer_nombre_lon equ $-buffer_nombre

	buffer_edad resb 3
	buffer_edad_lon equ $-buffer_edad

	nombre resb 20
	edad resb 4

section .text
	GLOBAL _start

_start:
	mov EAX, menu
	call sprint

	mov ECX, buffer_opcion
	mov EDX, buffer_nombre_lon 					; Movemos el buffer de la opcion y la longitud del buffer para poder usar la funcion LeerTexto 
	call LeerTexto								; Leemos el texto del usuario

	mov EAX, buffer_opcion 						; Movemos el buffer de la opcion a EAX para convertirlo a entero
	call atoi									; Lo convertimos en entero

	cmp EAX, 1									; Si es 1
	je capturarNombre							; Saltar a capturar nombre

	cmp EAX, 2									; Si es 2
	je capturarEdad								; Saltar a capturar edad

	cmp EAX, 3									; Si es 3
	je imprimir									; Saltar a imprimir

	cmp EAX, 4									; Si es 4
	je quit										; Saltar a salir

	jmp _start 									; Si llego aqui, es que no es igual a ninguna opcion
												; De vuelta al menu

capturarNombre:
	mov EAX, intn 								; Mover el mensaje a EAX
	call sprint									; Imprimir

	mov ECX, buffer_nombre 						; Movemos el buffer del nombre para lectura
	mov EDX, buffer_nombre_lon 					; Movemos la longitud del buffer
	call LeerTexto

	mov EAX, buffer_nombre
	mov ESI, nombre 							; Movemos el nombre a ESI para copiar el texto
	call stringcopy								; Copiamos el texto


	jmp _start 									; Volvemos al menu

capturarEdad:
	mov EAX, inte 								; Mover el mensaje a EAX
	call sprint									; Imprimir el mensaje

	mov ECX, buffer_edad 						; Movemos el buffer de la edad para lectura
	mov EDX, buffer_edad_lon 					; Movemos la longitud del buffer
	call LeerTexto

	mov EAX, buffer_edad
	call atoi									; Convertimos lo capturado a entero

	mov [edad], EAX								; Movemos lo que este en EAX a edad

	jmp _start 									; Volvemos al menu

imprimir:
	mov EAX, nombre 							; Movemos el nombre para imprimirlo
	call sprint									; Imprimimos

	mov EAX, [edad]								; Movemos la edad para imprimirla
	call iprintLF								; Imprimimos

	jmp _start 									; Volvemos al menu
