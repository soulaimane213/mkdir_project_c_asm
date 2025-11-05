section .data

	create_error_msg db "we cannot create this folder => ", 0
	create_error_msg_len equ $ - create_error_msg
	
	usage_error_msg db "usage :mkdir folderName", 0
	usage_error_msg_len equ $ - usage_error_msg

	succes_msg db "mkdir: created directory => ", 0
	succes_msg_len equ $ - succes_msg
	
	v_flag db "-v", 0
	newline db 10 


section .text
global _start
_start:

	mov rdi , [rsp] ; taking the argument counter
	lea rsi , [rsp + 16]; taking the argv and store the addres in rsi
	cmp rdi , 1
	je usage_label
	dec rdi 
	call _main
	jmp program_end_sucsses


;strlen fucntion
strlen:
    ; RDI = pointer to string
    mov     rax, rdi          ; copy pointer to RAX (we'll count from here)
.loop:
    cmp     byte [rax], 0     ; check if current byte == 0
    je      .done             ; if yes, end
    inc     rax               ; move to next char
    jmp     .loop             ; repeat
.done:
    sub     rax, rdi          ; length = end_ptr - start_ptr
    ret




;strcmp fucntion
section .text
global strcmp

strcmp:
    ; RDI = s1
    ; RSI = s2

.loop:
    mov     al, [rdi]        ; load byte from s1
    mov     bl, [rsi]        ; load byte from s2
    cmp     al, bl           ; compare the two bytes
    jne     .not_equal       ; if not equal → return -1
    test    al, al           ; check if end of string (al == 0)
    je      .equal           ; if both ended → return 0
    inc     rdi              ; move to next char in s1
    inc     rsi              ; move to next char in s2
    jmp     .loop

.not_equal:
    mov     eax, -1
    ret

.equal:
    xor     eax, eax         ; return 0
    ret

;main fucntion
_main:

	push rbp
	mov rbp , rsp
	sub rsp , 48
	
	;storing the variables in the stack
	mov qword [rbp - 8]  , rdi ;saving the argc
	mov qword [rbp - 16] , rsi ;saving the argv
	mov qword [rbp - 24] , 0   ;saving the flag
	mov qword [rbp - 32] , 0   ;saving the end of the loop if there is a flag
	
	mov r9 , 0
	mov r12 , [rbp - 16] ; moving the arg in r12	

	;add r12 , 8; go to the argument[1] 
	mov rdi , [r12]
	mov rsi , v_flag
	call strcmp
	cmp rax , 0 ; is the comparaison true
	je set_flag
	jmp continue
set_flag:
	mov r9 , 1
	mov byte [rbp - 24]  , 1 ;setting the v_flag to 1
	mov byte [rbp - 32] , 1; moving by 1
	add r12 , 8
	jmp main_loop	

continue:
	mov r12 , [rbp - 16]
	mov r9 , 0

main_loop:
	cmp r9 , [rbp - 8] ; cmp r10 with argc
	je main_loop_done
	;calling mkdir syscall
	mov rax , 83 ; the syscall number
	mov rdi , [r12]; the path of the folder
	mov rsi , 493 ; the modes(permisions)
	syscall
	cmp rax , 0
	jl creat_error_label
	cmp byte [rbp - 24] , 1
	je print_succes_msg
	add r12 , 8
	inc r9
	jmp main_loop

main_loop_done:
	add rsp , 48
	pop rbp 
	ret


usage_label:
	mov rax , 1
	mov rdi , 1
	mov rsi , usage_error_msg
	mov rdx , usage_error_msg_len
	syscall
	jmp program_end_fail



print_succes_msg:
	mov rax , 1
	mov rdi , 1
	mov rsi , succes_msg
	mov rdx ,succes_msg_len
	syscall
	
	;call strlen to cal arg len
	mov rdi , [r12]
	call strlen
	mov rdx , rax
		
	;print the name of the folder
	mov rax , 1
	mov rdi , 1
	mov rsi, [r12]
	syscall
	add r12 , 8
	inc r9
	mov rax , 1
	mov rdi , 1
	mov rsi ,newline
	mov rdx , 1
	syscall
	jmp main_loop


creat_error_label:
	mov rax , 1
	mov rdi , 1
	mov rsi , create_error_msg
	mov rdx , create_error_msg_len
	syscall
	
	mov rdi , [r12]
	call strlen
	mov rdx , rax
	;print the name of the argument that failed
	mov rax , 1
	mov rdi , 1
	mov rsi , [r12]
	syscall
	

program_end_fail:
	mov rax , 60
	mov rdi , 1
	syscall

program_end_sucsses:
	mov rax , 60
	mov rdi , 0
	syscall
