# RV32A Extension

## Intro
* A extensão RV32A adiciona instruções voltadas para multiprocessamento à ISA do RISC-V.
* O RV32A possui dois tipos de operações atômicas para a sincronização:
  * Operações de memória atômica (AMO).
  * Load reservado/Store condicional.
* As instruções AMO (Atomic Memory Operation) executam atomicamente uma operação em um operando na memória e "setam" o registrador de destino para o valor original da memória original.
* __Atômico significa que não pode haver interrupção entre a leitura e a escrita em memória, nem outros processadores podem modificar o valor da memória entre a leitura e escrita da memória da instrução AMO.__

## Instruções
