addi x10, x0, 5 # a = 5
addi x11, x0, 4 # b = 4
addi x12, x0, 12 # m = 12
add x12, x0, x10 # m = a

beq x11, x12, op1  
bne x11, x12, op2

op1: #  m = b - a
 sub x12, x11, x10    
  jal x0, end

op2: # m = a - b
  sub x12, x10, x11
  jal x0, end

end:
