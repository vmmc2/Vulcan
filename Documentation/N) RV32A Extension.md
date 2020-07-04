# RV32A Extension

## Intro
* A extensão RV32A adiciona instruções voltadas para multiprocessamento à ISA do RISC-V.
* O RV32A possui dois tipos de operações atômicas para a sincronização:
  * Operações de memória atômica (AMO).
  * Load reservado/Store condicional.
* As instruções AMO (Atomic Memory Operation) executam atomicamente uma operação em um operando na memória e "setam" o registrador de destino para o valor original da memória original.
* __Atômico significa que não pode haver interrupção entre a leitura e a escrita em memória, nem outros processadores podem modificar o valor da memória entre a leitura e escrita da memória da instrução AMO.__
* Load Reservado e Store Condicional fornecem uma operação atômica entre duas instruções.
* O Load Reservado lê uma palavra da memória, grava-a no registrador de destino e registra uma reserva nessa palavra na memória.
* O Store Condicional armazena uma palavra no endereço em um registrador de origem desde que exista uma reserva de carga nesse endereço de memória. Ele grava 0 no registrador de destino se a operação de Store tiver êxito, ou em caso contrário um código de erro diferente de zero.

## Instruções
* A extensão RV32A adiciona as seguintes instruções ao RISC-V.
![[rv32a](https://http://riscv.org/)](rv32a_instructions.png)

* O mapa de opcode das instruções do RV32A está mostrado abaixo:
![[rv32a_opcodes](https://http://riscv.org/)](rv32a_opcodes.png)
