# Type-R Instructions

## Intro
* Como foi dito na seção 2, as instruções do Tipo-R são aquelas responsáveis por executar operações envolvendo os registradores.
* Essas operações são: aritméticas, lógicas e de deslocamento(shift).
  * Instruções Aritméticas: add, sub.
  * Instruções Lógicas: and, or, xor.
  * Instruções de Deslocamento: srl, sra, sll, slt, sltu.
* Todas essas instruções funcionam da seguinte maneira: Elas leem dois valores de 32-bits de registradores-fontes, realizam a operação correspondente à instrução e gravam o resultado de 32-bits no registrador-destino.

## Instruções Aritméticas
### 1) add
* __Sintaxe: add rd, rs1, rs2.__
* rs1, rs2 = registradores-fonte
* rd = registrador-destino
* __Operação Realizada: rd = rs1 + rs2.__
* Essa instrução adiciona o conteúdo do registrador rs1 ao conteúdo do registrador rs2 e guarda o resultado no registrador rd.
* __O possível overflow aritmético é ignorado.__

### 2) sub
* __Sintaxe: sub rd, rs1, rs2.__
* rs1, rs2 = registradores-fonte
* rd = registrador-destino
* __Operação Realizada: rd = rs1 - rs2.__
* Essa instrução subtraí o conteúdo do registrador rs2 do conteúdo do registrador rs1 e grava o resultado no registrador rd.
* __O possível overflow aritmético também é ignorado.__
