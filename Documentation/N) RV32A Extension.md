# RV32A Extension

## Intro
* A extensão RV32A adiciona instruções voltadas para multiprocessamento à ISA do RISC-V.
* A RV32A possui dois tipos de operações atômicas para a sincronização:
  * Operações de memória atômica (AMO).
  * Load reservado/Store condicional.
* As instruções AMO (Atomic Memory Operation) executam atomicamente uma operação em um operando na memória e "setam" o registrador de destino para o valor original da memória original.
* __Atômico significa que não pode haver interrupção entre a leitura e a escrita em memória, nem outros processadores podem modificar o valor da memória entre a leitura e escrita da memória da instrução AMO.__
* Load Reservado e Store Condicional fornecem uma operação atômica entre duas instruções.
* O Load Reservado lê uma palavra da memória, grava-a no registrador de destino e registra uma reserva nessa palavra na memória.
* O Store Condicional armazena uma palavra no endereço em um registrador de origem desde que exista uma reserva de carga nesse endereço de memória. Ele grava 0 no registrador de destino se a operação de Store tiver êxito, ou em caso contrário um código de erro diferente de zero (__No caso do Vulcan, optei por colocar esse código de erro com o valor -1__).

## Instruções
* A extensão RV32A adiciona as seguintes instruções ao RISC-V.
![[rv32a](https://http://riscv.org/)](rv32a_instructions.png)

* O mapa de opcode das instruções do RV32A está mostrado abaixo:
![[rv32a_opcodes](https://http://riscv.org/)](rv32a_opcodes.png)

### 1) amoadd.w
* __Significado: Atomic Addition Word (amoadd.w).__
* __Síntaxe: amoadd.w rd, rs2, rs1__
* rs1/rs2 = registradores-fonte
* rd = registrador-destino
* __Operação Realizada: Essa instrução funciona da seguinte maneira: Atomicamente, deixa t ser o valor da palavra de memória no endereço x[rs1] (t = memória[x[rs1]]), em seguida seta essa palavra de memoria para t + x[rs2] (memoria[x[rs1]] = t + x[rs2]). Por fim, seta x[rd] para a extensão de sinal de t (x[rd] = t).__ 
