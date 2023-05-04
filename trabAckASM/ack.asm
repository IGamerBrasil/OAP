##############################################################################
# Trabalho 1
# Nomes: Lucas Candemil Chagas, Lucca Bibiano, Marcio Menezes e Maria Eduarda
# Disciplina: Organizacao e Arquitetura de Processadores
# Professor: Miguel Gomes Xavier
# Data: 27/04/23
##############################################################################
# Fazer funcao de Ackermann em Assembly
#	int ackermann(int m, int n) {
#   		if (m == 0) {
#        		return n+1;
#    		}else if(m > 0 && n == 0) {
#        		return ackermann(m-1, 1);
#    		} else if(m > 0 && n > 0) {
#        		return ackermann(m-1, ackermann(m, n-1));
#    		}
#	}

	.data
msgInicial: 	.asciiz "Programa Ackermann\n"
mensagem: 	.asciiz "Digite os par�metros m e n para calcular A(m, n) ou -1 para abortar a execu��o:\n "
mensagemM: 	.asciiz "m: "
mensagemN: 	.asciiz "n: "
print_A:	.word			
mF:		.word	0
nF:		.word	0


	.text
	.globl main

main:		la $a0, msgInicial
		li $v0, 4 			#printa msgInicial no termianl
		syscall
		la $a0, mensagem
		li $v0, 4			#printa mensagem no termianl
		syscall
		la $a0, mensagemM
		li $v0, 4			#printa mensagemM no termianl
		syscall
		li $v0, 5			#permite digitar um numero e guardar em v0 
		syscall
		bltz $v0, numeronegativo	#se m for <=-1 encerra programa
		move $t0, $v0			#move o conteudo de v0 para t0
		la $a0, mensagemN
		li $v0, 4			#printa mensagemN no termianl
		syscall
		li $v0, 5			#permite digitar um numero e guardar em v0 
		syscall
		bltz  $v0, numeronegativo	#se n for <=-1 encerra programa
		move $t1, $v0 			#move o conteudo de v0 para t1
		
		la $a0, a(
		li $v0, 4
		la $a0, 0($t0)
		li $v0, 4
		la $a0, virgula
		li $v0, 4
					
		
		
		addiu $sp, $sp, -12		#cria a pilha
		sw $ra, 0($sp)			#guarda o primeiro ra do programa na pilha
		sw $t0, 4($sp)			#guarda o valor de $t0(m) na pilha
		sw $t1, 8($sp) 			#guarda o valor de $t1(n) na pilha
		jal ackermann			#entra na funcao
		move $t0, $a0			#ao final guarda o resulrado final de m em t0
		move $t1, $a1			#ao final guarda o resulrado final de n em t1
		la $t2, mF			#carrega o endereco para guardar o resultado final de m em t2
		la $t3, nF			#carrega o endereco para guardar o resultado final de n em t3
		sw $t0, 0($t2)			#guarda t0 em t2
		sw $t1, 0($t3)			#guarda t1 em t3	
		li $v0, 10 
		syscall
	
ackermann:	lw $a0, 4($sp)			#carrega o valor segundo valor da pilha em a0(m)
		lw $a1, 8($sp)			#carrega o valor segundo valor da pilha em a1(n)
		bnez $a0, if2			#primeiro corpo do if(m == 0) retorna n+1		
		addiu $a1, $a1, 1		#n+1		
		addiu $sp, $sp, -12		#cria a mais pilha		
		sw $ra, 0($sp)			#guarda ra na pilha
		sw $a0, 4($sp)			#guarda m na pilha
		sw $a1, 8($sp)			#guarda n = n+1 na pilha
		jal ret2 			#return final

if2:		bnez $a1, if3 			#se n != 0 vai pro terceiro if		
		addiu $a0, $a0, -1		#m-1
		addiu $a1, $zero, 1		#n = 1
		addiu $sp, $sp, -12		#cria a mais pilha	
		sw $ra, 0($sp)			#guarda onde iria retornar na pilha
		sw $a0, 4($sp)			#guarda m na pilha
		sw $a1, 8($sp)			#guarda n na pilha
		jal ret1			# ackermann(m - 1, 1)

if3:		addiu $a1, $a1, -1		#n-1		
		addiu $sp, $sp, -12		#cria a mais pilha	
		sw $ra, 0($sp)			#guarda onde iria retornar na pilha
		sw $a0, 4($sp)			#guarda m na pilha
		sw $a1, 8($sp)			#guarda n-1 na pilha
		jal retEsp			#ackermann(m, n - 1)		
		lw $a0, 4($sp)			#corpo do retona ackermann(m-1, n = ackermann(m, n - 1)	)
		addiu $sp, $sp, 12		#exclui 3 espacos na pilha
		addiu $a0, $a0, -1		#m-1			
		sw $a0, 4($sp)			#guarda de volta o m antes de entrar na funcao ackermann(m, n - 1)
		sw $a1, 8($sp)			#guarda o novo n na pilha
		jal ret1			#ackermann(m - 1, n)
			
ret1: 		jal ackermann 			#retorna para fazer denovo a funcao ackermann com os m e n modificados
		lw $ra, 0($sp)			#pega o ra da pilha
		lw $t0, 4($sp)			#pega o m da pilha
		lw $t1, 8($sp)			#pega o n da pilha
		addiu $sp, $sp, 12		#exclui os 3 espacos onde estavam o ra, m e n	
		jr $ra

ret2:		lw $ra, 0($sp)			#pega o ra da pilha
		lw $t0, 4($sp)			#pega o m da pilha
		lw $t1, 8($sp)			#pega o n da pilha
		addiu $sp, $sp, 12		#exclui os 3 espacos onde estavam o ra, m e n
		sw $t0, 4($sp)			#guarda novamente o m
		sw $t1, 8($sp)			#guarda novamente o n
		jr $ra

retEsp:		addiu $sp, $sp, -12		#cria mais pilha para por os resultados de m e n para ackermann(m, n - 1)	
		sw $ra, 0($sp)			#guarda m na pilha
		sw $a0, 4($sp)			#guarda m na pilha
		sw $a1, 8($sp)			#guarda n-1 na pilha
		jal ackermann			#faz ackermann(m, n - 1)	
		lw $ra, 0($sp)			#pega onde ira retornar
		jr $ra			
		
numeronegativo: li $v0, 10
		syscall
