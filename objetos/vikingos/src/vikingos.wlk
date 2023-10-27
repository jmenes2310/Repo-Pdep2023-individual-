class Vikingo{
	const nombre
	var claseSocial
	var monedasDeOro
	
	method esProductivo()
	
	method ganarMonedas(unasMonedas){
		monedasDeOro+=unasMonedas
	}
	
	method puederIrA(unaExpedicion){
		return self.esProductivo() && claseSocial.puedeSubir(self,unaExpedicion)
	}

	method ascenderSocialmente(){
		claseSocial.ascender(self)
	}
	
	method claseSocial(unaClase){
		claseSocial=unaClase
	}
}
class Soldado inherits Vikingo{
	var property vidasCobradas
	var armas
	
	override method esProductivo(){
		return self.vidasCobradas() >20 && self.tieneArmas()
	}
	
	method tieneArmas(){
		return armas >1
	}
	
	method recompensaDeAscenso(){
		armas += 10
	}
}

class Granjero inherits Vikingo{
	var property hectareas
	var property cantidadDeHijos
	
	override method esProductivo(){
		return hectareas == cantidadDeHijos *2
	}
	
	method recompensaDeAscenso(){
		hectareas += 2
		cantidadDeHijos += 2
	}
}