import familiares.*
import noPuedoIrmeDeViajeException.*

class Ricks {
	var nivelDeDemencia
	
	method irDeAventura(unAcompaniante){
		try 
			unAcompaniante.vaDeAventuraConRick(self)
		
		catch exceptionQueNoVaDeViaje : NoPuedoIrmeDeViajeException
			self.aumentarDemencia(1000)
		
	}
	
	
	method aumentarDemencia (unaCantidad){
		nivelDeDemencia += unaCantidad
	}
	
	method disminuirDemencia (unaCantidad){
		nivelDeDemencia -= unaCantidad
	}
}
