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
	peso2: .float 0.00
	zeroAsFloat: .float 0.00
	taxaAprendizado: .float 0.05
.text
	#salvar tx ded aprendizado
	#gerar peso1 e peso2
	#salvar epoca
	#testar os dados
	#linha 0 - 1 x peso1+1 x peso2 = X     (x minusco = multi / X = variavel)
	#2 (resutlado de 1+1)-X=erro
	#atualizar o peso - pesox = pesox+erro x taxaAprendizado x 1(entrada linha0)
	#repetir tudo
