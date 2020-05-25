.section .text 
# diretiva de assembly RISC-V que indica que tudo que estiver abaixo disso será armazenado na "Text Section" no programa executável.

.global add 
# determina que "add" é um símbolo exportável ao qual outros módulos/arquivos podem ser referir no tempo de linkagem.
.type add, @function 
# indica que o tipo do símbolo "add" funcionará como uma função.

add:
  add a0, a0, a1 
  # 'a0' e 'a1' são os registradores que podem ser utilizados como parâmetros de funções e valores de retorno de funções.
  ret 
  # pseudo-instrução para retornar ao módulo que efetuou a chamada.
