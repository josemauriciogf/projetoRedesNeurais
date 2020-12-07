.data 
	number1: .word 20
	number2: .word 8
.text
	lw $s0, number1($zero)
	lw $s1, number2($zero)
	
	sub $t0,$s0,$s1
	
	li $v0, 1
	move $a0,$t0 #o sistema printa em a0 ai 
		     #muda pro t0 pq é onde ta a árada
	syscall