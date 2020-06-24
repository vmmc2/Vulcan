# Primeira parte, carregar a string na memoria
# string = "BBCCEEIIOU"
# Vou comecar a salvar a string na memoria a partir do endereco 0

addi x20, x0, 65  # A
addi x21, x0, 69   # E
addi x22, x0, 73  # I
addi x23, x0, 79  # O
addi x24, x0, 85  # U
addi x25, x0, 0 # esse registrador vai carregar a letra da vez
addi x18, x0, 0  # registrador que contem a resposta

# x6 vai guardar o endereco para o qual eu vou carregar o caractere na memoria, considerando os codigos da tabela ASCII
# x15 vai guardar o endereco inicial da string para percorremos por ela na memoria na hora da checagem
addi x6, x0, 0
add x15, x0, x6
addi x7, x0, 65  # A
sb x7, 0, x6

addi x6, x6, 1
addi x7, x0, 65  # A
sb x7, 0, x6

addi x6, x6, 1
addi x7, x0, 67 # C
sb x7, 0, x6

addi x6, x6, 1
addi x7, x0, 67 # C
sb x7, 0 x6

addi x6, x6, 1
addi x7, x0, 69  # E
sb x7, 0, x6

addi x6, x6, 1
addi x7, x0, 69  # E
sb x7, 0, x6

addi x6, x6, 1
addi x7, x0, 73  # I
sb x7, 0, x6

addi x6, x6, 1
addi x7, x0, 73  # I
sb x7, 0, x6

addi x6, x6, 1
addi x7, x0, 79  # O
sb x7, 0, x6

addi x6, x6, 1
addi x7, x0, 85 # U
sb x7, 0, x6


loop:
  lb x25, 0, x15
  beq x25, x0, end  #carreguei um '0' , que representa o caractere '\0'  ---- fim de string
  beq x25, x20, add_vogal
  beq x25, x21, add_vogal
  beq x25, x22, add_vogal
  beq x25, x23, add_vogal
  beq x25, x24, add_vogal
  addi x15, x15, 1
  beq x0, x0, loop

add_vogal:
  addi x18, x18, 1
  addi x15, x15, 1
  jal x0, loop

end:  
