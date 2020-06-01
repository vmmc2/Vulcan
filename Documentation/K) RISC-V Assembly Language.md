# RISC-V Assembly Language

## Intro
* Desde o momento em que escrevemos um programa em uma linguagem de alto nível (C, por exemplo) até ele ser executado pelo computador, vale destacar que ele passa por 4 ferramentas (bastante uteis) que fazem com que o código escrito se torne um arquivo executável. São elas, em ordem:
  * Compilador.
  * Assembler (ou Montador).
  * Linker.
  * Loader.
![[registers](https://http://riscv.org/)](steps.png)
  
## Convenção de Chamada
* Quando queremos realizar uma chamada de função em nosso código é importante seguir um protócolo, afim de garantir que toda a execução do programa ocorra da forma adequada. Veremos, a seguir, quais são essas etapas que devem ser seguidas.
  1. Colocar os argumentos onde a função possa acessá-los.
  2. Saltar para a função (utilizando a instrução __jal__ do RV32I).
  3. Adquirir os recursos de armazenamento local que a função necessita, salvando registradores conforme necessário.
  4. Executar a tarefa desejada da função.
  5. Colocar o valor do resultado da função onde o programa de chamada possa acessá-lo, restaurar qualquer registrador e liberar quaisquer recursos de armazenamento local.
  6. Levando em conta que uma função pode ser chamada de vários pontos em um programa, retornar o controle para seu respectivo ponto de origem, executando a instrução __ret__.
* Por questões de desempenho, é aconselhavel guardar as variáveis nos registradores ao invés de armazená-las na memória (isso porque o acesso aos registradores é mais rápido do que o acesso à memória). Entretanto, evite ficar acessando a memória constantemente para salvar e restaurar o conteúdo dos registradores.

![[registerss](https://http://riscv.org/)](savedregisters.png)

* Os registradores f0-31 são registradores utilizados nas extensões de ponto-flutuante de precisão simples (RV32F-RV64F) e ponto-flutuante de precisão dupla (RV32D-RV64D).

## Explicações Extras
* A ideia do RISC-V é possuir registradores que não tem garantia de serem preservados durante uma chamada de função. Tais registradores são chamados de __registradores temporários (temporary registers).__
* Por outro lado, outros registradores possuem a garantia de serem preservados durante chamadas de função. Esses registradores são chamados de __registradores salvos (saved registers).__
* Funções que não realizam chamadas a outras funções são chamadas de __funções leaf.__ Quando uma função leaf possuir apenas alguns argumentos e variavéis locais significa que podemos manter esses dados em registradores, sem ter que derramar nada para a memória. Se tais condições persistirem, o programa não precisará salvar o conteúdo dos registradores na memória. Uma fração significativa de chamadas de função se encontram nessa categoria.
* A partir das convenções da ABI, é possível observar o código RV32I padrão para a entrada e saída de funções. Observe abaixo:
```asm
entry_label: 
  addi sp, sp, -framesize ; aloca espaço para o stackframe
                          ; para isso, a gente ajusta o stack pointer (registrador sp/x2)
  sw ra, framsize - 4, sp ; salva o endereço de retorno (presente no registrador ra/x1)
  ; salva outro registradores na pilha, caso seja necessário.
  .... ; corpo da função.
```
* Se existirem muitos argumentos e variáveis de função para serem alocados nos registradores, o "prologue" da função aloca espaço na pilha para o seu "frame". Depois que a tarefa da função estiver completa, a posição final ("epilogue") desfaz o stackframe e retorna ao ponto de origem da chamada de função.
```asm
; restaura o estado dos registradores da pilha, caso seja necessário.
  lw ra, framesize - 4, sp ; restaura registrador ra/x1
  addi sp, sp, framesize ; desaloca o espaço do stackframe
  ret ; retorna ao ponto de chamada.
```

## Assembly
* A entrada para essa etapa em sistemas Unix é um arquivo com extensão ".s" como, por exemplo: foo.s
* Já no caso do MS-DOS a extensão do arquivo é ".asm" como, por exemplo: foo.asm
* O trabalho realizado na etapa do Assembler não é só produzir código objeto (código em linguagem de máquina/binário) a partir do código em linguagem Assembly. É também trabalho dele estender essas instruções para incluir operações úteis para o programador Assembly ou para o desenvolvedor do compilador. Essa categoria, baseada em configurações inteligentes das instruções regulares, é chamada de pseudoinstruções. __Por enquanto, o Vulcan não tem suporte para as pseudoinstruções.__

## Diretivas
* Diretivas são os comandos que iniciam com um ponto "."
* __De maneira mais detalhada, as diretivas são comandos específicos para o assembler, e não código para ser traduzido por ele.__
* __Tais diretivas informam ao Assembler onde colocar código e dados, especificam constantes de código e dados para uso no programa e assim por diante.__
* Segue abaixo uma tabela com as diretivas de Assembly RISC-V mais comuns:


## Linker
* Em vez de compilar todo o código-fonte a cada vez que um arquivo é alterado, o Linker (ou ligador) permite que arquivos individuais sejam compilados e montados separadamente.
* Ele "costura" o novo código objeto junto aos módulos de linguagem de máquina existentes, como bibliotecas.
* __Seu nome é derivado de uma de suas tarefas, que é editar todos os links das instruções de jump and link no arquivo objeto.__
* Em sistemas Unix, a entrada para o linker são arquivos com o sufixo .o (Ex: foo.o , libc.o), e sua saída é um arquivo a.out.
* Para MS-DOS, as entradas são arquivos com o sufixo .OBJ ou .LIB e a saída é um arquivo .EXE.
* __A figura abaixo indica os endereços dos segmentos de memória mais comuns em um típico programa RISC-V (inclui os segmentos de memória alocados para código e dados):__
