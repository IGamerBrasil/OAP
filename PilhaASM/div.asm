#
#	Faça um programa que chama uma rotina recursiva em linguagem de montagem 
#	para o processador MIPS que tem por função dividir um número
#	natural por dois.
#
#	O código em linguagem C é 
#	1.  main(){
#	2. 	int n = 10;
#	3.	int result = 0;
#	4.	result = div2(n);
#	5.  }
#	6.
#	7.  div2(int a){
#	8. 	if(a < 2) return 0;
#	9. 	if(a = 2) return 1;
#	10. 	return (1 + div2(a - 2));
#	11. }

	.data
n:	.word	10
result:	.word	0

	.text
	.globl	main
	
main:		la $t0, n #carrega endereço de n
		lw $t0, 0($t0)	#carrega a word n
		addiu $sp, $sp, -8 #cria a pilha
		sw $ra, 0($sp)	
		sw $t0, 4($sp)
		jal div2
		lw	$ra,0($sp)	# Na volta, recupera endereço de retorno para SO
		lw	$t0,4($sp)	# busca na pilha o valor de div2(n)
		addiu	$sp,$sp,8	# desaloca 8 bytes da pilha
		la	$t1,result
		sw 	$t0,0($t1)	# e escreve em result div2(n)

		li	$v0,10		# para terminar, cai fora do programa
		syscall


div2:		lw   $t0, 4($sp)

		#primeiro if da recursao
		slti $t1, $t0, 2 #seta t1 para 1 se eh menor que 2 ou 0 se eh maior que 2
		beqz $t1, maiorigual2
		sw $zero, 4($sp) #retorna 0
		jr $ra

maiorigual2: 	addiu $t1, $t0, -2 #verifica se eh zero, significando que a = 2
		bnez $t1, maior2
		addiu $t1, $zero, 1 #retorna 1
		sw $t1, 4($sp)
		jr $ra

maior2:		lw $t0, 4($sp)

		addiu $t0, $t0, -2 #a-2
		addiu $sp, $sp, -8
		sw $ra, 0($sp)
		sw $t0, 4($sp)
		jal div2  #div(a-2)
		
		lw $ra, 0($sp)
		lw $t0, 4($sp)
		
		addiu $sp, $sp, 8
		
		addiu $t0, $t0, 1
		
		sw $t0, 4($sp)
		
		jr $ra
		
		
		
		

	     
