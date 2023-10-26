class Vikingo{
	const nombre
	var claseSocial
	var monedasDeOro
	
	method esProductivo()
	
	method ganarMonedas(unasMonedas){
		monedasDeOro+=unasMonedas
	}
	
	method puederIrA(unaExpedicion){
		return self.esProductivo && claseSocial.puedeSubir(self,unaExpedicion)
	}
}


class Soldado inherits Vikingo{
	var property vidasCobradas
	const armas = []
	
	override method esProductivo(){
		return self.vidasCobradas() >20 && self.tieneArmas()
	}
	
	method tieneArmas(){
		return armas.size()>1
	}
}

class Granjero inherits Vikingo{
	var property hectareas
	var property cantidadDeHijos
	
	override method esProductivo(){
		return hectareas == cantidadDeHijos *2
	}
}