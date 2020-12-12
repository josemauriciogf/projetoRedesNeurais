.data
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
	erro1: .float 1.20
.text
	#load tx de aprendizado = 0.05
	lwc1 $f0,taxaAprendizado
	#salvar peso1 e peso2
	lwc1 $f1,peso1
	lwc1 $f2,peso2
	#saida esperada na primeira linha
	lwc1 $f3,myFloat2
	lwc1 $f8,myFloat6
	lwc1 $f9,myFloat1
	#testar os dados{
	addi $t0,$t0,1
	addi $t1,$t1,6
    for:slt $t3,$t0,$t1        #5 pq vai passar pelas 5 linhas
	beq $t0,0,fimFor       #se for <6 para
	mul.s $f4,$f1,$f9      #multiplica peso1 x i f9=i
	mul.s $f5,$f2,$f9      #multiplica peso2 x i	
	add.s $f4,$f4,$f5      #soma o resultado de peso i por 1 e peso 2 por i
	sub.s $f4,$f4,$f3      #tira o resultado da soma acima de i+i pra ter o erro
	#pensei em printar o erro aqui nesse ponto
	add.s $f1,$f1,$f4      #começo do calculo do novo erro (peso1 = peso1+erro)
	mul.s $f0,$f0,$f9      #taxaAprendizado x i
	mul.s $f1,$f1,$f0      #calculo do novo peso 1 pronto
	add.s $f2,$f2,$f4      #começo do calculo do novo erro (peso2 = peso2+erro)
	mul.s $f2,$f2,$f0      #calculo do novo peso 2 pronto
	#ja temos os novos peso 1 e 2 para repetir o processo
 fimFor:#repetir tudo
