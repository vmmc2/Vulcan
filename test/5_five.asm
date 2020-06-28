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
