# x10 contem o numero do qual eu vou calcular o fatorial...
# x12 contem o valor 1 (um) para me ajudar a sair do loop do fatorial
addi x10, x0, 6  
addi x12, x0, 1

add x11, x10, x0

fatorial:
  beq x10, x12, fim
  addi x10, x10, -1
  mul x11, x11, x10
  beq x0, x0, fatorial

fim:
