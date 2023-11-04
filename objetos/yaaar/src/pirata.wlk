class Pirata {
	const nombre 
	const items =[]
	var borrachera
	var monedas
	const quienLoInvito
	
	method items(){
		return items
	}
	
	method monedas(){
		return monedas
	}
	method tieneLlaveDeCofre(){
		return items.contains("llave de cofre")
	}
	
	method estaPasadoDeGrog(){
		return self.borracheraAlMenosDe(90)
	}
	
	method esUtilPara(unaMision){
		return unaMision.resultaUtil(self)
	}
	
	method esPobre(){
		return !(monedas >5)
	}
	
	method estaPreparadoParaBuscar(){
		return items.contains("brujula") || items.contains("mapa") || items.contains("botella de grog") 
	}
	
	method seAnimaASaquear(unaVictima){
		return unaVictima.puedeSerSaqueadaPor(self)
	}
	
	method borracheraAlMenosDe(unNumero){
		return borrachera >= unNumero
	}
	
	method puedeFormarParteDe(unBarco){
		return unBarco.tieneCapacidad() && self.esUtilPara(unBarco.mision())
	}
	
	method borrachera(){
		return borrachera
	}
	
	method tomarUnTrago(){
		borrachera +=5
		monedas-=1
	}
	
	method quienLoInvito(){
		return quienLoInvito
	}
	
	method cuantosInvitoEn(unBarco){
		return unBarco.tripulacion().filter({unPirata=>unPirata.quienLoInvito()== nombre}).size()
	}
}

class Espia inherits Pirata{
	
	override method estaPasadoDeGrog(){
		return false
	}
	
	override method seAnimaASaquear(unaVictima){
		return super(unaVictima) && items.contains("permiso de la corona")
	}
}
