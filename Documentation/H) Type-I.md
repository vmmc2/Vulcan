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
* __Significado: Addition Immediate(addi).__
* __Síntaxe: addi rd, rs1, imm__
* rs1 = registradores-fonte
* imm = imediato de 12 bits (com sinal, seguindo a convenção de complemento a 2)
* rd = registrador-destino
* __Operação Realizada: rd = rs1 + signalextend(imm[11:0]).__
* Essa instrução pega o valor imediato com sinal de 12 bits, aplica uma extensão de sinal nele para 32 bits. Depois disso, adiciona ele ao conteúdo do registrador rs1 e guarda o resultado no registrador-destino rd.
* __O overflow aritmético é ignorado.__

### 8) andi

### 9) ori

### 10) xori

### 11) slli

### 12) srli

### 13) srai

### 14) slti

### 15) sltiu

