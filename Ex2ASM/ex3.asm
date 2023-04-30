############################################################################################### 
#
# Especificação: Desenvolver programa que computa os elementos comuns aos vetores de inteiros
#		V1 e V2. Os elementos comuns devem ser armazenados no vetor V3, que
#		inicialmente contém apenas 0s. Escolha o que fazer quando um mesmo
#		inteiro aparece duas ou mais vezes no mesmo vetor. Ao final do algoritmo
#		armazenar em comuns o número de elementos comuns encontrados.
#
# Algoritmo que computa um vetor contendo os elementos comuns a 2 vetores
# 	Em comums deve ir o número de elementos comuns
#	O valor size é igual para os três vetores
#
###############################################################################################

	.data                   

V1:	.word	0x12 0xff 0x3 0x14 0x878
V2:	.word	0x12 0x3 0x33 0x4  0x5
V3:	.word	0x0  0x0  0x0 0X0  0x0   

size:	.word	5     
comuns:	.word	0			# Neste caso resposta deve ser 2.

    .text
    .globl main

main:   la $t0, V1		#end[0] de V1
        la $t1, V2		#end[0] de V2
        la $t2, V3		#end[0] de V3
        
        la $t3, size
        
        la $t4, comuns
        
        lw $t4, 0($t4) #carrega comum
        
        lw $t5, 0($t3)	#carrega size para loop1      
        lw $s1, 0($t3) #carrega size para loop2
        
        lw $t6, 0($t0) #carrega elemento de v1[0]
        lw $t7, 0($t1) #carrega elemento de v2[0]
        
        
loopV1:   	beqz $t5, fim #se size = 0 termina o loop
	  	bne $s1, $zero, loopV2 #se size do loop2 nao for 0 vai pro loop
	  	lw $s1, 0($t3) #reseta size do loop2
	 
		addiu $t0, $t0, 4
		lw $t6, 0($t0)
		la $t1, V2
		lw $t7, 0($t1)
	  	addiu $t5, $t5, -1
	
	  	j loopV1
	
loopV2:		beq $s1, $zero, loopV1
	 	beq $t6, $t7, igual
		addiu $t1, $t1, 4
		lw $t7, 0($t1)	
	
		addiu $s1, $s1, -1
		j loopV2

igual:		addiu $t4, $t4, 1
		sw $t7, 0($t2) #armazena no V3
		addiu $t2,$t2, 4
		addiu $t1, $t1, 4 
		addiu $s1, $s1, -1
		lw $t7, 0($t1)	
		j loopV2
		
fim: 	li $v0, 10
	syscall