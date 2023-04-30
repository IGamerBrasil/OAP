###############################################################################################
#
# Especificação: Somar elemento a elemento os dois vetores V1 e V2 e colocar resultado 
#		no terceiro vetor, V3
#
###############################################################################################
        
.text
	.globl main
	
	main:	
	
		
		la	$t1, v1			#endereco VETOR 1
		la	$t2, v2			#endereco VETOR 2
		la	$t3, v3			#enderco VETOR 3
		la	$t4, size		#endereco TAMANHO DOS VETORES
		
		lw 	$t4, 0($t4) #numeros a processar
	
	loop:	blez $t4, end #testa quantos falta processar, se 0 termina
		
		lw  $t5, 0($t1) #carrega proximo dado
		lw  $t6, 0($t2)	#carrega proximo dado
		
		add $t7, $t5, $t6 # soma elementos de v1 e v2
		
		sw $t7,0($t3)	#escreve/armazena o resultado da soma dos elementos de v1 e v2
		
		addi $t1, $t1, 4 #incrementa ponteiro pra v1
		addi $t2, $t2, 4 #incrementa ponteiro pra v2
		addi $t3, $t3, 4 #incrementa ponteiro pra v3
		
		addiu $t4, $t4, -1 #decrementa numero de elemntos a processar	
		
		j loop	 			
		
	end:	li $v0, 10 #10 = exit
		syscall #chamada do sistema
	
.data
	v1: 	.word 0x12 0xff 0x3 0x14 0x878 0x31 0x62 0x10 0x5 0x16 0x20
	v2: 	.word 0x12 0xff 0x3 0x14 0x878 0x31 0x62 0x10 0x5 0x16 0x20
	v3:   	.word 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0	
	size: 	.word 11
