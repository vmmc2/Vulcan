# primeiro passo: Salvar as frases dos 2 jogadores na memoria.
# Jogador 1   -> Frase vai ser salva partindo do endereco 0
# Jogador 2  -> Frase vai ser salva partindo do endereco 200

addi x4, x0, 0   #endereco de partida da string 1
addi x5, x0, 200  #endereco de partida da string 2

add x6, x4, x0   # vai guardar o endereco inicial da string 1 para eu percorrer dps
add x7, x5, x0   # vai guardar o endereco inicial da string 2 para eu percorrer dps

# registrador x8 vai guardar o caractere da vez que vai ser carregado na memoria

# string 1   -> "CAMELO"
# string 2  -> "ELEFANTE"

# carregando a string1 na memoria.
addi x8, x0, 67    #  'C'
sb x8, 0, x4
addi x4, x4, 1

addi x8, x0, 65   #  'A'
sb x8, 0, x4
addi x4, x4, 1

addi x8, x0, 77   # 'M'
sb x8, 0, x4
addi x4, x4, 1

addi x8, x0, 69  # 'E'
sb x8, 0, x4
addi x4, x4, 1

addi x8, x0, 76  # 'L'
sb x8, 0, x4
addi x4, x4, 1

addi x8, x0, 79  # 'O'
sb x8, 0, x4
addi x4, x4, 1 


#carregando a string2 na memoria
addi x8, x0, 69   # 'E'
sb x8, 0, x5
addi x5, x5, 1

addi x8, x0, 76  # 'L'
sb x8, 0, x5
addi x5, x5, 1

addi x8, x0, 69  # 'E'
sb x8, 0, x5
addi x5, x5, 1

addi x8, x0, 70  # 'F'
sb x8, 0, x5
addi x5, x5, 1

addi x8, x0, 65   # 'A'
sb x8, 0, x5
addi x5, x5, 1

addi x8, x0, 78  # 'N'
sb x8, 0, x5
addi x5, x5, 1

addi x8, x0, 84   # 'T'
sb x8, 0, x5
addi x5, x5, 1

addi x8, x0, 69   # 'E'
sb x8, 0, x5
addi x5, x5, 1

# pontuacao do jogador 1  -->  registrador x9
addi x9, x0, 0
# pontuacao do jogador 2 --> registrador x10
addi x10, x0, 0

#checando a pontuacao do jogador1/string1
loop:
  lb x8, 0, x6  # pegando o caractere da vez na string 1
  beq x8, x0, fim1  #cheguei ao fim da string1
  #checando cada caractere por vez...
  addi x11, x0, 65   # 'A'
  beq x8, x11, soma1
  addi x11, x0, 69   # 'E'
  beq x8, x11, soma1
  addi x11, x0, 73   # 'I'
  beq x8, x11, soma1
  addi x11, x0, 79   # 'O'
  beq x8, x11, soma1
  addi x11, x0, 85  # 'U'
  beq x8, x11, soma1
  addi x11, x0, 78  # 'N'
  beq x8, x11, soma1
  addi x11, x0, 82  # 'R'
  beq x8, x11, soma1
  addi x11, x0, 83  # 'S'
  beq x8, x11, soma1

  addi x11, x0, 68  # 'D'
  beq x8, x11, soma2
  addi x11, x0, 71   # 'G'
  beq x8, x11, soma2
  addi x11, x0, 84 # 'T'
  beq x8, x11, soma2
 
  addi x11, x0, 66  # 'B'
  beq x8, x11, soma3
  addi x11, x0, 67  # 'C'
  beq x8, x11, soma3
  addi x11, x0, 77  # 'M'
  beq x8, x11, soma3
  addi x11, x0, 80  # 'P'
  beq x8, x11, soma3

  addi x11, x0, 70  # 'F'
  beq x8, x11, soma4
  addi x11, x0, 72  # 'H'
  beq x8, x11, soma4
  addi x11, x0, 86  # 'V'
  beq x8, x11, soma4
  addi x11, x0, 87  # 'W'
  beq x8, x11, soma4
  addi x11, x0, 89  # 'Y'
  beq x8, x11, soma4

 addi x11, x0, 75  # 'K'
 beq x8, x11, soma5

 addi x11, x0, 74  # 'J'
 beq x8, x11, soma8
 addi x11, x0, 76  # 'L'
 beq x8, x11, soma8
 addi x11, x0, 88  # 'X'
 beq x8, x11, soma8

 addi x11, x0, 81  # 'Q'
 beq x8, x11, soma10
 addi x11, x0, 90  # 'Z'
 beq x8, x11, soma10

soma1:
  addi x9, x9, 1
  addi x6, x6, 1
  jal x0, loop
soma2:
  addi x9, x9, 2
  addi x6, x6, 1
  jal x0, loop
soma3:
  addi x9, x9, 3
  addi x6, x6, 1
  jal x0, loop
soma4:
  addi x9, x9, 4
  addi x6, x6, 1
  jal x0, loop
soma5:
  addi x9, x9, 5
  addi x6, x6, 1
  jal x0, loop
soma8:
  addi x9, x9, 8
  addi x6, x6, 1
  jal x0, loop
soma10:
  addi x9, x9, 10
  addi x6, x6, 1
  jal x0, loop


fim1:
