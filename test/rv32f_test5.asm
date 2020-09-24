addi x9, x0, 9
addi x10, x0, 10
addi x11, x0, -2
fcvt.s.w f0, x9
fcvt.s.w f1, x10
fadd.s f2, f0, f1
fcvt.s.w f3, x11
fadd.s f10, f3, f0
