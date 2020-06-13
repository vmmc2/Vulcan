# Type-I Instructions

## Intro

## Instruções 
### 1) lb
* __Significado: Load Byte (lb).__
* __Síntaxe: lb rd, offset, rs1__
* rs1 = registrador-fonte
* offset = offset de 12 bits (com sinal, seguindo a convenção de complemento a 2)
* rd = registrador-destino
* __Operação Realizada: rd = signalextend(memória[rs1 + signalextend(offset)][7:0]).__
* Essa instrução funciona da seguinte maneira. O primeiro passo é calcular o endereço de memória: pegamos o valor do immediato de 12 bits com sinal e aplicamos uma extensão de sinal nele para 32 bits. Feito isso, somamos esse valor ao conteúdo do registrador rs1. Obtemos assim o endereço de memória desejado. Após isso, vamos até aquele endereço e carregamos 1 byte dele (O byte menos significativo, seguindo a convenção Little-Endian). Depois disso, aplicamos uma extensão de sinal nesse byte e o armazenamos no registrador-destino rd.

### 2) lh
* __Significado: Load HalfWord (lh).__
* __Síntaxe: lh rd, offset, rs1__
* rs1 = registrador-fonte
* offset = offset de 12 bits (com sinal, seguindo a convenção de complemento a 2)
* rd = registrador-destino
* __Operação Realizada: rd = signalextend(memória[rs1 + signalextend(offset)][15:0]).__
* Essa instrução funciona da seguinte maneira. O primeiro passo é calcular o endereço de memória: pegamos o valor do immediato de 12 bits com sinal e aplicamos uma extensão de sinal nele para 32 bits. Feito isso, somamos esse valor ao conteúdo do registrador rs1. Obtemos assim o endereço de memória desejado. Após isso, vamos até aquele endereço e carregamos 2 bytes (1 halfword) dele (Os 2 bytes menos significativos, seguindo a convenção Little-Endian). Depois disso, aplicamos uma extensão de sinal nessa halfword e a armazenamos no registrador-destino rd.

### 3) lw
* __Significado: Load Word (lw).__
* __Síntaxe: lw rd, offset, rs1__
* rs1 = registrador-fonte
* offset = offset de 12 bits (com sinal, seguindo a convenção de complemento a 2)
* rd = registrador-destino
* __Operação Realizada: rd = signalextend(memória[rs1 + signalextend(offset)][31:0]).__
* Essa instrução funciona da seguinte maneira. O primeiro passo é calcular o endereço de memória: pegamos o valor do immediato de 12 bits com sinal e aplicamos uma extensão de sinal nele para 32 bits. Feito isso, somamos esse valor ao conteúdo do registrador rs1. Obtemos assim o endereço de memória desejado. Após isso, vamos até aquele endereço e carregamos os 4 bytes (1 word) dele (Os 4 bytes menos significativos, seguindo a convenção Little-Endian). Depois disso, aplicamos uma extensão de sinal nessa word e a armazenamos no registrador-destino rd.

### 4) lbu
* __Significado: Load Byte Unsigned (lbu).__
* __Síntaxe: lbu rd, offset, rs1__
* rs1 = registrador-fonte
* offset = offset de 12 bits (com sinal, seguindo a convenção de complemento a 2)
* rd = registrador-destino
* __Operação Realizada: rd = signalextend(memória[rs1 + signalextend(offset)][7:0]).__
* Essa instrução funciona da seguinte maneira. O primeiro passo é calcular o endereço de memória: pegamos o valor do immediato de 12 bits com sinal e aplicamos uma extensão de sinal nele para 32 bits. Feito isso, somamos esse valor ao conteúdo do registrador rs1. Obtemos assim o endereço de memória desejado. Após isso, vamos até aquele endereço e carregamos 1 byte dele (O byte menos significativo, seguindo a convenção Little-Endian). Depois disso, aplicamos uma extensão de zero (0) nesse byte e o armazenamos no registrador-destino rd.

