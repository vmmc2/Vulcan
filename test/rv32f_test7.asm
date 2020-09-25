addi x10, x0, 1
addi x11, x0, 2
addi x12, x0, 3
addi x13, x0, 4
fcvt.s.w f0, x10
fcvt.s.w f1, x11
fcvt.s.w f2, x12
fcvt.s.w f3, x13
fdiv.s f5, f0, f2
fmul.s f6, f5, f2
addi x15, x0, 5
fcvt.s.w f30, x15
fdiv.s f31, f30, f1
