# Intro

## Referências:
* Capitulos 1, 2, 3, 4, 5 e 9 do livro "Guia Prático RISC-V: Atlas de uma arquitetura aberta".
  * O livro acima funciona mais como uma introdução e uma referência para o RISC-V. Recomenda-se que a pessoa já esteja familiarizada com alguma ISA previamente antes de lê-lo.
* RISC-V: Computer Organization and Design RISC-V Edition: The Hardware Software Interface.
  * O livro acima serve para aprender sobre Arquitetura de Computadores no geral. O ideal é começar por ele.

## Considerações Iniciais e Histórico:
* O RISC-V se trata de uma arquitetura de conjunto de instruções (ISA) open-source criada em 2011 e que se destaca entre suas concorrentes (ARM, Intel e Mips) por sua elegância e simplicidade.

## ISA Incremental vs. ISA Modular
* A ISA Incremental se trata da abordagem mais convencional para o desenvolvimento de ISAs. Nela, os novos processadores devem implementar não somente as novas extensões como também todas as extensões do passado.
* O objetivo dessa prática em ISA Incremental é manter a compatibilidade binária retroativa. Em outras palavras, através dela é possível que versões binárias de programas de décadas passadas possam ser executados sem problema em processadores mais recentes.
