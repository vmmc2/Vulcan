# Type-S Instructions

## Intro
* As instruções do tipo-S são aquelas instruções que executam stores.
* Store nada mais é do que uma operação de transferência de dados de um registrador para a memória. Mais especificamente, para um endereço de memória específico.
* Modo de Endereçamento para instruções de store: Para conseguir obter um endereço de memória para guardar um dado presente em um registrador na memória, a gente tem que pegar o valor que está em um registrador de nossa escolha (rs1) e adicionar a esse valor um imediato de 12 bits (que tenha sofrido sign-extend) (imm). Feito isso, o valor resultante será um endereço de memória, que poderá ser utilizado para guardamos nosso dado do registrador (rs2).
* Cabe destacar que esse modo de endereçamento do RISC-V não discrimina nenhum tipo de dado. Em outras palavras, ele funciona para: bytes, halfwords, words e doublewords(quando estamos trabalhando com a RV64I).

## Instruções 
### 1) sb
* __Significado: Store Byte (sb).__
* __Síntaxe: sb rs2, imm, rs1__
* imm = valor imediato/constante (com sinal) de 12 bits.
* rs1 = registrador auxiliar usado para calcular o endereço de memória.
* rs2 = registrador-fonte que contém o dado a ser armazenado na memória.
* __Operação Realizada: memória[rs1 + signalextend(imm[11:0])] = rs2[7:0].__
* O valor presente no imm funciona como quantidade de bytes. Lembrar que, no RISC-V, a memória é endereçada por byte.
* Essa instrução pega os 8 bits menos significativos (byte menos significativo) do registrador rs2 e armazena esse valor no endereço de memória calculado pela soma: rs1 + signalextend(imm[11:0]).

### 2) sh
* __Significado: Store HalfWord (sh).__
* __Síntaxe: sh rs2, imm, rs1__
* imm = valor imediato/constante (com sinal) de 12 bits.
* rs1 = registrador auxiliar usado para calcular o endereço de memória.
* rs2 = registrador-fonte que contém o dado a ser armazenado na memória.
* __Operação Realizada: memória[rs1 + signalextend(imm[11:0])] = rs2[15:0].__
* O valor presente no imm funciona como quantidade de bytes. Lembrar que, no RISC-V, a memória é endereçada por byte.
* Essa instrução pega os 16 bits menos significativos (2 bytes menos significativo) do registrador rs2 e armazena esse valor no endereço de memória calculado pela soma: rs1 + signalextend(imm[11:0]).

### 3) sw
* __Significado: Store Word (sw).__
* __Síntaxe: sw rs2, imm, rs1__
* imm = valor imediato/constante (com sinal) de 12 bits.
* rs1 = registrador auxiliar usado para calcular o endereço de memória.
* rs2 = registrador-fonte que contém o dado a ser armazenado na memória.
* __Operação Realizada: memória[rs1 + signalextend(imm[11:0])] = rs2[31:0].__
* O valor presente no imm funciona como quantidade de bytes. Lembrar que, no RISC-V, a memória é endereçada por byte.
* Essa instrução pega todos os 32 bits (4 bytes) do registrador rs2 e armazena esse valor no endereço de memória calculado pela soma: rs1 + signalextend(imm[11:0]).
