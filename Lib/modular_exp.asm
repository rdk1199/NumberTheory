section .text
global modular_exp

; Modular exponentiation
; rdi = base
; rsi = power
; rdx = modulus

modular_exp:
  mov r8, rdx ; r8 = modulus
  mov rax, 1  ; rax = return -> starts at 1
LOOP:
  test rsi, 1
  jz FINISH_LOOP
  imul rax, rdi
  xor rdx, rdx
  div r8
  mov rax, rdx
FINISH_LOOP:
  test rsi, rsi
  jz DONE
  shr rsi, 1
  imul rdi, rdi
  xor rdx, rdx    ; mod the base as well
  mov rcx, rax    ; move current result into rcx
  mov rax, rdi    ; move base into rax for div
  div r8          ; divide -> rdx holds the modulo result
  mov rax, rcx    ; -> put the result back in rax 
  mov rdi, rdx    ; -> put mod result in rdi 
  jmp LOOP
DONE:
  ret
