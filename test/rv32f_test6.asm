addi x10, x0, 1
addi x11, x0, 2
addi x12, x0, 3
addi x13, x0, -4
fcvt.s.w f0, x10
fcvt.s.w f1, x11
fcvt.s.w f2, x12
fcvt.s.w f3, x13
fdiv.s f4, f1, f3
fsub.s f5, f2, f3
fsub.s f6, f0, f4
