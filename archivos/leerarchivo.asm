; leerarchivo nombre.txt
; Autor: Germán Alberto Verdugo
; Fecha: 25/04/17

%include '../funciones.asm'

section .data
	sys_open	equ 	5
	sys_close	equ		6
	O_RDONLY	equ		0

segment .bss
	buffer resb 2048
	len equ $-buffer

section .text
	GLOBAL _start

_start:
	pop ECX				; Numero de argumentos
	cmp ECX,2			; Para verificar si existe un argumento
	jl salidalect
	pop EAX				; Nombre del programa
	dec ECX

	; Abrir archivo
	pop EBX				; Nombre del archivo
	mov EAX,sys_open	; Operacion lectura
	mov ECX,O_RDONLY	; O_RDONLY
	int 0x80			; Llamada al sistema

	cmp EAX,0			; Mayor que 0
	jle error			; Si es menor o igual a cero

	; Leer Archivo
	mov EBX,EAX			; Movemos file handle a EBX
	mov EAX,sys_read	; Lectura
	mov ECX,buffer		; Dirección buffer
	mov EDX,len			; Longitud del buffer
	int 0x80			; Llamada al sistema

	; Cerrar Archivo
	mov EAX,sys_close
	int 0x80

	mov EAX,buffer
	call sprintLF

salidalect:
	jmp quit

error:
	mov EBX,EAX
	mov EAX,sys_exit
	int 0x80
