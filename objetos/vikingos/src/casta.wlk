object esclavo {
	method puedeSubir(unVikingo,unaExpedicion){
		return !unVikingo.tieneArmas()
	}
	
}

object media{
	method puedeSubir(unVikingo,unaExpedicion){
		return true
	}
}

object noble{
	method puedeSubir(unVikingo,unaExpedicion){
		return true
	}
}