addi x9, x0, 9
addi x10, x0, 2
fcvt.s.w f1, x9
fcvt.s.w f2, x10
fdiv.s f3, f1, f2
addi x30, x0, 2

loop:
   fmul.s f3, f3, f3
   addi x30, x30, -1
   bne x30, x0, loop
