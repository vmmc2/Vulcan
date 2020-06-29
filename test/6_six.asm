# Supondo que a palavra procurada na string seja sempre "riscv"

# Carregando a string na memoria
# STRING   -->  "sivprsc"
# A string na qual faremos a busca vai ser carregada no endereco 0
# endereco inicial da string: x6
add x7, x6, x0  # x7 vai guardar o endereco da string para podermos percorre-la

addi x8, x0, 115  # 's'
sb x8, 0, x6
addi x6, x6, 1

addi x8, x0, 118  # 'v'
sb x8, 0, x6
addi x6, x6, 1

addi x8, x0, 112  # 'p'
sb x8, 0, x6  
addi x6, x6, 1

addi x8, x0, 114  # 'r'
sb x8, 0, x6
addi x6, x6, 1

addi x8, x0, 115  # 's'
sb x8, 0, x6
addi x6, x6, 1

addi x8, x0, 99  # 'c'
sb x8, 0, x6


addi x20, x0, 114  # 'r'
addi x21, x0, 105  # 'i'
addi x22, x0, 115  # 's'
addi x23, x0, 99  # 'c'
addi x24, x0, 118  # 'v'

loop:
  lb x8, 0, x7
  beq x8, x0, check  #chegamos ao fim da string
  beq x8, x20, s1   # achei um 'r'
  beq x8, x21, s2   # achei um 'i'
  beq x8, x22, s3  # achei um 's'
  beq x8, x23, s4  # achei um 'c'
  beq x8, x24, s5  # achei um 'v'
  addi x7, x7, 1
  jal x0, loop

s1:
  addi x25, x25, 1
  addi x7, x7, 1
  jal x0, loop

s2:
  addi x26, x26, 1
  addi x7, x7, 1
  jal x0, loop

s3:
  addi x27, x27, 1
  addi x7, x7, 1
  jal x0, loop

s4:
  addi x28, x28, 1
  addi x7, x7, 1
  jal x0, loop

s5:
  addi x29, x29, 1
  addi x7, x7, 1
  jal x0, loop

check:
  lui x10, 3000
  blt x25, x10, min1
check2:
  blt x26, x10, min2
check3: 
  blt x27, x10, min3
check4: 
  blt x28, x10, min4
check5:
  blt x29, x10, min5
  jal x0, fim

min1:
  addi x10, x25, 0
  jal x0, check2
min2:
  addi x10, x26, 0
  jal x0, check3
min3:
  addi x10, x27, 0
  jal x0, check4
min4:
  addi x10, x28, 0
  jal x0,  check5
min5:
  addi x10, x29, 0
  jal x0, fim

fim:
