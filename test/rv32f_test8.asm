addi x10, x0, 1
addi x11, x0, 2
addi x12, x0, 3
addi x13, x0, 4
addi x14, x0, 1000
fcvt.s.w f0, x10
fcvt.s.w f1, x11
fcvt.s.w f2, x12
fcvt.s.w f3, x13
fcvt.s.w f4, x14
fdiv.s f6, f0, f4 # f6 = 0.001
fadd.s f6, f0, f6
fmax.s f10, f0, f6
