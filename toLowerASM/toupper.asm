# 
# 
#	Este programa transforma todas as letras minúsculas 
# 	da cadeia (texto) na letra maiúscula correspondente.
#

		.data
texto:	.asciiz	"Mamae me ama!"	# cadeia a manipular

        .text
        .globl main

main:   la $t0, texto #ponteiro para o primeiro bit

        la $a0, texto
        li $v0, 4
        syscall

lacotoupper:    lb $t1, 0($t0)
                blez $t1, fim
                
                slti $t2, $t1, 0x7B #se for letra maiuscula seta t2 pra 0 e se nao pra 1
                blez $t2, naoehletramin #verifica se t2 eh 0
                slti $t2, $t1, 0x61 #se nao for letra seta t2 pra 1 e se for pra 0
                bnez $t2, naoehletramin
                
                addiu $t1, $t1, -32 #caso ache ele pega a maiuscula dessa letra
                
                sb $t1, 0($t0)
                 	
naoehletramin: addiu $t0, $t0, 1 #vai para o proximo bit da frase
	     j lacotoupper #volta pro loop
	     
fim:	
		la		$a0,texto	# Estas tr�s linhas imprimem a 
		li		$v0,4		# cadeia depois do processamento 
		syscall

		li		$v0,10		# Syscall para finalizar o programa
		syscall