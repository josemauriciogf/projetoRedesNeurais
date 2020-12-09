.data 
	
.text
	addi $t0,$zero,30
	
	div $s0,$t0,10
	
	li $v0,1
	add $a0,$zero,$s0
	syscall