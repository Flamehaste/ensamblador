; leer_archivo_menu.asm
; Autor: Germán Alberto Verdugo
; Fecha 25/04/17

%include '../funciones.asm'

section .data
	menu DB "**MENU**", 0xA, "1.Leer archivo", 0xA, "2.Mostrar Archivo", 0xA, "3.Salir", 0xA, ">", 0x0
	msgna DB "Introduzca el nombre del archivo: ", 0x0

segment .bss
	buffer_nombre resb 20
	len_nombre equ $-buffer_nombre

	buffer_opcion resb 3
	len_opcion equ $-buffer_opcion

	buffer_archivo resb 2048
	len_archivo equ $-buffer_archivo

	nombre resb 20
	opcion resb 4
	archivo resb 2048

section .text
	GLOBAL _start

_start:
	mov EAX,menu 			; Imprimimos el menu
	call sprint

	mov ECX, buffer_opcion 	; Leemos la entrada del usuario
	mov EDX, len_opcion
	call LeerTexto

	mov EAX, buffer_opcion
	mov ESI, opcion
	call stringcopy

	mov EAX, opcion
	call atoi

	cmp EAX, 1
	je LeerArchivo

	cmp EAX, 2
	je MostrarArchivo

	cmp EAX, 3
	je SalidaMenu

	jmp _start

LeerArchivo:
	mov EAX, msgna
	call sprint

	mov ECX, buffer_nombre
	mov EDX, len_nombre
	call LeerTexto

	mov EAX, buffer_nombre
	mov ESI, nombre

	call copystring

	jmp _start

MostrarArchivo:
	; Abrir archivo
	mov EBX, nombre
	mov EAX, sys_open
	mov ECX, O_RDONLY
	int 0x80

	cmp EAX, 0
	jle error

	; Leer archivo

	mov EBX, EAX
	mov EAX, sys_read
	mov ECX, buffer_archivo
	mov EDX, len_archivo
	int 0x80

	; Cerrar archivo
	mov EAX, sys_close
	int 0x80

	mov EAX, buffer_archivo
	call sprintLF

	jmp _start

SalidaMenu:
	jmp quit

error:
	mov EBX,EAX
	mov EAX,sys_exit
	int 0x80
