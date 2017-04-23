; Arreglo cadenas
; Autor: Germán Alberto Verdugo Arámbula
; Fecha 05/04/17

%include '../funciones.asm'

segment .bss
	array resb 20

section .text
	GLOBAL _start

_start:
	pop ECX			; Numero de argumentos
	cmp ECX, 2		; comparamos si es menor a dos
	jl salida 		; jump if less
	
	pop EAX			; sacar el nombre del ejecutable
	dec ECX			; decrementamos
	mov EDX, ECX	; movemos el numero de argumentos a EDX
	mov ESI, array 	; movemos el arreglo a ESI

ciclo:
	pop EAX
	call stringcopy
	add ESI, 10
	dec ECX
	cmp ECX, 0
	jne ciclo
	mov ECX, EDX
	mov ESI, array

impresion:
	mov EAX, ESI
	call sprintLF
	add ESI, 10
	dec ECX
	cmp ECX, 0
	jne impresion

salida:
	jmp quit

stringcopy:
	push ECX		; salvamos ECX en el stack
	push EBX
	mov EBX, 0
	mov ECX, 0		; ECX a 0
	mov EBX, EAX	; copiamos la direccion

.sigcar:
	mov BL, byte[EAX]
	mov byte[ESI+ECX], BL
	cmp byte[EAX], 0

	jz .finalizar
	inc EAX
	inc ECX
	jmp .sigcar

.finalizar:
	pop EBX
	pop ECX		; reestablecer ECX
	ret 		; regresar al punto de llamada
