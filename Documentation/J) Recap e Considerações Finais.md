# Recap e Considerações Finais

## Intro
* Nessa seção, faremos uma breve recapitulação sobre os aspectos e características mais importantes da RV32I.
* Grande parte deles, a RV32I herdou de seus antecessores (RISC-IV, RISC-III, RISC-II, RISC-I).

## Aspectos Relevantes
* Espaço de endereço endereçavel por byte. O tamanho dos endereços é de 32 bits. Quando eu digo que o espaço de endereço é endereçavel por byte, eu estou me referindo ao fato de que a memória do computador funciona como um array gigantesco, no qual, cada célula desse array representa o espaço de 1 byte.
* Todas as instruções apresentam tamanho de 32 bits (4 bytes).
* Considerando a extensão-base (RV32I), ela apresenta 32 registradores, todos eles possuem tamanho de 32 bits, com o registrador x0 setado constantemente para o valor 0.
* Todas as operações executadas pelas instruções acontecem entre os registradores. Nenhuma acontece entre registrador e memória.
* Imediatos sempre extendem em sinal.
* Sem instruções de multiplicação e divisão (Tais instruções fazem parte da extensão RV32M).
* No que diz respeito as instruções de Load, podemos executar load em words (com sinal apenas) e em bytes/halfwords (com ou sem sinal).
* Opção envolvendo imediatos para todas as instruções aritméticas (addi), lógicas (andi, ori, xori), de deslocamento (slli, srli, srai) e de comparação (slti, sltiu).
