class Mision {
	
	method puedeSerCompletadaPor(unBarco){
		return unBarco.tieneMuchosTripulantes()
	}
	
	method resultaUtil(unPirata)
	
}

class BusquedaDelTesoro inherits Mision{
	
	override method puedeSerCompletadaPor(unBarco){
		return super(unBarco) && unBarco.algunoTieneLlaveDeCofre()
	}
	
	override method resultaUtil(unPirata){
		return unPirata.esPobre() && unPirata.estaPreparadoParaBuscar()
	} 
}

class ConvertirseEnLeyenda inherits Mision{
	const itemObligatorio
	
	override method resultaUtil(unPirata){
		return unPirata.items().size()>=10 && unPirata.items().contains(itemObligatorio)
	}
}

class Saqueo inherits Mision{
	const victima
	var monedas 
	
	method modificarMonedas(unaCantidad){
		monedas = unaCantidad
	}
	
	override method puedeSerCompletadaPor(unBarco){
		return victima.esVulnerableA(unBarco)
	}
	
	override method resultaUtil(unPirata){
		return unPirata.monedas() < monedas && unPirata.seAnimaASaquear(victima)
	}
}

class CiudadCostera{
	var cantidadDeHabitantes
	
	method esVulnerableA(unBarco){
		return (unBarco.tripulacion().size() > cantidadDeHabitantes*0.4) || unBarco.todosBorrachos()
	}
	
	method puedeSerSaqueadaPor(unPirata){
		return unPirata.borracheraAlMenosDe(50)
	}
	
	method sumarHabitante(){
		cantidadDeHabitantes+=1
	}
}