# Type-S Instructions

## Intro
* As instruções do tipo-S são aquelas instruções que executam stores.
* Store nada mais é do que uma operação de transferência de dados de um registrador para a memória. Mais especificamente, para um endereço de memória específico.
* Modo de Endereçamento para instruções de store: Para conseguir obter um endereço de memória para guardar um dado presente em um registrador na memória, a gente que tem que pegar o valor que está em um registrador de nossa escolha e adicionar a esse valor, um imediato de 12 bits (que tenha sofrido sign-extend). Feito isso, o valor resultante será um endereço de memória, que poderá ser utilizado para guardamos nosso dado do registrador.

## Instruções 
### 1) sb
* __Significado: Store Byte (sb).__
* __Síntaxe: sb rs2, imm, rs1__
* imm = valor imediato/constante (com sinal) de 12 bits.
* rs1 = registrador auxiliar usado para calcular o endereço de memória.
* rs2 = registrador-fonte que contém o dado a ser armazenado na memória.
* __Operação Realizada: memória[rs1 + signalextend(imm[11:0])] = rs2[7:0].__
* Essa instrução pega os 8 bits menos significativos (byte menos significativo) do registrador rs2 e armazena esse valor no endereço de memória calculado pela soma: rs1 + signalextend(imm[11:0]).

### 2) sh

### 3) sw