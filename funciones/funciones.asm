; funciones asm
sys_exit 	equ 		1
sys_read 	equ 		3
sys_write 	equ 		4
stdin 		equ 		0 
stdout 		equ 		1	
stderr 		equ 		3


strlen:
	push EBX ; salvamos el valor de ebx
	mov EBX, EAX ; copiamos la direccion de donde esta
sigcar:
	cmp byte[EAX],0 ; comparamos el byte en el que esta
	 jz finalizar ; jump if zero

	 inc EAX ; incfremento en 1
	 jmp sigcar ; salto incodicional al 
finalizar: 
	sub EAX , EBX ; restamos al vvalor incial
	pop EBX ; Establecer ebx
	ret ; regresar al punto en el que salto/
;;;;;;;;;;;;;;;;;;;;;;;;;;;;; van juntos compa;;;;;;;;;;;;;;;;;;;;;;;;;;;;
sprint:
	push EDX 		; salvamos valor de edx
	push ECX 		; salvamos el valor de ecx
	push EBX 		; salvamos el valor de ebx
	push EAX 		; salvamos el valor de eax
	call strlen

	mov EDX, EAX 	; movemos la longitud de eax 
	pop EAX 		; traemos el stack de la direccion
	mov ECX, EAX 	; la direccion del mnesaje
	mov EAX, stdout		; descriptor de archivos stdout
	mov EAX, sys_write 		; sys_write
	int 80h 		; ejecuta

	pop EBX 		; re-establecemos EBX
	pop ECX 		; re-establecemos ECX
	pop EDX 		; re-establecemos EDX
	ret

sprintLF:
	call sprint 	;llama e imprime el mensaje 
	push EAX 		;salvamos EAX, vamos a
	mov EAX, 0xA	; hex para enter
	push EAX		; salvamos el 0xA en el Eax
	mov EAX, ESP 	; lo que apunta ESP a EAX
	call sprint 	; imprimimos el LF
	pop EAX			; recuperamos el caracter 0xa
	pop EAX			; recuperamos el valor original
	ret 			; return

iprintLF:
	call iprint 	; imprimios el numero
	push EAX		; salvamos el dato que traemos en ele stack

	mov EAX, 0xA	; copaimos el line feed a eax
	push EAX		; salvamos line feed
	mov EAX, ESP 	;copiamos el apuntador del stack 
	call sprint 	;imprimimos el line feed
	pop EAX			; removemos el linefeed del stack
	pop EAX 		; restablecemos le dato que traimaos
	ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;; van juntos compa;;;;;;;;;;;;;;;;;;;;;;;;;;;;
iprint:
	push 	EAX 	; salvamos eax en el stack (acomulador)
	push 	ECX 	; salvamos exc en el stack(contador)
	push 	EDX 	; salvamos edx en el stack (base)
	push 	ESI 	; salvamos esi en el stach (source index)
	mov 	ECX,0 	; vamos a contar cuantos bytes necesitamos imprimir 

dividirloop:
	inc 	ECX 	; incrementamos en 1 ECX
	mov 	EDX,0	; limpiamos EDX
	mov 	ESI,10 	; guardamos 10 en esi, vamos a dividir entre 10
	idiv 	ESI		; divide eax entre esi
	add 	EDX,48	; agraga el caracter 49 "0"
	push 	EDX 	; la representacion de ascii de nuestro numero
	cmp 	EAX, 0	; se puede dividir mas el numero entero?
	jnz 	dividirloop ; jump if not zero

imprimirloop:
	dec 	ECX 	; vamos a contar hacia abajo cada byte en el stack
	mov 	EAX,ESP	; apuntador del stack a eax
	call 	sprint 	; llamamos a la funcion sprint
	pop 	EAX 	;removemos el ultimo caracter del stack
	cmp 	ECX,0 	;ya imprimimos todos los valores del stack?
	jnz 	imprimirloop ; todavia hay numeros que imprimir?
	pop 	ESI		; restablecemos el valor de esi
	pop 	EDX 	; restablecemos el valor de edx
	pop 	ECX		; restablecemos el valor de ECX
	pop 	EAX 	; restablecemos el valor de EAX
	ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;; van juntos compa;;;;;;;;;;;;;;;;;;;;;;;;;;;;



atoi:

	push EBX		;preservamos ebx
	push ECX		;preservamos ecx
	push EDX		;preservamos edc
	push ESI		;preservamos ESI
	mov ESI,EAX		;nuestro numero a convertir va a convertir
	mov EAX,0		;inicializamos a cero eax
	mov ECX,0 		;inicializamos a cero ecx

	ciclomult:
		xor EBX,EBX	; reseteamos a 0 ebx,
		mov bl,[ESI+ECX] ;movemos un solo byte
		cmp bl, 48 		;comparamos con ascii 0
		jl finalizando  ;  si es menor, saltamos a final 
		cmp bl, 57		; comparamos con ascii 9
		jg finalizando ; si es mayor saltamos a finalizando
		cmp bl,10 ;comparamos con linefeed
		je finalizando ; si es igual saltamos a finalizando
		cmp bl, 0 	; comparamos con caracter null
		jz finalizando ; si es cero saltamos a finalizando
		sub bl, 48 	; convertimos el caracter en entero
		add eax, ebx ; agreagamos el calor de eax
		mov ebx,10 	; movemos el valor decimal 10 a ebx
		mul ebx 	; multiplicamos eax por ebc
		inc ecx	; incrementamos ecx(contador)
		jmp ciclomult;seguimos con nuestro ciclo de mult

		finalizando:
		mov ebx,10 	; movemos el balor deciaml 10 a ebx
		div ebx		; dividimos eax entre 10
		pop esi 	; reestablecemos esi
		pop edx		; restablcemos edx
		pop ecx		; restablcemos ecx
		pop ebx 	; restablecemos ebx
		ret
		
quit:
	mov EAX, sys_exit 	; sys_exit

	int 0x80 			; llamada a kernels 