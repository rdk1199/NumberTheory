section .text
global binary_gcd


;Implementation of Stein's binary GCD algorithm with exactly one branch
;rdi holds a, rsi holds b
binary_gcd:
  xor rcx, rcx   ;keep track of shift amount in rcx 
LOOP:
  tzcnt r9, rdi    ; deal with all factors of 2
  tzcnt r10, rsi
  shrx rdi, rdi, r9
  shrx rsi, rsi, r10
  sub r9, r10   ; branchless min of trailing zeroes
  mov r11, r9
  sar r11, 63
  and r11, r9
  add r11, r10
  add rcx, r11 ; add that min to the shift amount
  mov r9, rdi  ; now both a,b are odd or zero
  sub r9, rsi  ; branchless max (diff & sign bit) - r9 = a-b
  mov r10, r9  ; r10 = a - b
  sar r10, 63  ; r10 = sign bit extension of a-b
  and r10, r9  ; r10 = a < b ? a-b : 0
  add rsi, rdi ; b = a + b
  sub rdi, r10 ; a = max(a, b)
  sub rsi, rdi ; b = a + b - max(a,b) = min(a,b)
  sub rdi, rsi ; a = max(a,b) - min(a,b)
  test rsi, rsi
  jnz LOOP
DONE:            ; a is the max
  shl rdi, cl
  mov rax, rdi
  ret
