section .text
global binary_gcd


;Implementation of Stein's binary GCD algorithm
;rdi holds a, rsi holds b
binary_gcd:
  mov rcx, 0   ;keep track of shift amount in rcx 
LOOP:
  test rdi, rdi
  jz DONE
  test rsi, rsi
  jz DONE
  mov r9, rdi
  and r9, rsi
  test r9, 1
  jnz BOTH_ODD
  tzcnt r9, rdi
  tzcnt r10, rsi
  shrx rdi, rdi, r9
  shrx rsi, rsi, r10
  sub r9, r10
  mov r11, r9
  sar r11, 63
  and r11, r9
  add r11, r10
  add rcx, r11
  jmp LOOP
BOTH_ODD:
  mov r9, rdi  ; both odd case  
  sub r9, rsi  ; branchless max (diff & sign bit) - r9 = a-b
  mov r10, r9  ; r10 = a - b
  sar r10, 63  ; r10 = sign bit extension of a-b
  and r10, r9  ; r10 = a < b ? a-b : 0
  add rsi, rdi ; b = a + b
  sub rdi, r10 ; a = max(a, b)
  sub rsi, rdi ; b = a + b - max(a,b) = min(a,b)
  sub rdi, rsi ; a = max(a,b) - min(a,b)
  jmp LOOP
DONE:            ; at least one of the operands is 0
  add rdi, rsi   ; rdi = a + b = a or b (since at least one is 0)
  shl rdi, cl
  mov rax, rdi
  ret
