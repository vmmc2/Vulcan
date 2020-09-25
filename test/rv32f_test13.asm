addi x10, x0, 5
addi x11, x0, 10
addi x12, x0, -3
addi x13, x0, 4
addi x14, x0, 2
fcvt.s.w f0, x10
fcvt.s.w f1, x11
fcvt.s.w f2, x12
fcvt.s.w f3, x13
fcvt.s.w f4, x14
fmadd.s f5, f0, f1, f2
fnmadd.s f6, f0, f1, f2
fmsub.s f10, f3, f4, f0
