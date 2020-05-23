# RV32I Extension
* Nesse arquivo, faremos uma introdução sobre quais são todas as instruções presentes no módulo base/core do RISC-V: O RV32I. Além disso, veremos detalhadamente qual a sintaxe de cada uma das instruções e como ocorre a sua execução no código Assembly.
* Para exemplos de código mostrando o uso real dessas instruções em código Assembly favor visitar a pasta Examples (presente no diretório Documentation).

## Tamanho de Instrução
* Todas as instruções da extensão base do RISC-V (RV32I) possuem tamanho de 32 bits (4 bytes = 1 word).

## Formatos de Instrução
* A extensão base do RISC-V (RV32I) apresenta 6 formatos diferentes para suas instruções. São eles:
  * Tipo R: Contém instruções para operações de registradores.
  * Tipo I: Contém instruções para execução de loads e valores imediatos pequenos.
  * Tipo J: Contém instruções para execução de saltos incondicionais.
  * Tipo S: Contém instruções para execução de stores.
  * Tipo U: Contém instruções para lidar com valores imediatos longos.
  * Tipo B: Contém instruções para execução de desvios condicionais.
