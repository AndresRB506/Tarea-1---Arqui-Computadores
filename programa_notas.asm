section .data

	variable:  db ?

	msj_1: db "Bienvenido al registro de Notas. Si desea ver la lista por orden ALFABETICO presione #1. Si desea ver la lista por orden de NOTA presione #2, si desea ver las nota en un HISTOGRAMA	presione #3:" ,0xa
	msj1_tam: equ $-msj_1

	msj_2: db "Usted presiono la tecla:" ,0xa
	msj2_tam: equ $-msj_2

	msj_3: db "Fin del Programa."
	msj3_tam: equ $-msj_3

	msj_4: db "Usted solicito ver por orden ALFABETICO"
	msj4_tam: equ $-msj_4

	msj_5: db "Usted solicito ver por orden de NOTAS"
	msj5_tam: equ $-msj_5

	msj_6: db "Usted solicito ver el HISTOGRAMA"
	msj6_tam: equ $-msj_6
section .text
	global _start
global _ingreso
global _solicitud_Alfa
global _solicitud_Notas
global _solicitud_Histo
global _retorno_soli
global _imp_alfa
global _imp_nota
global _imp_histo
global _validacion
global _mostrar
global _fin
_start: 
	mov rax,1
	mov rdi,1
	mov rsi,msj_1
	mov rdx,msj1_tam
	syscall
_ingreso:   ;pedimos solicitud
	mov rax,0
	mov rdi,0
	mov rsi,variable
	mov rdx,1
	syscall
 _solicitud_Alfa: ;se comprueba si se solicito lista por orden alfabetico
	cmp rsi,1
	je _imp_alfa

_solicitu_Notas:  ;se comprueba si se quieren ver por orden nota
	cmp rsi,2
	je _imp_nota

_solicitud_Histo: ;se comprtueba si se solicito histograma
	cmp rsi,3
	je _imp_histo
_retorno_soli: ;solicitud invalida se pide nueva solicitud
	jmp _start
_imp_alfa:
	mov rax,1
	mov rdi,1
	mov rsi,msj_4
	mov rdx,msj4_tam
	syscall
	jmp _validacion
_imp_nota:
	mov rax,1
	mov rdi,1
	mov rsi,msj_5
	mov rdx,msj5_tam
	syscall
	jmp _validacion
_imp_histo:
	mov rax,1
	mov rdi,1
	mov rsi,msj_6
	mov rdx,msj6_tam
	syscall
	jmp _validacion
_validacion:
	mov rax, 1
	mov rdi, 1
	mov rsi, msj_2
	mov rdx, msj2_tam
	syscall
_mostrar:
	mov rax,1
	mov rdi,1
	mov rsi,variable
	mov rdx,1
	syscall

_fin:
	mov rax,1
	mov rdi,1
	mov rsi,msj_3
	mov rdx,msj3_tam

	mov rax,60
	mov rdi,0
	syscall
