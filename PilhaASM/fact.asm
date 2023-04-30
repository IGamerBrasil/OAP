# fatorial (recursivo)
#
# Programa que calcula o fatorial de um n�mero inteiro sem sinal.
#	* Chama a fun��o fact, que faz todo o trabalho.
#	* fact � uma fun��o recursiva. Ela retorna o resultado de
#	seu processamento no registrador de valor, $v0.
#	* A pilha, apontada pelo registrador $sp, � usada para
#	armazenar os endere�os de retorno e para armazenar o par�metro
#	da chamada.
#
# main()
# {
#		int num=10;
#		int result=0;
#		result = fact(num);
# }
#
# int fact (int n)
# {
#		if(n<=1)
#			return 1;
#		else return (n * fact (n - 1));
# }
#

	.data 
num:	.word	10
result:	.word	0

	.text
	.globl main
	
main:	la $t4, num
	la $t1, result	
	
	lw $t0,0($t4)
	
	addiu $sp, $sp, -8
	sw $ra, 0($sp)
	sw $t0, 4($sp)
	
	jal fact
	
	lw $t0,0($t4)
	
	mul $t2, $t1, $t0
	
	
	li $v0, 10
	syscall
	
fact:	lw $t0, 4($sp)
	slti	$a0, $t0, 1
	subiu 	$a1, $t0, 1
	bne 	$a0, $a1, naoehmenor1
	
	addiu $t1, $zero, 1
	
	jr $ra

naoehmenor1:	lw $t0, 4($sp)
		
		addiu $t1, $t0, -1
		
		addiu $sp, $sp, -8
		sw $ra, 0($sp)
		sw $t1, 4($sp)
		
		jal fact
		
		lw $ra, 0($sp)
		lw $t0, 4($sp)
		
		addiu $sp, $sp, 8
		
		sw $t1, 4($sp)
		
		jr $ra
		
		