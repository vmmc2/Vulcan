addi x10, x0, 10
addi x11, x0, -4
addi x12, x0, 34
addi x13, x0, -23
fcvt.s.w f0, x10
fcvt.s.w f1, x11
fcvt.s.w f2, x12
fcvt.s.w f3, x13
fsgnj.s f10, f0, f1
fsgnjn.s f11, f0, f1
fsgnjx.s f12, f1, f3
