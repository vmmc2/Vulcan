addi x10, x0, 10
addi x11, x0, 11
addi x12, x0, 12
sw x10, 0, x0   # memoria[0..3] = 10
sw x11, 4, x0    # memoria[4..7] = 11
amoswap.w x11, x11 , x0 
