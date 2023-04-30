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
#        		return n + 1;
#    		} else if (m > 0 && n == 0) {
#        		return ackermann(m - 1, 1);
#    		} else if (m > 0 && n > 0) {
#        		return ackermann(m - 1, ackermann(m, n - 1));
#    		}
#	}

	.data
msgInicial: 	.asciiz "Programa Ackermann\n"
mensagem: 	.asciiz "Digite os parâmetros m e n para calcular A(m, n) ou -1 para abortar a execução:\n "
mensagemM: 	.asciiz "m: "
mensagemN: 	.asciiz "n: "


	.text
	.globl main

main:		la $a0, msgInicial
		li $v0, 4
		syscall
		
		la $a0, mensagem
		li $v0, 4
		syscall
		
		la $a0, mensagemM
		li $v0, 4
		syscall
		li $v0, 5
		syscall
	
		blez $v0, numeronegativo
		move $t0, $v0	#m
	
		la $a0, mensagemN
		li $v0, 4
		syscall
		li $v0, 5
		syscall
		
		blez $v0, numeronegativo
		move $t1, $v0 		#n
		addiu $sp, $sp, -12	#cria a pilha
		
		sw $ra, 0($sp)
		sw $t0, 4($sp)
		sw $t1, 8($sp) 
		jal ackermann
		li $v0, 10 
		syscall
	
ackermann:	lw $a0, 4($sp)
		lw $a1, 8($sp)		
		bnez $a0, if2	#primeiro corpo do if(m == 0) retorna n+1		
		addiu $a1, $a1, 1	#n+1		
		addiu $sp, $sp, -12	#cria a mais pilha		
		sw $ra, 0($sp)
		sw $a0, 4($sp)
		sw $a1, 8($sp)
		jal ret2 #return final

if2:		lw $a0, 4($sp)
		lw $a1, 8($sp)		
		bnez $a1, if3 #se n != 0 vai pro terceiro if		
		addiu $a0, $a0, -1	#m-1
		addiu $a1, $zero, 1		
		addiu $sp, $sp, -12	#cria a mais pilha	
		sw $ra, 0($sp)
		sw $a0, 4($sp)
		sw $a1, 8($sp)		
		jal ret1	# ackermann(m - 1, 1)

if3:		lw $a0, 4($sp)
		lw $a1, 8($sp)		
		addiu $a1, $a1, -1	#n-1		
		addiu $sp, $sp, -12	#cria a mais pilha	
		sw $ra, 0($sp)
		sw $a0, 4($sp)
		sw $a1, 8($sp)		
		jal retEsp		#ackermann(m, n - 1)		
		lw $a0, 4($sp)#corpo do retona ackermann(m-1, n)
		addiu $sp, $sp, 12
		addiu $a0, $a0, -1	#m-1			
		sw $a0, 4($sp)
		sw $a1, 8($sp)		
		jal ret1
			
ret1: 		jal ackermann 		
		lw $ra, 0($sp)
		lw $t0, 4($sp)
		lw $t1, 8($sp)		
		addiu $sp, $sp, 12		
		jr $ra

ret2:		lw $ra, 0($sp)
		lw $t0, 4($sp)
		lw $t1, 8($sp)		
		addiu $sp, $sp, 12	
		sw $t0, 4($sp)	
		sw $t1, 8($sp)	
		jr $ra

retEsp:		addiu $sp, $sp, -12	#cria a mais pilha	
		sw $ra, 0($sp)
		sw $a0, 4($sp)
		sw $a1, 8($sp)	
		jal ackermann
		lw $ra, 0($sp)
		jr $ra
		
numeronegativo: li $v0, 10
		syscall