# Intro

## Referências:
* Capítulos 1, 2, 3, 4, 5 e 9 do livro "Guia Prático RISC-V: Atlas de uma arquitetura aberta".
  * O livro acima funciona mais como uma introdução e uma referência para o RISC-V. Recomenda-se que a pessoa já esteja familiarizada com alguma ISA previamente antes de lê-lo.
* RISC-V: Computer Organization and Design RISC-V Edition: The Hardware Software Interface.
  * O livro acima serve para aprender sobre Arquitetura de Computadores no geral. O ideal é começar por ele.
* Cartão de Referência do RISC-V (RISC-V Green Card)
  * Basicamente, trata-se de um folheto que contém todas as instruções presentes na ISA do RISC-V bem como a sintaxe de cada uma delas. Pode ser facilmente encontrado no Google.

## Considerações Iniciais e Histórico:
* O RISC-V se trata de uma arquitetura de conjunto de instruções (ISA) open-source criada em 2011 e que se destaca entre suas concorrentes (ARM, Intel e Mips) por sua elegância e simplicidade.

## ISA Incremental vs. ISA Modular
* A ISA Incremental se trata da abordagem mais convencional para o desenvolvimento de ISAs. Nela, os novos processadores devem implementar não somente as novas extensões desenvolvidas como também todas as extensões do passado.
* O objetivo dessa prática em ISA Incremental é manter a compatibilidade binária retroativa. Em outras palavras, através dela é possível que versões binárias de programas de décadas passadas possam ser executados sem problema em processadores mais recentes.
* Entretanto, essa prática contém inúmeras desvantagens. Dentre elas:
  * Crescimento exagerado do número de instruções presentes na ISA. Vamos tomar como exemplo uma ISA dominante: Intel 80x86. Levando, em consideração que sua primeira versão foi lançada em 1978 temos que, em média, 3 novas instruções foram adicionadas por mês até 2015.
  * Deve implementar os erros das extensões anteriores mesmo quando eles não fazem mais sentido. Tal prática faz com que as ISAs Incrementais possuam uma certa quantidade de instruções consideradas "inúteis" devido a sua baixa aplicabilidade.
* A ISA Modular, por outro lado, foi a abordagem adotada pelo RISC-V. Essa é uma das características que o fazem ser tão incomum e diferenciado em relação aos seus antecessores e concorrentes. No entanto, como funciona uma ISA Modular e quais são as suas vantagens?
  * Como o nome sugere, a ISA Modular adota uma abordagem de dividir as extensões com novas instruções em módulos que podem ou não ser adicionados a uma implementação de processador de acordo com as necessidades da aplicação. Não há necessidade de utilizarmos a ISA inteira (que pode conter uma série de instruções que não terão utilidade para a nossa aplicação).
  * No caso do RISC-V, existe um ISA/módulo básico (núcleo), chamado de RV32I, que executa uma pilha completa de software. O RV32I está congelado e nunca será alterado. Tal característica fornece estabilidade aos criadores de compiladores, desenvolvedores de sistemas operacionais e programadores de linguagem Assembly.
  * Como já foi dito, a modularidade vem de extensões padrão opcionais que o hardware pode incluir ou não, dependendo das necessidades da aplicação.
  * Tal fato permite implementações simples, muito pequenas e de baixo consumo de energia, que podem ser críticas para aplicações embarcadas.

## Vantagens do RISC-V
* O fato de possuir uma ISA modular simples e pequena faz com que o tamanho dos processadores que implementam essa ISA seja reduzido quando comparado a outras ISAs.
* Ademais, o fato de apresentar uma ISA simples faz com que o custo de documentação seja reduzido e facilita o processo de aprendizado dos clientes sobre como usar adequadamente as instruções da ISA.
* Outra vantagem que o RISC-V apresenta diz respeito a quantidade de registradores disponíveis para o uso. O acesso aos dados presentes em registradores é muito mais rápido do que o acesso aos dados que estão presentes na memória. Isso faz com que a tarefa de alocar os registradores (realizada pelo compilador) seja crucial para um bom desempenho de programa. Obviamente, essa tarefa se torna mais fácil a medida que o número de registradores aumenta. Nesse aspecto, o Intel x86-32 possui apenas 8 registradores, o ARM-32 possui 16 registradores enquanto que o RISC-V apresenta 32 registradores inteiros (um número bem generoso quando comparado com seus concorrentes).
* No que diz respeito à velocidade de código, o RISC-V se destaca pelo fato de que, normalmente, a execução de suas instruções leva no máximo 1 ciclo de clock (ignorando a ocorrência de cache miss na cache de instruções).
* Por fim, o RISC-V se destaca nesse aspecto de velocidade de execução de código por exigir nas suas instruções que todos os operandos estejam em registradores (não podem existir operandos na memória). Isso melhora a velocidade de acesso aos dados e, consequentemente, melhora o desempenho de execução do programa.

## Diferenças entre Arquitetura e Implementação
* Muitas pessoas acabam confundindo esses dois conceitos. E, por consequência, acabam usando tais termos intercambiavelmente. Entretanto, existem diferenças cruciais entre eles.
* A arquitetura diz respeito ao conhecimento que o programador de linguagem Assembly deve possuir para desenvolver/escrever um programa correto (no que diz respeito à sintaxe), sem se preocupar com o desempenho/eficiência do programa escrito. Cabe à implementação lidar com o desempenho dos programas escritos em Assembly. Quando estamos analisando esse aspecto, vemos que exigem diferentes estratégias de implementação, como por exemplo: Ciclo Simples, Multi-Ciclo, Pipeline, Superescalar (que executa mais de uma instrução por ciclo de clock), entre outras.
* Fazendo uma analogia, podemos enxergar a arquitetura como um blueprint/esboço/ideia e a implementação como uma estratégia/metodologia para executar tal ideia.
* Enquanto arquitetos não devem colocar recursos que ajudam apenas uma implementação em um determinado momento, esses também não devem colocar features que complicam algumas implementações..
