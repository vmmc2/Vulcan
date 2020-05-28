# Type-B Instructions

## Intro
* As instruções Type-B são aquelas usadas para realizar desvios condicionais. Em outras palavras, checamos se uma condição é verdadeira ou falsa. Caso seja verdadeira, executamos um desvio/salto para uma outra parte de nosso código Assembly para que a sua execução prossiga a partir daquele novo ponto. Caso seja falsa, continuamos a execução normal do nosso código sem pular para outras partes.
* RISC-V permite comparar o conteúdo de dois registradores de nossa escolha e desviar no resultado se: eles forem iguais (beq), diferentes (bne), maior ou igual (bge) ou menor (blt).
* Esses dois últimos casos (bge e blt) são para números com sinal. No entanto, o RV32I também oferece versões para lidar com números sem sinal (bgeu e bltu).
* __IMPORTANTE: Já que as instruções RISC-V deve ser um múltiplo de dois bytes de comprimento. O modo de endereçamento de desvio multiplica o imediato de 12 bits por 2, amplia o sinal e adiciona-o ao PC. Endereçamento relativo a PC ajuda com código independente de posição e, portanto, reduz o trabalho do linker e do loader ( Mais informações sobre Linker e Loader nas próximas seções).__

## Instruções
### 1) beq
* __Significado: Branch If Equal (beq).__
* __Síntaxe: beq rs1, rs2, offset__
* rs1/rs2 = registradores-fonte que serão comparados afim de podermos checar a condicional.
* offset = valor imediato(constante) com sinal de 12 bits. Pode ser também uma label.
* __Operação Realizada: if(rs1 == rs2) then: pc = pc + signalextend(offset).__
* O valor presente no offset funciona como quantidade de bytes. Lembrar que, no RISC-V, a memória é endereçada por byte.
* A instrução "beq" funciona da seguinte maneira: Pego os valores que estão presentes nos registradores rs1 e rs2 e verifico se eles são iguais. Caso isso seja verdadeiro, eu pego o offset faço o signalextend() nele e somo ao pc e seto esse novo valor para o pc. Caso contrário, eu simplesmente executo a próxima instrução (pc = pc + 4).

### 2) bne
* __Significado: Branch If Not Equal (bne).__
* __Síntaxe: bne rs1, rs2, offset__
* rs1/rs2 = registradores-fonte que serão comparados afim de podermos checar a condicional.
* offset = valor imediato(constante) com sinal de 12 bits. Pode ser também uma label.
* __Operação Realizada: if(rs1 != rs2) then: pc = pc + signalextend(offset).__
* O valor presente no offset funciona como quantidade de bytes. Lembrar que, no RISC-V, a memória é endereçada por byte.
* A instrução "bne" funciona da seguinte maneira: Pego os valores que estão presentes nos registradores rs1 e rs2 e verifico se eles são diferentes. Caso isso seja verdadeiro, eu pego o offset faço o signalextend() nele e somo ao pc e seto esse novo valor para o pc. Caso contrário, eu simplesmente executo a próxima instrução (pc = pc + 4).

### 3) blt
* __Significado: Branch If Less Than (blt).__
* __Síntaxe: blt rs1, rs2, offset__
* rs1/rs2 = registradores-fonte que serão comparados afim de podermos checar a condicional.
* offset = valor imediato(constante) com sinal de 12 bits. Pode ser também uma label.
* __Operação Realizada: if(rs1 <(s) rs2) then: pc = pc + signalextend(offset).__
* O valor presente no offset funciona como quantidade de bytes. Lembrar que, no RISC-V, a memória é endereçada por byte.
* A instrução "blt" funciona da seguinte maneira: Pego os valores que estão presentes nos registradores rs1 e rs2 e verifico se o valor presente no registrador rs1 é menor do que o valor presente no registrador rs2, encarando ambos os valores como números com sinal (formato complemento a 2). Caso isso seja verdadeiro, eu pego o offset faço o signalextend() nele e somo ao pc. Por fim, seto esse novo valor para o pc. Caso contrário, eu simplesmente executo a próxima instrução (pc = pc + 4).

### 4) bge
* __Significado: Branch If Greater Than or Equal (bge).__
* __Síntaxe: bge rs1, rs2, offset__
* rs1/rs2 = registradores-fonte que serão comparados afim de podermos checar a condicional.
* offset = valor imediato(constante) com sinal de 12 bits. Pode ser também uma label.
* __Operação Realizada: if(rs1 >=(s) rs2) then: pc = pc + signalextend(offset).__
* O valor presente no offset funciona como quantidade de bytes. Lembrar que, no RISC-V, a memória é endereçada por byte.
* A instrução "bge" funciona da seguinte maneira: Pego os valores que estão presentes nos registradores rs1 e rs2 e verifico se o valor presente no registrador rs1 é maior do que ou igual o valor presente no registrador rs2, encarando ambos os valores como números com sinal (formato complemento a 2). Caso isso seja verdadeiro, eu pego o offset faço o signalextend() nele e somo ao pc. Por fim, seto esse novo valor para o pc. Caso contrário, eu simplesmente executo a próxima instrução (pc = pc + 4).

### 5) bltu
* __Significado: Branch If Less Than Unsigned (bltu).__
* __Síntaxe: bltu rs1, rs2, offset__
* rs1/rs2 = registradores-fonte que serão comparados afim de podermos checar a condicional.
* offset = valor imediato(constante) com sinal de 12 bits. Pode ser também uma label.
* __Operação Realizada: if(rs1 <(u) rs2) then: pc = pc + signalextend(offset).__
* O valor presente no offset funciona como quantidade de bytes. Lembrar que, no RISC-V, a memória é endereçada por byte.
* A instrução "bltu" funciona da seguinte maneira: Pego os valores que estão presentes nos registradores rs1 e rs2 e verifico se o valor presente no registrador rs1 é menor do que o valor presente no registrador rs2, encarando ambos os valores como números sem sinal. Caso isso seja verdadeiro, eu pego o offset faço o signalextend() nele e somo ao pc. Por fim, seto esse novo valor para o pc. Caso contrário, eu simplesmente executo a próxima instrução (pc = pc + 4).

### 6) bgeu
* __Significado: Branch If Greater Than or Equal Unsigned (bgeu).__
* __Síntaxe: bgeu rs1, rs2, offset__
* rs1/rs2 = registradores-fonte que serão comparados afim de podermos checar a condicional.
* offset = valor imediato(constante) com sinal de 12 bits. Pode ser também uma label.
* __Operação Realizada: if(rs1 >=(u) rs2) then: pc = pc + signalextend(offset).__
* O valor presente no offset funciona como quantidade de bytes. Lembrar que, no RISC-V, a memória é endereçada por byte.
* A instrução "bgeu" funciona da seguinte maneira: Pego os valores que estão presentes nos registradores rs1 e rs2 e verifico se o valor presente no registrador rs1 é maior do que ou igual o valor presente no registrador rs2, encarando ambos os valores como números sem sinal. Caso isso seja verdadeiro, eu pego o offset faço o signalextend() nele e somo ao pc. Por fim, seto esse novo valor para o pc. Caso contrário, eu simplesmente executo a próxima instrução (pc = pc + 4).
