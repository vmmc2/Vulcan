# Type-S Instructions

## Intro
* As instruções do tipo-S são aquelas instruções que executam stores.
* Store nada mais é do que uma operação de transferência de dados de um registrador para a memória. Mais especificamente, para um endereço de memória específico.

## Instruções 
### 1) sb
* __Significado: Add Upper Immediate (auipc).__
* __Síntaxe: auipc rd, imm__
* imm = valor imediato/constante (com sinal) de 20 bits.
* rd = registrador-destino
* __Operação Realizada: rd = pc + signalextend(immediate[31:12] << 12).__
* Essa instrução pega o valor imediato (com sinal) de 20 bits. Depois disso, aplica extensao de sinal nele e dá um shift left nele de 12 bits. Por fim, adiciona esse valor de 32 bits ao valor do registrador pc (Program Counter) e o guarda no registrador-destino (rd).

### 2) sh

### 3) sw
