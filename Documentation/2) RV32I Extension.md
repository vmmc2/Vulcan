# RV32I Extension

## Introdução
* Nesse arquivo, faremos uma introdução e discussão sobre quais são todas as instruções presentes no módulo base/core do RISC-V: O RV32I. Além disso, veremos detalhadamente qual a sintaxe de cada uma das instruções e como ocorre a sua execução no código Assembly.
* Para exemplos de código mostrando o uso real dessas instruções em código Assembly favor visitar a pasta Examples (presente no diretório Documentation).

## Considerações Gerais Sobre as Instruções da ISA do RISC-V
* Todas as instruções da extensão base do RISC-V (RV32I) possuem tamanho de 32 bits (4 bytes = 1 word).
* Na ISA do RISC-V temos uma característica muito importante que favorece sua legibilidade e sua simplicidade (para a decodificação das instruções, por exemplo): Todas as instruções apresentam 3 operandos. Isso é diferente do que acontece com a ISA do Intel x86-32, que apresenta um campo compartilhado para origem e destino.
* Como já foi dito anteriormente, todos os operandos das instruções da ISA do RISC-V devem ser operandos de registradores. Tal característica favorece o desempenho no acesso de dados e, consequentemente, na execução do código Assembly.
* Quando uma operação possui naturalmente três operandos distintos, mas a ISA fornece apenas uma instrução de dois operandos, o compilador ou o programador de linguagem Assembly deve utilizar uma instrução de movimentação extra para preservar o operando de destino.
* Vale destacar que no RISC-V os especificadores dos registradores a serem lidos e escritos estão sempre no mesmo local em todas as instruções, o que significa que os acessos ao registradores podem começar antes do hardware iniciar a decodificação da instrução.
* Ademais, os campos imediatos nesses formatos são sempre com sinal, e o bit de sinal é sempre o bit mais significativo da instrução. Esta decisão significa que a extensão de sinal do imediato, que também pode estar em um caminho de cronometragem crítico, pode prosseguir antes de decodificar a instrução.
* Para ajudar os programadores, um padrão de bits preenchido por zeros é uma instrução ilegal no RV32I. Assim, saltos errôneos em regiões de memória zeradas serão imediatamente interceptados, ajudando a depuração.
* Pensando no futuro e na adição de outras extensões para a ISA do RISC-V, a extensão RV32I ocupa menos de 1/8 do espaço de codificação para a palavra de instrução de 32 bits.
* __IMPORTANTE__: __Finalmente, como veremos, os endereços de desvio e salto nos formatos B e J devem ser deslocados para a esquerda 1 bit, de modo a multiplicar os endereços por 2, dando assim desvio e saltos de maior alcance.__

## Formatos de Instrução
* A extensão base do RISC-V (RV32I) apresenta 6 formatos diferentes para suas instruções. São eles:
  * Tipo R: Contém instruções para operações de registradores.
  * Tipo I: Contém instruções para execução de loads e para lidar com valores imediatos curtos.
  * Tipo J: Contém instruções para execução de saltos incondicionais.
  * Tipo S: Contém instruções para execução de stores.
  * Tipo U: Contém instruções para lidar com valores imediatos longos.
  * Tipo B: Contém instruções para execução de desvios condicionais.
* Consequências: O tamanho fixo das instruções (32 bits) aliado à pequena quantidade de formatos diferentes (6) facilita o processo de decodificação das instruções e melhora o desempenho de custo.

## Conjunto de Registradores do RISC-V
* Registradores são a menor unidade responsável pelo armazenamento de dados. 
* Como é possível ver na imagem abaixo, temos destacado o conjunto de registradores da arquitetura RISC-V, bem como a nomenclatura de cada um deles conforme determinado pela Interface Binária de Aplicativo (ABI) do RISC-V.
* Por questões de simplicidade, nas explicações, nos exemplos usaremos apenas a nomenclatura provida pela ABI.
* Até o vigente momento, o Vulcan apenas suporta o uso dos registradores se eles forem nomeados seguindo as normas da ABI. (x0 - x31)
* Como é possível ver na imagem abaixo, a ISA do RISC-V possui 32 registradores, nomeados (segundo a ABI) de x0 ate x31.
* Caso estejamos trabalhando com a RV32I, temos que o tamanho dos registradores é de 32 bits.
* __O registrador x0 sempre irá possuir o valor 0 dentro de si. Esse valor é inalterado. (Funciona como uma constante).__
* Dedicar um registrador a zero foi uma decisão de arquitetura muito simples mas que foi uma fator surpreendentemente grande na simplificação da ISA do RISC-V. Como é possível checar em exemplos de operações que são instruções nativas no ARM-32 e no Intel x86-32, que não possuem um registrador zero, mas podem ser sintetizadas a partir das instruções do RV32I simplesmente utilizando o registrador zero como um operando.
* Por fim, fora os 32 registradores mencionados acima, o RISC-V apresenta um registrador especial chamado PC (Program Counter) ao qual o programador não tem acesso. O PC é o registrador responsável por indicar qual a próxima instrução que deve ser executada no nosso código. Alterá-lo pode desencadear efeitos colaterais imprevisíveis.
