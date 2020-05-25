addi x6, x0, 8
addi x7, x0, 6
addi x8, x0 -4
j function
# o comando acima executa um jump incondicional para a label "function".

function:
	  add x10, x6, x7
    add x11, x6, x8
    add x12, x7, x8
