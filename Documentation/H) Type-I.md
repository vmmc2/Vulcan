# Type-I Instructions

## Intro

## Instruções 
### 1) lb

### 2) lh

### 3) lw

### 4) lbu

### 5) lhu

### 6) jalr

### 7) addi
* __Significado: Addition Immediate (addi).__
* __Síntaxe: addi rd, rs1, imm__
* rs1 = registrador-fonte
* imm = imediato de 12 bits (com sinal, seguindo a convenção de complemento a 2)
* rd = registrador-destino
* __Operação Realizada: rd = rs1 + signalextend(imm).__
* Essa instrução pega o valor imediato com sinal de 12 bits, aplica uma extensão de sinal nele para 32 bits. Depois disso, adiciona ele ao conteúdo do registrador rs1 e guarda o resultado no registrador-destino rd.
* __O overflow aritmético é ignorado.__

### 8) andi
* __Significado: And Bit-a-Bit Immediate (andi).__
* __Síntaxe: andi rd, rs1, imm__
* rs1 = registrador-fonte
* imm = imediato de 12 bits (com sinal, seguindo a convenção de complemento a 2)
* rd = registrador-destino
* __Operação Realizada: rd = rs1 & signalextend(imm).__
* Essa instrução pega o valor imediato com sinal de 12 bits, aplica uma extensão de sinal nele para 32 bits. Depois disso, aplica um AND Bit-a-Bit entre esse valor extendido do imediato e o conteúdo do registrador rs1 e guarda o resultado no registrador-destino rd.

### 9) ori
* __Significado: Or Bit-a-Bit Immediate (ori).__
* __Síntaxe: ori rd, rs1, imm__
* rs1 = registrador-fonte
* imm = imediato de 12 bits (com sinal, seguindo a convenção de complemento a 2)
* rd = registrador-destino
* __Operação Realizada: rd = rs1 | signalextend(imm).__
* Essa instrução pega o valor imediato com sinal de 12 bits, aplica uma extensão de sinal nele para 32 bits. Depois disso, aplica um OR (Ou Inclusivo) Bit-a-Bit entre esse valor extendido do imediato e o conteúdo do registrador rs1 e guarda o resultado no registrador-destino rd.

### 10) xori
* __Significado: Xor Bit-a-Bit Immediate (xori).__
* __Síntaxe: xori rd, rs1, imm__
* rs1 = registrador-fonte
* imm = imediato de 12 bits (com sinal, seguindo a convenção de complemento a 2)
* rd = registrador-destino
* __Operação Realizada: rd = rs1 ^ signalextend(imm).__
* Essa instrução pega o valor imediato com sinal de 12 bits, aplica uma extensão de sinal nele para 32 bits. Depois disso, aplica um XOR (Ou Exclusivo) Bit-a-Bit entre esse valor extendido do imediato e o conteúdo do registrador rs1 e guarda o resultado no registrador-destino rd.

### 11) slli
* __Significado: Shift-Left Logical Immediate (slli).__
* __Síntaxe: slli rd, rs1, shamt__
* rs1 = registrador-fonte
* shamt = imediato de 6 bits (com sinal, seguindo a convenção de complemento a 2). Em outras palavras, temos que: shamt[5:0]
* rd = registrador-destino
* __Operação Realizada: rd = rs1 << (shamt).__
* Essa instrução desloca o conteúdo do registrador-fonte rs1 em shamt posições para a esquerda. Os bits vazios são preenchidos com zeros (0) e o resultado de 32 bits com sinal é armazenado no registrador-destino rd.
* __Para o RV32I, essa instrução só é permitida quando shamt[5] = 0.__

### 12) srli
* __Significado: Shift-Right Logical Immediate (srli).__
* __Síntaxe: srli rd, rs1, shamt__
* rs1 = registrador-fonte
* shamt = imediato de 6 bits (com sinal, seguindo a convenção de complemento a 2). Em outras palavras, temos que: shamt[5:0]
* rd = registrador-destino
* __Operação Realizada: rd = rs1 >>(u) (shamt).__
* Essa instrução desloca o conteúdo do registrador-fonte rs1 em shamt posições para a direita. Os bits vazios são preenchidos com zeros (0) e o resultado de 32 bits com sinal é armazenado no registrador-destino rd.
* __Para o RV32I, essa instrução só é permitida quando shamt[5] = 0.__

### 13) srai
* __Significado: Shift-Right Arithmetic Immediate (srai).__
* __Síntaxe: srai rd, rs1, shamt__
* rs1 = registrador-fonte
* shamt = imediato de 6 bits (com sinal, seguindo a convenção de complemento a 2). Em outras palavras, temos que: shamt[5:0]
* rd = registrador-destino
* __Operação Realizada: rd = rs1 >>(s) (shamt).__
* Essa instrução desloca o conteúdo do registrador-fonte rs1 em shamt posições para a direita. Os bits vazios são preenchidos com cópias do bit mais significativo de rs1 e o resultado de 32 bits com sinal é armazenado no registrador-destino rd.
* __Para o RV32I, essa instrução só é permitida quando shamt[5] = 0.__

### 14) slti
* __Significado: Set If Less Than Immediate (slti).__
* __Síntaxe: slti rd, rs1, imm__
* rs1 = registrador-fonte
* imm = imediato de 12 bits (com sinal, seguindo a convenção de complemento a 2).
* rd = registrador-destino
* __Operação Realizada: rd = rs1 <(s) signalextend(imm) ? 1 : 0.__
* Essa instrução checa se o valor no registrador rs1 é menor do que o valor do immediato imm (depois de ele ter sofrido extensão de sinal) (analisando ambos os valores como números com sinal, seguindo o formato de complemento a 2). Se isso for verdade, seta o valor do registrador-destino rd para 1. Caso contrário, seta ele para 0.

### 15) sltiu
* __Significado: Set If Less Than Immediate Unsigned (sltiu).__
* __Síntaxe: sltiu rd, rs1, imm__
* rs1 = registrador-fonte
* imm = imediato de 12 bits (com sinal, seguindo a convenção de complemento a 2).
* rd = registrador-destino
* __Operação Realizada: rd = rs1 <(u) signalextend(imm) ? 1 : 0.__
* Essa instrução checa se o valor no registrador rs1 é menor do que o valor do immediato imm (depois de ele ter sofrido extensão de sinal) (analisando ambos os valores como números sem sinal). Se isso for verdade, seta o valor do registrador-destino rd para 1. Caso contrário, seta ele para 0.
