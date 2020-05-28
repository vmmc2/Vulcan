# Type-B Instructions

## Intro
* As instruções Type-B são aquelas usadas para realizar desvios condicionais. Em outras palavras, checamos se uma condição é verdadeira ou falsa. Caso seja verdadeira, executamos um desvio/salto para uma outra parte de nosso código Assembly para que a sua execução prossiga a partir daquele novo ponto. Caso seja falsa, continuamos a execução normal do nosso código sem pular para outras partes.
* RISC-V permite comparar o conteúdo de dois registradores de nossa escolha e desviar no resultado se: eles forem iguais (beq), diferentes (bne), maior ou igual (bge) ou menor (blt).
* Esses dois últimos casos (bge e blt) são para números com sinal. No entanto, o RV32I também oferece versões para lidar com números sem sinal (bgeu e bltu).
* __IMPORTANTE: Já que as instruções RISC-V deve ser um múltiplo de dois bytes de comprimento. O modo de endereçamento de desvio multiplica o imediato de 12 bits por 2, amplia o sinal e adiciona-o ao PC. Endereçamento relativo a PC ajuda com código independente de posição e, portanto, reduz o trabalho do linker e do loader (capítulo 3).__

## Instruções
### 1) beq

### 2) bne

### 3) blt

### 4) bge

### 5) bltu

### 6) bgeu
