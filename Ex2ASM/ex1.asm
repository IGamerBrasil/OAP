###############################################################################################
#
# Especificação: Somar elemento a elemento os dois vetores V1 e V2 e colocar resultado 
#		no terceiro vetor, V3
#
###############################################################################################
        
	.data			

V1:	.word	0x12 0xff 0x3 0x14 0x878 0x31  0x62 0x10 0x5 0x16 0x20
V2:	.word	0x12 0xff 0x3 0x14 0x878 0x31  0x62 0x10 0x5 0x16 0x20
V3:	.word	0x0  0x0  0x0 0X0  0x0   0x0   0x0  0X0  0x0  0x0  0x0 

size:	.word	11	


	.text
	.globl main

main:	la $t0, V1 #indice do v1
	
	la $t2, V2 #indice v2
	
	la $t5, V3
	
	la $t6, size
	
	lw $t6, 0($t6)
	
loop:   blez $t6, fim
 	
 	lw $t1, 0($t0)	#carrega o valor do proximo indice de v1
	lw $t3, 0($t2)  #carrega o valor do proximo indice de v2
	
	add  $t4, $t1, $t3 #soma
	
	sw   $t4, 0($t5) #guarda a soma de v1 e v2 em v3
	
	addiu $t0, $t0, 4 #somar com 4 para pegar a proxima pos por que cada um tem 4 bytes
	addiu $t2, $t2, 4 #somar com 4 para pegar a proxima pos por que cada um tem 4 bytes
	addiu $t5, $t5, 4 #somar com 4 para pegar a proxima pos por que cada um tem 4 bytes
	addiu $t6, $t6, -1 #decrementa o size ate chegar a 0
	
	j	loop

fim:  	li		$v0,10		# Coloca o valor 10 no %v0, indicando o serviço fim de execução
	syscall				# Chamada do sistema para finalizar a execução em si
