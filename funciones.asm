; functions.asm

sys_exit		equ 1
sys_read		equ 3
sys_write		equ 4
stdin			equ 0
stdout			equ 1
stderr			equ 3


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; function string length (strlen) ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

strlen:
    push ebx            ;save the value of ebx in the stack
    mov ebx, eax        

nextchar:
    cmp byte[eax], 0    ; compare eax with 0
    jz finish           ; if 0 jump to finish
    inc EAX             ; increment in 1 eax
    jmp nextchar        ; goes back

finish:
    sub eax, ebx        ; substract initial value
    pop ebx             ; brings back ebx 
    ret                 ; return to where the function was called
 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; function string print (sprint) ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
sprint:
    push edx            ; save values to stack
    push ecx
    push ebx
    push eax
    call strlen         ; get string length (stored in eax)
    mov edx, eax        ; move length to edx
    pop eax             ; restore eax
    mov ecx, eax        ; move eax (message) to ecx
    mov ebx, stdout      
    mov eax, sys_write  ; sys_write
    int 80h             ; execute
    pop ebx             ; restore other values
    pop ecx
    pop edx
    ret                 ; return to where the function was called


;; uses sprint and adds a new line at the end
sprintLF:
	call sprint 	
 	push EAX 	
 	mov EAX, 0xA
 	push EAX
 	mov EAX, ESP 	
 	call sprint 
 	pop EAX	
 	pop EAX
 	ret 			


;; uses iprint and adds a new line at the end
iprintLF:
	call iprint
 	push EAX 		
 	mov EAX, 0xA	
 	push EAX	
 	mov EAX, ESP 
 	call sprint 	
 	pop EAX		
 	pop EAX	
 	ret 			


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; function to print              ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

iprint:
	push eax		; save register values to the stack
	push ecx
	push edx
	push esi
	mov ecx, 0 		; initialize the counter

divloop:
	inc ecx;		; increment (will be used to print later)
	mov edx, 0		
	mov esi, 10
	idiv esi 
	add edx, 48
	push edx
	cmp eax, 0
	jnz divloop

printloop:
	dec ecx
	mov eax, esp
	call sprint		; call print function
	pop eax			; restore eax after print
	cmp ecx, 0		; keep printing until the end
	jnz printloop	; jump back if not zero
	pop esi			; restore values
	pop edx
	pop ecx
	pop eax
	ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;function to convert ascii to int;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
atoi:
	push ebx		; save registers to the stack
	push ecx
	push edx
	push esi

	mov esi, eax	; number to convert in eax
	mov eax, 0		; initialize with 0
	mov ecx, 0

	multcycle:			; multiplication cycle
	xor ebx, ebx		
	mov bl, [esi+ecx]
	cmp bl, 48
	jl finished
	cmp bl, 57
	jg finished
	cmp bl, 10
	je finished
	cmp bl, 0
	jz finished
	sub bl, 48
	add eax, ebx
	mov ebx, 10
	mul ebx
	inc ecx
	jmp multcycle

	finished:
	mov ebx, 10			; decimal value 10 to ebx
	div ebx				; eax/10
	pop esi				; restore the values
	pop edx
	pop ecx
	pop ebx
	ret

; ftoc
; recibe grados fahrenheit en EAX
; regresa grados en EAX
ftoc:
	sub EAX, 32		; 20h o 0x20
	imul EAX, 5		; multiplicar por 5
	push EDX		; guardamos el valor de EDX en el stack
	mov EDX, 0		; movemos 0 a EDX
	push EBX		; guardamos EBX en el stack
	mov EBX, 9		; movemos 9 a EBX
	div EBX			; dividimos entre EBX
	pop EBX
	pop EDX
	ret

; ctof
; recibe grados centigrados en EAX
; regresa grados en EAX
ctof:
	imul EAX, 9		; multiplicar el valor por 9
	push EDX		; guardamos el valor de EDX en el stack
	mov EDX, 0		; movemos 0 a EDX
	push EBX		; guardamos el valor de EBX en el stack
	mov EBX, 5		; movemos 5 a EBX
	div EBX			; dividimos entre EBX
	pop EBX
	pop EDX
	add EAX, 32		; sumamos 32 a EBX
	ret

; stringcopy
; copia un string de una variable a otra

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

; copystring
; copia un string de una variable a otra

copystring:
	push ECX		; salvamos ECX en el stack
	push EBX
	mov EBX, 0
	mov ECX, 0		; ECX a 0
	mov EBX, EAX	; copiamos la direccion

.sigcar:
	cmp byte[EAX], 0xA
	je .finalizar
	
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

LeerTexto:
	mov EAX, sys_read
	mov EBX, stdin
	int 0x80
	ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; sequence to exit the program   ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
quit:
    mov eax, sys_exit          ; exit program
    int 0x80


