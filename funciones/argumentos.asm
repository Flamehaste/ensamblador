; programa: argumentos.asm
; autor: Germán Alberto Verdugo Arámbula
; fecha: 16/03/2017
%include 'funciones.asm'

section .text
  GLOBAL _start		; le damos al linker el punto de entrada

_start:			; punto de entrada
  pop ecx		; obtenemos numero de argumentos

ciclo:
  pop eax		; obtenemos argumentos
  call sprintLF		; imprimimos el argumento

  dec ecx		; restamos 1 al numero de argumentos
  cmp ecx,0		; checamos si es el ultimo argumento
  jnz ciclo		; repetir si no es el ultimo argumento
			; si es el ultimo...
  call quit		; salir

