# tem que guardar 1 em x10 se a string for palindromo ou 0 caso a string nao seja palindromo
addi x5, x0, 0 # x5 vai guardar o endereco do ultimo caractere da minha string
add x6, x5, x0 # x6 vai guardar o endereco do primeiro caractere da minha string

# vou assumir que a string eh um palindromo e tento provar que ela nao eh
addi x10, x0, 1

# preciso guardar o caractere espaco em algum lugar...
addi x30, x0, 32
# preciso guardar o valor do primeiro caractere maiusculo (A = 65) em algum registrador
addi x29, x0, 65
# preciso guardar o valor do ultimo caractere maiusculo (Z = 90) em algum registrador
addi x31, x0, 91

# Vou colocar, como teste, a string "Luz Azul"

addi x7, x0, 76     # 'L'
sb x7, 0, x5
addi x5, x5, 1

addi x7, x0, 117     # 'u'
sb x7, 0, x5
addi x5, x5, 1

addi x7, x0, 122   # 'z'
sb x7, 0, x5
addi x5, x5, 1

addi x7, x0, 32    # ' ' 
sb x7, 0, x5
addi x5, x5, 1

addi x7, x0, 65    # 'A'
sb x7, 0, x5
addi x5, x5, 1

addi x7, x0, 122   # 'z'
sb x7, 0, x5
addi x5, x5, 1

addi x7, x0, 117   # 'u'
sb x7, 0, x5
addi x5, x5, 1

addi x7, x0, 108  # 'l'  (L minusculo)
sb x7, 0, x5


# primeira parte ir movendo os ponteiros x6 (inicio da string) e x5 (fim da string) para irmos percorrendo elas
# vou trabalhar com as letras todas em minusculo... (soma 32)
# x20   -> caractere de x6
# x21    -> caractere de x5

loop:
  lb x20, 0, x6
  beq x20, x0, fim # cheguei ao fim
  lb x21, 0, x5
  beq x20, x30, spone   # achei um espaco... tem que ir incrementando x6 ate nao carregar mais um '  '
  back:
    beq x21, x30, sptwo   # achei um espaco... tem que ir decrementando x5 ate nao carregar mais um '  '
  back2:
  # checando se o caractere em x20 eh uma letra maiuscula
    bge x20, x29, c11  
 back3:
  # checando se o caractere em x21 eh uma letra minuscula
    bge x21, x29, c21
 back4:
   bne x20, x21, np  # caracteres diferentes -> nao eh palindromo   
   addi x6, x6, 1
   addi x5, x5, -1
   jal x0, loop   

c11:
  blt x20, x31, c12
  jal x0, back3

c12:
  addi x20, x20, 32
  jal x0, back3

c21:
  blt x21, x31, c22
  jal x0, back4

c22:
  addi x21, x21, 32
  jal x0, back4

spone:
  addi x6, x6, 1
  lb x20, 0, x6
  beq x20, x30, spone
  bne x20, x30, back

sptwo:
  addi x5, x5, -1
  lb x21, 0, x5
  beq x21, x30, sptwo
  bne x21, x30, back2


np:
  addi x10, x0, 0
fim:
