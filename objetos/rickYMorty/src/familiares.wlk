import ricks.*

class Mortys{
	
	const nombre = "Morty"
	var saludMental
	
	method vaDeAventuraConRick(unRick){
		saludMental -=30
		unRick.aumentarDemencia(50)
		}
	
	method setSaludMental(unNumero){
		saludMental=unNumero
	}
	
	method puedeIrDeAventuraConRick(){
		return true
	}
}

class Beths{
	
	const nombre ="Beth"
	var loQueRickLaQuiere
	
	method vaDeAventuraConRick(unRick){
		loQueRickLaQuiere += 10
		unRick.disminuirDemencia(20)
	}
	
	method puedeIrdeDeAventuraConRick(){
		return true
	}
	
}

class Summers{
	
	const nombre ="Summer"
	var rickLaQuiereMas
	
	method vaDeAventuraConRick(unRcik){
		rickLaQuiereMas = true
	}

	method puedeIrDeAventuraConRick(){
		if ((new Date().dayOfWeek)=== monday ){
			return true
		}
		else {
			return false
		}
	}

}


object jerry{
	
	const nombre = "Jerry"
	method puedeIrDeAventuraConRick(){
		return false
	}
	
	method vaDeAventuraConRick(unRick){
		throw new Exception (message="jerry es tonto no se puede ir de viaje")  
	}
}