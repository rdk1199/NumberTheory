section .text
global is_power_of_two

; Check if U64 is a power of two
; rdi = n
is_power_of_two:
  popcnt rax, rdi
  cmp rax, 1
  je DONE
  xor rax, rax
DONE:
  ret
  