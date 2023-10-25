class Maquillaje{ //puede cambiar en un futuro
	const nivelDeSusto = 3
	
	method asusta (){
		return nivelDeSusto
	}
}

class  Traje{
	const esTierno
	
	method asusta (){
		if(esTierno){
			return 2
		}
		else{ return 5}
	}
}

