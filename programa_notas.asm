%include "linux64.inc"
section .data

	variable:  db ?

	msj_1: db "Bienvenido al registro de Notas. Si desea ver la lista por orden ALFABETICO presione #1. Si desea ver la lista por orden de NOTA presione #2, si desea ver las nota en un HISTOGRAMA	presione #3:     " ,0xa
	msj1_tam: equ $-msj_1

	msj_2: db "Usted presiono la tecla:    " ,0xa
	msj2_tam: equ $-msj_2

	msj_3: db "Fin del Programa. ",0xa
	msj3_tam: equ $-msj_3

	msj_4: db "Usted solicito ver por orden ALFABETICO",0xa
	msj4_tam: equ $-msj_4

	msj_5: db "Usted solicito ver por orden de NOTAS",0xa
	msj5_tam: equ $-msj_5

	msj_6: db "Usted solicito ver el HISTOGRAMA",0xa
	msj6_tam: equ $-msj_6

	filename db "lista_est.txt",0

section .bss
	text resb 4096
section .text
	global _start
	global _start_read
	global _ingreso
	global _solicitud
	global _imp_Alfa
	global _imp_Notas
	global _imp_Histo
	global _validacion
	global _mostrar
	global _fin
_start: 
	mov rax,1
	mov rdi,1
	mov rsi,msj_1
	mov rdx,msj1_tam
	syscall


	jmp _ingreso

_ingreso:   ;pedimos solicitud
	mov rax,0
	mov rdi,0
	mov rsi,variable
	mov rdx,1
	syscall

	xor rax,rax
 _solicitud: ;se comprueba lo que se solicito
	
	cmp byte [variable], '1'  ; Comparamos con '1' para la opción 1
	je _imp_Alfa        ; Si es igual a '1', saltamos a la etiqueta _solicitud_Alfa
	cmp byte [variable], '2'  ; Comparamos con '2' para la opción 2
	je _imp_Notas       ; Si es igual a '2', saltamos a la etiqueta _solicitud_Notas
	cmp byte [variable], '3'  ; Comparamos con '3' para la opción 3
	je _imp_Histo 
	jmp _start

_imp_Alfa:
	mov rax,1
	mov rdi,1
	mov rsi,msj_4
	mov rdx,msj4_tam
	syscall
	

	jmp  _start_read
_imp_Notas:
	mov rax,1
	mov rdi,1
	mov rsi,msj_5
	mov rdx,msj5_tam
	syscall


	jmp  _start_read
_imp_Histo:
	mov rax,1
	mov rdi,1
	mov rsi,msj_6
	mov rdx,msj6_tam
	syscall

	jmp _start_read
	
_start_read:
; Open the file
	mov rax, SYS_OPEN
	mov rdi, filename
	mov rsi, O_RDONLY
	mov rdx, 0
	syscall

;read from the file
	push rax
	mov rdi, rax
	mov rax, SYS_READ
	mov rsi, text
	mov rdx,4096 
	syscall

;close the file
	mov rax, SYS_CLOSE
	pop rdi
	syscall
	print text
	jmp _fin

_fin:
	mov rax,1
	mov rdi,1
	mov rsi,msj_3
	mov rdx,msj3_tam

	mov rax,60
	mov rdi,0
	syscall
