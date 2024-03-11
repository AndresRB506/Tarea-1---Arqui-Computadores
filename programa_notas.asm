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
	filename2 db "lista_ordenada.txt"
	zero    db 0x30
	one     db 0x31
    	two     db 0x32
    	three   db 0x33
    	four    db 0x34
    	five    db 0x35
    	six     db 0x36
    	seven   db 0x37
    	eight   db 0x38
   	 nine    db 0x39
	separate    db 0xa, '-------------', 0xa, 0
	separate_tam  equ $ - separate
	eof     db 0x3
   	nulo    db 0x0
	finLinea db 0xA


section .bss
	text resb 4096
	text2 resb 8192
	text_tam equ $-text
	text2_tam equ $-text2
	grades          resb 200  
	primera_linea  resb 100
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
	mov rdx, text_tam
	syscall

;close the file
	mov rax, SYS_CLOSE
	pop rdi
	syscall

	call leerText

verificacion:
    ;print ordered student list
    print text

    mov rax, SYS_WRITE
    mov rdi, 1
    lea rsi, [separate]
    mov rdx, separate_tam
    syscall

    ; exit the program
    mov rax, SYS_EXIT
    xor rdi, rdi
    syscall

string2integer:
    ;main function to convert string into integer
    imul r10, r10, 10
    call  string0
    add  r10, r12
    ret

string0:
    mov r12, 0
    cmp r9b, [zero]
    je  return_true
    jmp string1

string1:
    mov r12, 1
    cmp r9b, [one]
    je  return_true
    jmp string2

string2:
    mov r12, 2
    cmp r9b, [two]
    je  return_true
    jmp string3


string3:
    mov r12, 3
    cmp r9b, [three]
    je  return_true
    jmp string4

string4:
    mov r12, 4
    cmp r9b, [four]
    je  return_true
    jmp string5
    

string5:
    mov r12, 5
    cmp r9b, [five]
    je  return_true
    jmp string6
    

string6:
    mov r12, 6
    cmp r9b, [six]
    je  return_true
    jmp string7
    

string7:
    mov r12, 7
    cmp r9b, [seven]
    je  return_true
    jmp string8

string8:
    mov r12, 8
    cmp r9b, [eight]
    je  return_true
    jmp string9

string9:
    mov r12, 9
    ret

return_true:
    ;function to use when compare true and want to return
    ret

leerText:
    mov r15, rsi        ;move the pointer of location of my text2 to r15, so rsi can always have the location stored
    call findNumber     ;call function to store the grades into grades memory for later use
    call limpiarRegistros  ;clean the register
    call ordenado           ;call the sorting function
    ordenadoListo:
    call limpiarRegistros
    jmp verificacion

;mensaje de bienvenida
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
	je ordenarNombres
sorted:
	 ;when the file is sorted
	jmp ordenadoListo

_imp_Notas:
	mov rax,1
	mov rdi,1
	mov rsi,msj_5
	mov rdx,msj5_tam
	syscall



	je ordenarNotas
sorted2:
	 ;when the file is sorted
	jmp ordenadoListo

_imp_Histo:
	mov rax,1
	mov rdi,1
	mov rsi,msj_6
	mov rdx,msj6_tam
	syscall
	jmp ordenadoListo

findNumber:
    ;function to find the numbers in the information file
    mov r9b, [r15]
    cmp r9b, [zero]
    je string2integerNota
    cmp r9b, [one]
    je string2integerNota
    cmp r9b, [two]
    je string2integerNota
    cmp r9b, [three]
    je string2integerNota
    cmp r9b, [four]
    je string2integerNota
    cmp r9b, [five]
    je string2integerNota
    cmp r9b, [six]
    je string2integerNota
    cmp r9b, [seven]
    je string2integerNota
    cmp r9b, [eight]
    je string2integerNota
    cmp r9b, [nine]
    je string2integerNota
    cmp r9b, [finLinea]
    je storeGrade
    cmp r9b, [eof]
    je storeGrade
    cmp r9b, [nulo]
    je storeFinalGrade
    inc r15
    jmp findNumber

string2integerNota:
    ;function to convert string to integer for information file
    imul r10, r10, 10
    call  string0
    add  r10, r12
    inc r15
    jmp findNumber

storeGrade:
    ;store the grades into the list in the memory
    mov [grades + r8], r10b
    inc r8
    inc r15
    xor r10,r10
    jmp findNumber

storeFinalGrade:
    ;store the last grade into the list in the last line of the file
    mov [grades + r8], r10b
    xor r10,r10
    ret

ordenado:
	jmp ordenadoListo

ordenarNombres:
    ; Si el método de ordenamiento es alfabético
    call limpiarRegistros
    ; Usando el método de burbuja para ordenar los nombres
    bucleExterno_nombres:
        mov r8, rsi
        mov r9, r8
        call encontrarFinLinea        ; establece r9 al inicio de la línea 2
        inc r9
        xor rcx,rcx         ; reiniciar contador de intercambios
        bucleInterno_nombres:
            mov r10, r8
            mov r11, r9
            call compararNombres   ; compara línea 1 con línea 2
            call actualizar_puntero ; actualiza línea 1 y línea 2
            jmp bucleInterno_nombres
        hecho_comparar_lineas:
        cmp rcx,0
        je ordenado           ; si no se produce ningún intercambio, está ordenado
    jmp bucleExterno_nombres


