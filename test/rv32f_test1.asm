addi x10, x0, 13
addi x11, x0, -25
fcvt.s.w f0, x10
fcvt.s.w f1, x11
fdiv.s f2, f1, f0
fcvt.w.s x13, f2
