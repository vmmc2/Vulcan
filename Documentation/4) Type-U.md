# Type-U Instructions

## Intro
* Essas instruções são aquelas responsáveis por lidar com valores imediatos longos.
* Fazer carregamento e ligação trabalhando com os valores imediatos longos.

## Instruções
### 1) lui
* __Síntaxe: lui rd, imm__
* imm = valor imediato/constante com sinal (de 20 bits).
* rd = registrador-destino
* __Operação Realizada: rd = signalextend(immediate[31:12] << 12).__
* Essa instrução pega o valor imediato presente na instrução (esse imediato pode ter no maximo 20 bits) e lembrando que é um imediato com sinal. Logo o seu range vai de: -2^19 ate (2^19) - 1.
* Depois de pegar esse imediato, ele vai deslocá-lo de 12 bits para a esquerda , preenchendo os bits vazios com 0.


### 2) auipc
