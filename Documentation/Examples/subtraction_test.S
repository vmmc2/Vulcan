addi x9, x0, 9
addi x10, x0, 10
add x20, x0, x0 # x20 = 0
add x11, x0, x0 # x11 = 0
addi x12, x0, 5 # x12 = 5
addi x13, x0, 24 # x13 = 24
addi x24, x0, 1 # x24 = 1
j function1

function1:
  addi x20, x20, 100 
  # o conteudo de x20 fica igual a x9 + x10 = 19
  beq x11, x12, function2 
  #vai dar o branch para a label "function2" quando x11 == 5
  addi x11, x11, 1
  j function1
  
function2:
  sub x13, x13, x24
