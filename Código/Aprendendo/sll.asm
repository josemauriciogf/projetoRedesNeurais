.data

.text
	#shift left logical
	addi $s0,$zero,4
	
	sll $t0,$s0,2 # esse 2 é 4 pq é 2 elevado a segunda potencia
	
	li $v0,1
	add $a0,$zero,$t0
	syscall