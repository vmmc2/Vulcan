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
