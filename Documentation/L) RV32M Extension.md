# RV32M Extension

## Intro
* A extensão RV32M é responsável por adicionar instruções de multiplicação e divisão de números inteiros à extensão base RV32I.
* A RV32M tem instruções de divisão para números inteiros com e sem sinal: divide (div) e divide unsigned (divu), que colocam o quociente no registrador-destino.
* De forma menos frequente, os programadores podem querer o resto de uma divisão ao invés do quociente. Tendo isso em mente, a extensão RV32M oferece as instruções: remainder (rem) e remainder unsigned (remu), que gravam o resto da divisão em vez do quociente no registrador-destino.
* __A figura abaixo é uma listagem de todas as instruções disponíveis na extensão RV32M:__
![[rv32m](https://http://riscv.org/)](rv32m.png)
