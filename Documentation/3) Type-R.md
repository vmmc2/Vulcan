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
* __Síntaxe: add rd, rs1, rs2__
* rs1, rs2 = registradores-fonte
* rd = registrador-destino
* __Operação Realizada: rd = rs1 + rs2.__
* Essa instrução adiciona o conteúdo do registrador rs1 ao conteúdo do registrador rs2 e guarda o resultado no registrador rd.
* __O possível overflow aritmético é ignorado.__

### 2) sub
* __Síntaxe: sub rd, rs1, rs2__
* rs1, rs2 = registradores-fonte
* rd = registrador-destino
* __Operação Realizada: rd = rs1 - rs2.__
* Essa instrução subtraí o conteúdo do registrador rs2 do conteúdo do registrador rs1 e grava o resultado no registrador rd.
* __O possível overflow aritmético também é ignorado.__


## Instruções Lógicas
### 3) and
* __Síntaxe: and rd, rs1, rs2__
* rs1, rs2 = registradores-fonte
* rd = registrador-destino
* __Operação Realizada: rd = rs1 & rs2.__
* Essa instrução é responsável por realizar um AND bit-a-bit entre o conteúdo dos registradores rs1 e rs2 e guardar o resultado dentro do registrador rd.

### 4) or
* __Síntaxe: or rd, rs1, rs2__
* rs1, rs2 = registradores-fonte
* rd = registrador-destino
* __Operação Realizada: rd = rs1 | rs2.__
* Essa instrução é responsável por realizar um OR(inclusivo) bit-a-bit entre o conteúdo dos registradores rs1 e rs2 e guardar o resultado dentro do registrador rd.

### 5) xor
* __Síntaxe: xor rd, rs1, rs2__
* rs1, rs2 = registradores-fonte
* rd = registrador-destino
* __Operação Realizada: rd = rs1 ^ rs2.__
* Essa instrução é responsável por realizar um XOR (OR-Exclusivo) bit-a-bit entre o conteúdo dos registradores rs1 e rs2. Por fim, guarda o resultado dentro do registrador rd.


## Instruções de Deslocamento
### 6) sll
* __Síntaxe: sll rd, rs1, rs2__
* rs1, rs2 = registradores-fonte
* rd = registrador-destino
* __Operação Realizada: rd = rs1 << rs2.__
* Essa instrução é responsável por deslocar o conteúdo do registrador rs1 em rs2 unidades para a esquerda. Os bits vazios decorrentes do deslocamento são preenchidos com zeros (0) e o resultado é gravado no registrador rd.
* Lembrando que quando damos um shift left de uma unidade em um valor é a mesma coisa de estarmos multiplicando esse valor por 2.
 Logo, essa instrução pode ser enxergada da seguinte maneira: __rd = (rs1)*(2^(rs2)).__
 
### 7) srl
* __Síntaxe: srl rd, rs1, rs2__
* rs1, rs2 = registradores-fonte
* rd = registrador-destino
* __Operação Realizada: rd = rs1 >>(u) rs2.__
* Essa instrução é responsável por deslocar o conteúdo do registrador rs1 em rs2 unidades para a direita. Os bits vazios decorrentes do deslocamento para a direita são preenchidos com zeros (0) e, por fim, o resultado é gravado no registrador rd.
* Analogamente ao que acontece quando realizamos um shift left para a esquerda, ao realizarmos um shift left para direita de uma unidade é a mesma coisa que estarmos dividindo o número por 2.
* Diante disso, podemos enxergar essa operação da seguinte maneira (__se estivermos trabalhando com números sem-sinal__): __rd = (rs1)/(2^(rs2)).__

### 8) sra
* __Síntaxe: sra rd, rs1, rs2__
* rs1, rs2 = registradores-fonte
* rd = registrador-destino
* __Operação Realizada: rd = rs1 >> rs2.__
* Essa instrução é responsável por deslocar o conteúdo do registrador rs1 em rs2 unidades para a direita. Os bits vazios decorrentes do deslocamento para a direita são preenchidos com cópias do bit mais significativo de rs1 e, por fim, o resultado é gravado no registrador rd.

### 9) slt
* __Síntaxe: slt rd, rs1, rs2__
* rs1, rs2 = registradores-fonte
* rd = registrador-destino
* __Operação Realizada: rd = rs1 < rs2 ? 1 : 0.__
* Essa instrução verificar os valores presentes nos registradores rs1 e rs2 (analisando-os como números de complemento de dois), escreve 1 no registrador rd, se rs1 < rs2. Caso contrário, escreve 0.

### 10) sltu
* __Síntaxe: sltu rd, rs1, rs2__
* rs1, rs2 = registradores-fonte
* rd = registrador-destino
* __Operação Realizada: rd = rs1 <(u) rs2 ? 1 : 0.__
* Essa instrução verificar os valores presentes nos registradores rs1 e rs2 (analisando-os como números sem sinal), escreve 1 no registrador rd, se rs1 < rs2. Caso contrário, escreve 0.
