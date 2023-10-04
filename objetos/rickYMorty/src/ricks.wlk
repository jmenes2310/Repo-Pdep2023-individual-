import familiares.*

class Ricks {
	var nivelDeDemencia
	
	method irDeAventura(unAcompaniante){
		try 
			unAcompaniante.vaDeAventuraConRick(self)
		
		catch unaExepcion : Exception
			self.aumentarDemencia(1000)
		
	}
	
	
	method aumentarDemencia (unaCantidad){
		nivelDeDemencia += unaCantidad
	}
	
	method disminuirDemencia (unaCantidad){
		nivelDeDemencia -= unaCantidad
	}
}
