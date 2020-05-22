# Intro

## Referências:
* Capítulos 1, 2, 3, 4, 5 e 9 do livro "Guia Prático RISC-V: Atlas de uma arquitetura aberta".
  * O livro acima funciona mais como uma introdução e uma referência para o RISC-V. Recomenda-se que a pessoa já esteja familiarizada com alguma ISA previamente antes de lê-lo.
* RISC-V: Computer Organization and Design RISC-V Edition: The Hardware Software Interface.
  * O livro acima serve para aprender sobre Arquitetura de Computadores no geral. O ideal é começar por ele.

## Considerações Iniciais e Histórico:
* O RISC-V se trata de uma arquitetura de conjunto de instruções (ISA) open-source criada em 2011 e que se destaca entre suas concorrentes (ARM, Intel e Mips) por sua elegância e simplicidade.

## ISA Incremental vs. ISA Modular
* A ISA Incremental se trata da abordagem mais convencional para o desenvolvimento de ISAs. Nela, os novos processadores devem implementar não somente as novas extensões desenvolvidas como também todas as extensões do passado.
* O objetivo dessa prática em ISA Incremental é manter a compatibilidade binária retroativa. Em outras palavras, através dela é possível que versões binárias de programas de décadas passadas possam ser executados sem problema em processadores mais recentes.
* Entretanto, essa prática contém inúmeras desvantagens. Dentre elas:
  * Crescimento exagerado do número de instruções presentes na ISA. Vamos tomar como exemplo uma ISA dominante: Intel 80x86. Levando, em consideração que sua primeira versão foi lançada em 1978 temos que, em média, 3 novas instruções foram adicionadas por mês até 2015.
  * Deve implementar os erros das extensões anteriores mesmo quando eles não fazem mais sentido. Tal prática faz com que as ISAs Incrementais possuam uma certa quantidade de instruções consideradas "inúteis" devido a sua baixa aplicabilidade.
* A ISA Modular, por outro lado, foi a abordagem adotada pelo RISC-V. Essa é uma das características que o fazem ser tão incomum e diferenciado em relação aos seus antecessores. No entanto, como funciona uma ISA Modular e quais são as suas vantagens?
  * Como o nome sugere, a ISA Modular adota uma abordagem de dividir as extensões com novas instruções em módulos que podem ou não ser adicionados a uma implementação de processador de acordo com as necessidades da aplicação. Não há necessidade de utilizarmos a ISA inteira (que pode conter uma série de instruções que não terão utilidade para a nossa aplicação).
  * No caso do RISC-V, existe um ISA/módulo básico (núcleo), chamado de RV32I, que executa uma pilha completa de software. O RV32I está congelado e nunca será alterado. Tal característica fornece estabilidade aos criadores de compiladores, desenvolvedores de sistemas operacionais e programadores de linguagem Assembly.
  * Como já foi dito, a modularidade vem de extensões padrão opcionais que o hardware pode incluir ou não, dependendo das necessidades da aplicação.