### 5) lhu
* __Significado: Load HalfWord Unsigned (lhu).__
* __Síntaxe: lhu rd, offset, rs1__
* rs1 = registrador-fonte
* offset = offset de 12 bits (com sinal, seguindo a convenção de complemento a 2)
* rd = registrador-destino
* __Operação Realizada: rd = signalextend(memória[rs1 + signalextend(offset)][15:0]).__
* Essa instrução funciona da seguinte maneira. O primeiro passo é calcular o endereço de memória: pegamos o valor do immediato de 12 bits com sinal e aplicamos uma extensão de sinal nele para 32 bits. Feito isso, somamos esse valor ao conteúdo do registrador rs1. Obtemos assim o endereço de memória desejado. Após isso, vamos até aquele endereço e carregamos 2 bytes (1 halfword) dele (Os 2 bytes menos significativos, seguindo a convenção Little-Endian). Depois disso, aplicamos uma extensão de zero (0) nessa halfword e a armazenamos no registrador-destino rd.

### 6) jalr
* __Significado: Jump and Link Register (jalr).__
* __Síntaxe: jalr rd, offset, rs1__
* rs1 = registrador-fonte
* offset = offset de 12 bits (com sinal, seguindo a convenção de complemento a 2)
* rd = registrador-destino
* __Operação Realizada: t = pc + 4 ; pc = (rs1 + signalextend(offset))&~1 ; rd = t.__
* Essa instrução copia o registrador pc para rs1 + signalextend(offset), mascarando o bit mais significativo do endereço calculado, então grava o valor anterior do pc + 4 no registrador-destino rd. Se rd for omitido, x1 é assumido.
* Explicando de uma outra maneira: A instrução acima pega o de pc atual (antes da execução) soma mais 4 e guarda o valor no registrador rd. Por fim, ela atualiza o registrador pc setando o seu valor para a soma offset + conteudo de rs1. Lembrando que o endereçamento no RISC-V é feito por byte.
* Essa instrução é muito útil para realizar chamadas de função.

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
* shamt = imediato de 5 bits (sem sinal). Em outras palavras, temos que: shamt[4:0]
* rd = registrador-destino
* __Operação Realizada: rd = rs1 << (shamt).__
* Essa instrução desloca o conteúdo do registrador-fonte rs1 em shamt posições para a esquerda. Os bits vazios são preenchidos com zeros (0) e o resultado de 32 bits com sinal é armazenado no registrador-destino rd.
* __Para o RV32I, essa instrução só é permitida quando shamt[5] = 0.__
* __Não faz sentido o imediato ser negativo. Logo, ele não pode ser negativo.__

### 12) srli
* __Significado: Shift-Right Logical Immediate (srli).__
* __Síntaxe: srli rd, rs1, shamt__
* rs1 = registrador-fonte
* shamt = imediato de 5 bits (sem sinal). Em outras palavras, temos que: shamt[4:0]
* rd = registrador-destino
* __Operação Realizada: rd = rs1 >>(u) (shamt).__
* Essa instrução desloca o conteúdo do registrador-fonte rs1 em shamt posições para a direita. Os bits vazios são preenchidos com zeros (0) e o resultado de 32 bits com sinal é armazenado no registrador-destino rd.
* __Para o RV32I, essa instrução só é permitida quando shamt[5] = 0.__
* __Não faz sentido o imediato ser negativo. Logo, ele não pode ser negativo.__

### 13) srai
* __Significado: Shift-Right Arithmetic Immediate (srai).__
* __Síntaxe: srai rd, rs1, shamt__
* rs1 = registrador-fonte
* shamt = imediato de 5 bits (sem sinal). Em outras palavras, temos que: shamt[4:0]
* rd = registrador-destino
* __Operação Realizada: rd = rs1 >>(s) (shamt).__
* Essa instrução desloca o conteúdo do registrador-fonte rs1 em shamt posições para a direita. Os bits vazios são preenchidos com cópias do bit mais significativo de rs1 e o resultado de 32 bits com sinal é armazenado no registrador-destino rd.
* __Para o RV32I, essa instrução só é permitida quando shamt[5] = 0.__
* __Não faz sentido o imediato ser negativo. Logo, ele não pode ser negativo.__

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
