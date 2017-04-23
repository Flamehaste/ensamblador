; arreglo_promedio.asm
; autor: Germán Alberto Verdugo
; fecha: CEASE YOUR RESISTACE

%include '../funciones.asm'

segment .bss
	array resb 100				; Se esperan que los numero sean de cuatro bytes, maximo 25 argumentos
	num_arg resb 4

section .text
	GLOBAL _start

_start:
	pop ECX						; Numero de argumentos
	cmp ECX, 2					; Hay almenos un valor
	jl finavg					; Manda al final si es que no hay valor
	
	pop EAX						; Saca el nombre del ejecutable del stack
	dec ECX						; Decrementamos el numero de objetos en el stack en 1
	mov [num_arg], ECX			; Movemos el valor actual de ECX a num_arg (numero de argumentos)
	mov EDX, 0					; Movemos 0 a EDX, ya que servira como indice del arreglo en el siguiente apartado
	mov ESI, array 				; movemos los 100 bytes reservados a ESI

ciclo:
	pop EAX						; obtenemos el argumento actual como una cadena
	call atoi					; lo convertimos a entero
	mov [ESI + EDX * 4], EAX	; guardamos el entero de 4 bytes en el array
	inc EDX						; incrementamos el indice en EDX (numero de enteros en el arreglo)
	dec ECX						; decrementamos el indice en ECX (numero de argumentos restantes)
	cmp ECX, 0					; checamos si nos quedan argumentos
	jne ciclo 					; regresa al ciclo si no es asi
	mov ECX, [num_arg]			; movemos a EDX el numero de enteros en el arreglo
	mov EBX, 0					; EBX sera donde guardamos la suma de los enteros dentro del arreglo
								; EBX empezara en 0

impresion:
	mov EAX, [ESI + ECX * 4]	; movemos los numeros del arreglo a EAX empezando desde el ultimo
	add EBX, EAX				; acumulamos en EBX
	dec ECX						; decrementamos el numero de enteros en el arreglo
	cmp ECX, 0					; checamos si nos quedan enteros en el arreglo
	jge impresion 				; regresamos si todavia quedan numeros
	mov EDX, 0					; dejamos a EDX en 0 para poder dividir
	mov EAX, EBX				; movemos la sumatoria a EAX
	mov EBX, [num_arg]			; movemos a EBX el numero total de enteros
	idiv EBX					; dividimos EAX + EDX entre EBX
	call iprintLF				; imprimimos el entero

finavg:
	jmp quit					; salimos del programa
