; otro "Hola mundo" pero esta vez
; con dos strings

section .data
	msj1 DB 'Hola, mundo!',0xA,0x0	;primer mensaje a imprimir
	len1 EQU $ - msj1				;longitud del primer string
	msj2 DB 'desde ensamblador',0xA	;segundo mensaje a imprimir
	len2 EQU $ - msj2				;longitud del segundo string 

section .text						;requerido por el linker
	GLOBAL _start 					;punto de partida
_start:
	mov EDX,len1					;longitud del primer mensaje
	mov ECX,msj1					;primer mensaje
	mov EBX,1						;stdout
	mov EAX,4						;sys_write
	int 0x80						;llamar al kernel
	mov EDX,len2					;longitud del segundo mensaje
	mov ECX,msj2					;segundo mensaje
	mov EBX,1						;stdout
	mov EAX,4						;sys_write
	int 0x80						;llamar al kernel
	mov EAX,1						;sys_exit
	int 0x80