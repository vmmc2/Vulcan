# Type-J Instructions

## Intro
* As instruções Type-J são aquelas que executam saltos incondicionais para outras partes do código.
* A única instrução do Type-J é a: __jal (jump and link).__
* __Essa instrução é muito utilizada para lidar com chamadas e retornos de função em Assembly(tem que explicar isso melhor dps).__
* __Do mesmo jeito que aconteceu com as instruções de Branch, na instrução "jal" a gente deveria trabalhar com labels ao invés de trabalhar com offsets. (Tem que também como eu vou implementar isso).__

## Instruções
### 1) jal
* __Significado: Jump and Link (jal).__
* __Síntaxe: jal rd, offset__
* offset = valor imediato/constante (com sinal) de 20 bits.
* rd = registrador-destino
* __Operação Realizada: (rd = pc + 4) ; (pc = pc + signextend(offset << 2))__
* Detalhadamente, essa instrução faz o seguinte: Ela salva o endereço da próxima instrução que deveria ser executada (pc + 4) no registrador-destino (rd). Usualmente, a gente usaria o registrador ra/x1 (já que ele é o registrador de endereço) para funcionar como rd, mas isso fica a critério do programador. Dá para usar x0 como rd também (geralmente a gente faz isso quando não se importa em retornar para a parte anterior do código).
Depois disso, a gente pega o offset, multiplica ele por 2 (por meio de um shift-left). Em seguida, dá um sign-extend nele para 32 bits e, por fim, soma ele ao PC para obter o endereço da próxima instrução a ser executada depois do salto incondicional.

