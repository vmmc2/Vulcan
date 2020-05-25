# Type-R Instructions

## Intro
* Como foi dito na seção 2, as instruções do Tipo-R são aquelas responsáveis por executar operações envolvendo os registradores.
* Essas operações são: aritméticas, lógicas e de deslocamento(shift).
  * Instruções Aritméticas: add, sub.
  * Instruções Lógicas: and, or, xor.
  * Instruções de Deslocamento: srl, sra, sll, slt, sltu.
* Todas essas instruções funcionam da seguinte maneira: Elas leem dois valores de 32-bits de registradores-fontes, realizam a operação correspondente à instrução e gravam o resultado de 32-bits no registrador-destino.

## Instruções Aritméticas

### add
