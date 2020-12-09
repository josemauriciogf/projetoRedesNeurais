.data

.text
	addi $t0,$zero,2000
	addi $t1,$zero,10
	
	mult $t0,$t1
	#o registro vai pro lo e hi la em baixo nos registradores
	mflo $s0 #move from lo
	
	li $v0,1 #1 é mostrar na tela
	add $a0,$zero,$s0
	syscall
	