# RV32M Extension

## Intro
* A extensão RV32M é responsável por adicionar instruções de multiplicação e divisão de números inteiros à extensão base RV32I.
* A RV32M tem instruções de divisão para números inteiros com e sem sinal: divide (div) e divide unsigned (divu), que colocam o quociente no registrador-destino.
* De forma menos frequente, os programadores podem querer o resto de uma divisão ao invés do quociente. Tendo isso em mente, a extensão RV32M oferece as instruções: remainder (rem) e remainder unsigned (remu), que gravam o resto da divisão em vez do quociente no registrador-destino.
* __A figura abaixo é uma listagem de todas as instruções disponíveis na extensão RV32M:__
![[rv32m](https://http://riscv.org/)](rv32m.png)
* __A figura abaixo se trata de um mapa contendo os campos: opcode, funct3 e funct7 para todas as instruções da extensão RV32M do RISC-V.__
![[opcodemap](https://http://riscv.org/)](mapaopcoderv32m.png)
* __Não custa lembrar que as equações envolvendo divisão e multiplicação funcionam da seguinte maneira:__
  * __Divisão:__ Dividendo = (Divisor * Quociente) + Resto
  * __Multiplicação:__ Produto = (Multiplicador * Multiplicando)

## Notas sobre as instruções de Multiplicação
* A instrução de multiplicação é mais complicada do que a de divisão (no que se refere ao tamamho dos operandos envolvidos na operação). No caso da multiplicação, o tamanho do produto é a soma dos tamanhos do multiplicador e do multiplicando. Portanto, a multiplicação de dois números de 32 bits gera um produto de 64 bits.
* Para produzir um produto de 64 bits devidamente com ou sem sinal, o RISC-V possui 4 instruções de multiplicação. Para obter o produto inteiro de 32 bits -- os 32 bits inferiores do produto completo -- utilize a instrução __mul.__ Caso queira obter os 32 bits superiores do produto de 64 bits, utilize __mulh__ se ambos os operandos estiverem na representação com sinal. Utilize __mulhu__ se ambos os operandos estiverem na representação sem sinal. Por fim, utilize __mulhsu__ se um operando estiver com sinal, mas o outro não.

## Instruções
### 1) mul
* __Significado: Multiply (mul).__
* __Síntaxe: mul rd, rs1, rs2__
* rs1/rs2 = registradores-fonte
* rd = registrador-destino
* __Operação Realizada: rd = rs1 * rs2.__
* Essa instrução funciona da seguinte maneira. Calcula o produto do conteúdo dos registradores de 32-bits rs1 e rs2. Esse produto possui 64 bits. Essa instrução grava os 32-bits menos significativos do resultado no registrador-destino rd. __Em outras palavras, essa instrução ignora o overflow aritmético.__

### 2) mulh

### 3) mulhu

### 4) mulhsu

### 5) div

### 6) divu

### 7) rem

### 8) remu
