addi x10, x0, 10
addi x11, x0, 5
addi x12, x0, 6
addi x13, x0, 2
fcvt.s.w f0, x10
fcvt.s.w f1, x11
fcvt.s.w f2, x12
fcvt.s.w f3, x13
fdiv.s f20, f1, f0 # f20 = 0.5
fdiv.s f21, f2, f0  # f21 = 0.6
fdiv.s f22, f2, f1 # f22 = 1.2
fadd.s f23, f20, f21 # f23 = 1.1
fadd.s f23, f23, f23 # f23 = 2.2
fdiv.s f24, f3, f0 # f24 = 0.2
fcvt.w.s x20, f20 
fcvt.w.s x21, f21
fcvt.w.s x22, f22
fcvt.w.s x23, f23
fcvt.w.s x24, f24
