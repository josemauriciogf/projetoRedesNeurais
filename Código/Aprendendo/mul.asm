.data

.text
	#adicionando valores as variaveis
	addi $s0,$zero,10
	addi $s1,$zero,4
	#multiplicando e armazenando
	mul $t0,$s0,$s1
	#mostando	
	li $v0,1
	add $a0,$zero,$t0
	syscall