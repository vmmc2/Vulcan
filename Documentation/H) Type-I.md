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

### 12) srli

### 13) srai

### 14) slti

### 15) sltiu

