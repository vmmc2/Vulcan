# Extra Info

## Instruções de Registradores de Status de Controle
* As instruções de Registradores de Status de Controle (csrrc, csrrs, csrrw, csrrci, csrrsi, csrrwi) fornecem acesso aos registradores de controle, que são responsáveis por medir o desempenho do programa (do código).
* Esses contadores possuem tamanho de 64 bits, que podem ser lidos 32 bits por vez.
* Esses registradores medem a hora do relógio de parede, os ciclos de clock executados e a quantidade de instruções retiradas. (Não acho que vai ser útil implementar esses tipos de instruções, já que o Vulcan não emula o sistema inteiro. Apenas algumas extensões da ISA).
* Na real, teve muitas instruções desse tipo que eu não saquei como funcionam. Exemplos: ebreak, fence, fence.i, ecall. 
* Vou ter que ler melhor a respeito para tentar entender como isso funciona.
