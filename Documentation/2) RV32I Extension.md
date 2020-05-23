# RV32I Extension
* Nesse arquivo, faremos uma introdução sobre quais são todas as instruções presentes no módulo base/core do RISC-V: O RV32I. Além disso, veremos detalhadamente qual a sintaxe de cada uma das instruções e como ocorre a sua execução no código Assembly.
* Para exemplos de código mostrando o uso real dessas instruções em código Assembly favor visitar a pasta Examples (presente no diretório Documentation).

## Considerações Gerais
* Todas as instruções da extensão base do RISC-V (RV32I) possuem tamanho de 32 bits (4 bytes = 1 word).
* Na ISA do RISC-V temos uma característica muito importante que favorece sua legibilidade e sua simplicidade (para a decodificação das instruções, por exemplo): Todas as instruções apresentam 3 operandos. Isso é diferente do que acontece com a ISA do Intel x86-32, que apresenta um campo compartilhado para origem e destino.
* Como já foi dito anteriormente, todos os operandos das instruções da ISA do RISC-V devem ser operandos de registradores. Tal característica favorece o desempenho no acesso de dados e, consequentemente, na execução do código Assembly.
* Quando uma operação possui naturalmente três operandos distintos, mas o ISA fornece apenas uma instrução de dois operandos, o compilador ou o programador de linguagem assembly deve utilizar uma instrução de movimentação extra para preservar o operando de destino.

## Formatos de Instrução
* A extensão base do RISC-V (RV32I) apresenta 6 formatos diferentes para suas instruções. São eles:
  * Tipo R: Contém instruções para operações de registradores.
  * Tipo I: Contém instruções para execução de loads e para lidar com valores imediatos curtos.
  * Tipo J: Contém instruções para execução de saltos incondicionais.
  * Tipo S: Contém instruções para execução de stores.
  * Tipo U: Contém instruções para lidar com valores imediatos longos.
  * Tipo B: Contém instruções para execução de desvios condicionais.
* Consequências: O tamanho fixo das instruções (32 bits) aliado à pequena quantidade de formatos diferentes (6) facilita o processo de decodificação das instruções e melhora o desempenho de custo.
