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
feq.s x30, f0, f1
fdiv.s f5, f0, f4
fadd.s f5, f5, f0
fle.s x31, f4, f5
flt.s x29, f0, f5
