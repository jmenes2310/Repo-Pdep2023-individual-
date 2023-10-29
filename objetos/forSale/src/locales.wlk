import inmuebles.Casa

class Local inherits Casa{
	var tipo
	
	method remodelarLocal(unTipo){
		tipo = unTipo
	}
	
	override method valor(){
		return tipo.valorFinal(super())
	}
	
	override method sePuedeVender(){
		return false
	}
	
}

object galpon{
	
	method valorFinal(unPrecio){
		return unPrecio /2
	}
}

object aLaCalle{
	
	var montoFijo
	
	method montoFijo(unMonto){
		montoFijo=unMonto
	}
	
	method valorFinal(unPrecio){
		return unPrecio +montoFijo
	}
}