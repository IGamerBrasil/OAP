###############################################################################################
#
# Especificação: Desenvolver programa que realiza uma divisão do inteiro dividendo pelo
#		inteiro divisor, gerando os inteiros quociente e resto. Usar o algoritmo
#		de subtrações sucessivas que opera como especificado abaixo:
#
#   Exemplo de divisão de 10 por 3 usando subtrações sucessivas:
#   [Dividendo] [Divisor]  [Dividendo-Divisor]  Contador 
#      10           3               7               1 
#       7           3               4               2 
#       4           3               1               3 
#   dividendo    divisor          resto         quociente
#
###############################################################################################

		.data
        
dividendo:	.word	0xFAAA	# Base 10: 64170 
divisor:	.word	0x83	# Base 10: 131

quociente:	.word	0	# resposta deve ser: 489 (0x1E9)
resto:		.word	0	# resposta deve ser: 111 (0x6f)


        .text
        .globl main

main:   la $t0, dividendo #carrega o endereco do dividendo
	lw $t0, 0($t0)
	
	la $t1, divisor #carrega o endereco do divisor
	lw $t1, 0($t1)
	
	li $t2, 0 #carrega o imediato 0 em $t2
	
	
	la $t3, resto #carrega o endereco do resto
	
loop: 	blt $t0, $t1, fim #se dividendo for igual ao divisor ou menor
	beq $t0, $t1, tZero
	
	subu $t0, $t0, $t1
	
	addiu $t2, $t2, 1
	
	sw $t0, 0($t3)
	
	j loop
	
tZero:	lw $zero, 0($t3)

fim:	la $t4, quociente
	sw $t2, 0($t4)
	li		$v0,10		# Coloca o valor 10 no %v0, indicando o servi?o fim de execu??o
	syscall				# Chamada do sistema para finalizar a execu??o em si

	
	
	
	
	
