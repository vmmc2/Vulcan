addi x10, x0, 2      # a = 2
addi x11, x0, 20       # b = 20
addi x12, x0, 25      # c = 25
addi x13, x0, 5      # x = 5
add x13, x0, x0     # x = 0
addi x14, x0, 64
addi x15, x0, 24

# if( a >= 0 && b <= 64  && c > 24) x = 1
# if(x10 >= 0 && x11 <= 64 && x12 > 24) x13 = 1

c1:
  bge x10, x0, c2
  jal x0, end 

c2:
  bge x14, x11, c3
  jal x0, end
 
c3:
  blt x15, x12, finale
  jal x0, end

finale:
  addi x13, x0, 1

end:
