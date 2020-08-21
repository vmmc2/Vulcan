addi x10, x0, 10
addi x11, x0, -2
addi x12, x0, 34
addi x13, x0, 37
addi x14, x0, 4
sw x10, 0, x0  # memoria[0..3] = 10
sw x13, 4, x0  # memoria[4..7] = 37
amomaxu.w x20, x11, x0
amomaxu.w x21, x12, x14
