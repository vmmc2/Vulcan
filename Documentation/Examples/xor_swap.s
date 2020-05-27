# Codigo abaixo mostra um truque usando XOR (OR-Exclusivo) usado para trocar o conteudo de 2 registradores sem precisarmos usar um terceiro registrador auxiliar

addi x6, x0, 4
addi x7, x0, 3

# Aplicando o XOR-Swap
xor x6, x6, x7 # x6' = x6 XOR x7
xor x7, x6, x7 # x7' = x6' XOR x7 = (x6 XOR x7) XOR x7 = x6 XOR (x7 XOR x7) = x6 XOR 0 = x6
xor x6, x6, x7 # x6'' = x6' XOR x7' = (x6 XOR x7) XOR (x6) = (x7 XOR x6) XOR (x6) = x7 XOR (x6 XOR x6) = x7 XOR 0 = x7.

# Pronto. XOR-Swap feito.
