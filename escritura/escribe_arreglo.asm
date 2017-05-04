; escribe_archivo.asm
; Autor: Germán Alberto Verdugo
; Fecha: 03/05/17

%include '../funciones.asm'

section .data
	menu db "**MENU**", 0xA, "1.Nombre del archivo", 0xA, "2.Nombre de los alumnos", 0xA, "3.Ver alumnos", 0xA, "4.Salir", 0xA, "> ", 0x0
	P_num db "¿Numero de alumnos? (max 10) >", 0x0
	P_nombre db "¿Nombre alumno? > ", 0x0
	P_archivo db "¿Nombre archivo? > ", 0x0

segment .bss
	buffer_alumno resb 30
	len_alumno equ $-buffer_alumno

	buffer_opcion resb 4
	len_opcion equ $-buffer_opcion

	buffer_filename resb 30
	len_filename equ $-buffer_filename

	buffer_num resb 6
	len_num equ $-buffer_num

	filename resb 30
	len_filename equ $-filename

	array_alumnos resb 300
	alumno resb 30
	num_alumnos resb 6
	opcion resb 4

	archivo resb 30

section .text
	GLOBAL _start

_start:
	mov EAX, menu
	call sprint

	mov ECX, buffer_opcion
	mov EDX, len_opcion
	call LeerTexto

	; Toda esta sección esta dedicada a convertir de manera segura el buffer
	; a un entero
	mov EAX, buffer_opcion
	mov ESI, opcion
	call copystring

	mov EAX, opcion
	call atoi

	; Opciones
	cmp EAX, 1
	je get_filename

	cmp EAX, 2
	je get_alumnos

	cmp EAX, 3
	je show_alumnos

	cmp EAX, 4
	je salir

	jmp _start

get_filename:
	mov EAX, P_archivo
	call sprint

	mov EDX, buffer_filename
	mov ECX, len_filename
	call LeerTexto

	mov EAX, buffer_filename
	mov ESI, filename
	call copystring

	jmp _start

get_alumnos:
.get_num_alumnos:
	mov EAX, P_num
	call sprint

	mov EDX, buffer_num
	mov ECX. len_num
	call LeerTexto

	mov EAX, buffer_num
	mov ESI, num_alumnos
	call copystring

	mov EAX, num_alumnos
	call atoi

	cmp EAX, 10
	jg salir

	mov ESI, array_alumnos
	mov ECX, num_alumnos
	mov EDX, ECX

	push EDX

.ciclo:
	push ECX

	mov EAX, P_nombre
	call sprint

	mov EDX, buffer_alumno
	mov ECX, len_alumno
	call LeerTexto

	mov EAX, buffer_alumno
	call copystring

	pop ECX
	add ESI, 30
	dec ECX
	cmp ECX, 0
	jne .ciclo
	pop EDX
	mov ECX, EDX
	mov ESI, array_alumnos

. escritura:
	mov EAX, ESI