ordenarNotas:
    ; Si el método de ordenamiento es por notas    
    call limpiarRegistros
    ; Usando el método de burbuja para ordenar el archivo
    bucleExterno_notas:
        mov r8, rsi
        mov r9, r8
        call encontrarFinLinea        ; establece r9 al inicio de la línea 2
        inc r9
        xor rcx,rcx         ; reiniciar contador de intercambios
        mov r13, grades     ; cargar notas en r13 y r15
        mov r15, r13
        inc r15
        bucleInterno_notas:
            call compararNotas
            call actualizar_puntero_numero
            call actualizar_puntero_numero2
            jmp bucleInterno_notas
        hecho_comparar_numeros:
        cmp rcx,0
        je ordenado
    jmp bucleExterno_notas

            
compararNotas:
    ; función para comparar 2 notas
    mov dil, [r13]
    mov dl, [r15]

    cmp dl, [nulo]
    je return_true
    
    cmp dil, dl
    jg intercambiar_numero

    hecho_intercambiar_numero:

    ret

actualizar_puntero_numero2:
    ; función para aumentar los punteros en la lista de notas
    inc r13
    inc r15
    mov dl,[r15]
    cmp dl, [nulo]
    je hecho_comparar_numeros
    ret

intercambiar_numero:
    ; función para intercambiar los números
    mov [r13],dl
    mov [r15],dil
    call  intercambiar_nombre
    jmp hecho_intercambiar_numero


actualizar_puntero_numero:
    ; función para aumentar el puntero al ordenar por notas
    actualizar_puntero_linea1_numero:
        mov r12b,[r8]
        cmp r12b, [finLinea]
        je hecho_actualizar_puntero1_numero
        inc r8
        jmp actualizar_puntero_linea1_numero

    hecho_actualizar_puntero1_numero:
        inc r8
        mov r9, r8
    actualizar_puntero_linea2_numero:
        mov r12b,[r9]
        cmp r12b, [finLinea]
        je hecho_actualizar_puntero2_numero
        cmp r12b, [nulo]
        je hecho_comparar_numeros
        cmp r12b, [eof]
        je hecho_comparar_numeros
        inc r9
        jmp actualizar_puntero_linea2_numero
    hecho_actualizar_puntero2_numero:
        inc r9
    ret

compararNombres:
    ; función para comparar nombres en el archivo
    mov r12b, [r10]
    mov r13b, [r11]

    cmp r12b, [finLinea]     ; si la línea 1 ha terminado
    je return_true
    cmp r12b, [nulo]
    je return_true
    cmp r12b, [eof]
    je return_true   
    cmp r13b, [finLinea]     ; si la línea 2 ha terminado
    je return_true
    cmp r13b, [nulo]
    je return_true
    cmp r13b, [eof]
    je return_true
    
    cmp r13b, r12b      ; devuelve si la línea 2 es mayor que la línea 1
    jg return_true

    cmp r13b, r12b      ; intercambia línea 1 y línea 2 si la línea 2 es menor que la línea 1
    jl intercambiar_nombre
    inc r10
    inc r11
    jmp compararNombres

intercambiar_nombre:
    ; función para intercambiar las líneas
    add rcx, 1
    guardarPrimeraLinea: 
        mov r10,r8
        mov r11,r9
        mov r14,primera_linea
        moverATemporal:
        mov r12b, [r10]
        mov [r14], r12b
        cmp r12b, [finLinea]
        je moverSegundaLinea
        inc r10
        inc r14
        jmp moverATemporal

    moverSegundaLinea:
        mov r10,r8
        mov r11,r9
        moverAPrimera:
        mov r12b, [r11]
        cmp r12b, [nulo]
        je reemplazar_nulo
        mov [r10], r12b
        cmp r12b, [finLinea]
        je recuperarPrimeraLinea
        inc r10
        inc r11
        jmp moverAPrimera  
    
    reemplazar_nulo:
        mov r12b, [finLinea]
        mov [r11], r12b
        jmp moverAPrimera

    recuperarPrimeraLinea:
        mov r14, primera_linea
        inc r10
        moverASegunda:
        mov r12b,[r14]
        mov [r10],r12b
        cmp r12b, [finLinea]
        je return_true
        inc r10
        inc r14
        jmp moverASegunda


actualizar_puntero:
    ; función para aumentar los punteros en las líneas al ordenar por nombres
    actualizar_puntero_linea1:
        mov r12b,[r8]
        cmp r12b, [finLinea]
        je hecho_actualizar_puntero1
        inc r8
        jmp actualizar_puntero_linea1

	hecho_actualizar_puntero1:
        inc r8
        mov r9, r8
    actualizar_puntero_linea2:
        mov r12b,[r9]
        cmp r12b, [finLinea]
        je hecho_actualizar_puntero2
        cmp r12b, [nulo]
        je hecho_comparar_lineas
        cmp r12b, [eof]
        je hecho_comparar_lineas
        inc r9
        jmp actualizar_puntero_linea2
    hecho_actualizar_puntero2:
        inc r9
    ret

encontrarFinLinea:
    ; función para mover el segundo puntero a la segunda línea al inicializar la ordenación
    mov r12b, [r9]
    cmp r12b, [finLinea]
    je return_true
    inc r9
    jmp encontrarFinLinea

limpiarRegistros:
    ; función para limpiar todos los registros utilizados
    xor r8,r8
    xor r9,r9
    xor r10,r10
    xor r11,r11
    xor r12,r12
    xor r13,r13
    xor r14,r14
    xor r15,r15
    xor rdi,rdi
    xor rcx,rcx
    xor rdx,rdx
    ret


_fin:
	mov rax,1
	mov rdi,1
	mov rsi,msj_3
	mov rdx,msj3_tam

	mov rax,60
	mov rdi,0
	syscall
