import ricks.*
import noPuedoIrmeDeViajeException.*


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
	
	method nombre(){
		return nombre
	}
}

class Beth{
	
	const nombre ="Beth"
	var loQueRickLaQuiere
	
	method vaDeAventuraConRick(unRick){
		loQueRickLaQuiere += 10
		unRick.disminuirDemencia(20)
	}
	
	method nombre(){
		return nombre
	}
}

class Summers inherits Beth(nombre= "Summer"){
	
	override method vaDeAventuraConRick(unRick){
		if (self.esLunes())
			super(unRick)
			
		else 
			throw new NoPuedoIrmeDeViajeException(message="summer solo va de viaje los lunes")
		}
	
	method esLunes (){
		const hoyEs = new Date(/*day= , month= , year=¨*/ ).dayOfWeek() 
		return hoyEs==monday	
	} 
	
	}


object jerry{
	
	const nombre = "Jerry"
	
	method vaDeAventuraConRick(unRick){
		throw new NoPuedoIrmeDeViajeException (message="jerry es tonto no se puede ir de viaje")  
	}
	method nombre(){
		return nombre
	}
}