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
	
    for:slt , , 	#5 pq vai passar pelas 5 linhas
	beq , ,   #se for <6 para
	mul.s $f4,$f1,$f5       #multiplica peso1 x i
	mul.s $f4,$f2,$f5	#multiplica peso2 x i
	
 fimFor:	
	#linha 0 - 1 x peso1+1 x peso2 = X     (x minusco = multi / X = variavel)
	#2 (resutlado de 1+1)-X=erro
	#atualizar o peso - pesox = pesox+erro x taxaAprendizado x 1(entrada linha0)}
	#repetir tudo
