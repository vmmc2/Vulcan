addi x10, x0, 10
addi x11, x0, 11
addi x12, x0, 9
addi x13, x0, 2
fcvt.s.w f0, x10
fcvt.s.w f1, x11
fcvt.s.w f2, x12
fcvt.s.w, f3, x13
fdiv.s f4, f2, f3
fsqrt.s f5, f4
fsub.s f6, f4, f3
fmadd.s f7, f4, f3, f5
fsw f4, 4, x0
addi x30, x0, 4
flw f30, 0, x30
