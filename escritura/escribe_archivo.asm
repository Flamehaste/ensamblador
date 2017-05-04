; escribe_archivo.asm
; Autor: Germán Alberto Verdugo
; Fecha: 27/04/17

%include '../funciones.asm'

section .data
	P_nombre db "¿Nombre alumno? > ", 0x0
	P_archivo db "¿Nombre archivo? > ", 0x0

segment .bss
	buffer_alumno resb 30
	len_alumno equ $-buffer_alumno

	filename resb 30
	len_filename equ $-filename

	archivo resb 30

section .text
	GLOBAL _start

_start:
	mov EAX, P_nombre
	call sprint

	mov ECX, buffer_alumno
	mov EDX, len_alumno
	call LeerTexto

	mov EAX, P_archivo
	call sprint
	
	mov ECX, filename
	mov EDX, len_filename
	call LeerTexto

	mov ESI, archivo
	mov EAX, filename
	call copystring

	; abrir archivo para escritura
	mov EBX, archivo

	; crear archivo
	mov EAX, 8		; sys_create
	mov ECX, 511 	; permisos
	int 0x80
	cmp EAX, 0
	jle error

	mov EAX, sys_open

	mov ECX, O_RDWR
	int 0x80

	cmp EAX, 0
	jle error

	; write
	mov EBX, EAX			; file handle a EBX

	mov EAX, sys_write
	mov ECX, buffer_alumno
	mov EDX, len_alumno
	int 0x80
	mov EAX, 36				; sys_sync
	int 0x80
.salida:
	jmp quit

error:
	mov EBX,EAX
	mov EAX,sys_exit
	int 0x80
