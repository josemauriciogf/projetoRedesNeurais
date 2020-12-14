.data
	#salvar variaveis que vão ser utilizadas
	myFloat1: .float 1.00
	myFloat2: .float 2.00
	myFloat3: .float 3.00
	myFloat4: .float 4.00
	myFloat5: .float 5.00
	myFloat6: .float 6.00
	myFloat8: .float 8.00
	myFloat10: .float 10.00
	peso1: .float 0.00
	peso2: .float 0.80
	zeroAsFloat: .float 0.00
	taxaAprendizado: .float 0.05
	mensagemPeso1: .asciiz "\nPeso1: " 
	mensagemPeso2: .asciiz "\nPeso2: " 
	erroMensagem: .asciiz "\n\nErro:"
	erroMensagem2: .asciiz "\n\nO erro final foi:"
	Mensagem3: .asciiz "\n\nCom esses pesos atualizados, 1+1=:"
.text
main:
	#load tx de aprendizado = 0.05
	lwc1 $f0,taxaAprendizado
	#load peso 1 e 2
	lwc1 $f1,peso1
	lwc1 $f2,peso2
	#load floats uteis
	lwc1 $f3,myFloat2
	lwc1 $f16,myFloat2
	lwc1 $f8,myFloat6
	lwc1 $f9,myFloat1
	lwc1 $f10,myFloat1 
	lwc1 $f20,zeroAsFloat
	
	addi $t0,$t0,1 #criar o i
	addi $t1,$t1,6 #criar o limite de i
	
	#for
    for:slt $t3,$t0,$t1        #5 pq vai passar pelas 5 linhas
	beq $t3,0,fimFor       #se for <6 para
	mul.s $f4,$f1,$f9      #multiplica peso1 x i f9=i
	mul.s $f5,$f2,$f9      #multiplica peso2 x i	
	add.s $f4,$f4,$f5      #soma o resultado de peso i por 1 e peso 2 por i
	sub.s $f4,$f3,$f4      #tira o resultado da soma acima de i+i pra ter o erro
	
	#printar erro
	li $v0, 4 
	la $a0, erroMensagem
	syscall
	li   $v0, 2
	mov.s $f12,$f4
	syscall
	#pesox=pesox+(erro x taxa x entrada) 
	#peso1
	mul.s $f12,$f4,$f0
	mul.s $f12,$f12,$f9
	add.s $f1,$f1,$f12 #novo peso1
	#peso2
	mul.s $f13,$f4,$f0
	mul.s $f13,$f13,$f9
	add.s $f2,$f2,$f13 #novo peso1
	#imprimir os peso 1 e 2 atualizados
	li $v0, 4 
	la $a0, mensagemPeso1
	syscall
	li   $v0, 2
	mov.s $f12, $f1
	syscall
	li $v0, 4 
	la $a0, mensagemPeso2
	syscall
	li   $v0, 2
	mov.s $f12, $f2
	syscall
	
	#ja temos os novos peso 1 e 2 para repetir o processo
	addi $t0,$t0,1 #i++
	add.s $f9,$f9,$f10 #i++ no float
	add.s $f3,$f3,$f16 #adicionar 2 no resultado final
	j for
	#repetir tudo
 fimFor:#printar erro final
	li $v0, 4 
	la $a0, erroMensagem2
	syscall
	li   $v0, 2
	mov.s $f12,$f4
	syscall
	add.s $f18,$f18,$f20
	add.s $f19,$f19,$f20
	mul.s $f18,$f10,$f1
	mul.s $f19,$f10,$f2
	add.s $f19,$f19,$f18
	li $v0, 4 
	la $a0, Mensagem3
	syscall
	li   $v0, 2
	mov.s $f12,$f19
	syscall
 	jr $ra
	
