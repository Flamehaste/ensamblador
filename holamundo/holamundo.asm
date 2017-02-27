; holamundo.asm

section .data
	msj DB 'Hola mundo!',0xA,0x0	;mensaje a imprimir
	lon EQU $ - msj 				;longitud del mensaje

section .text						;esta cosa la necesita el linker
	GLOBAL _start					;punto de partida
_start:
	mov EDX,lon 					;longitud del mensaje
	mov ECX,msj 					;mensaje a escribir
	mov EBX,1 						;descriptor del archivo (stdout)
	mov EAX,4 						;numero de llamada del sistema (sys_write)
	int 0x80 						;llamar al kernel
	mov EAX,1 						;numero de llamada del sistema (sys_exit)
	int 0x80 						;llamar al kernel