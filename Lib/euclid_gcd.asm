section .text
global euclid_gcd

; Implementation of basic Euclidean GCD algorithm
euclid_gcd:
  test rsi, rsi
  jz DONE
LOOP:                  ; at start of each loop: rdi holds a, rsi holds b
  xor rdx, rdx         ; rdx = 0;
  mov rax, rdi         ; rax = a
  div rsi              ; rdx = a % b
  mov rdi, rsi         ; rdi = b
  mov rsi, rdx         ; rsi = a%b
  test rsi, rsi        ; check if b == 0
  jnz LOOP             ; if b != 0, return to LOOP
DONE:
  mov rax, rdi         ; return a
  ret



