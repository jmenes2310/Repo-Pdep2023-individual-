object esclavo {
	method puedeSubir(unVikingo,unaExpedicion){
		return !unVikingo.tieneArmas()
	}
	
	method ascender(unVikingo){
		unVikingo.claseSocial(media)
		unVikingo.recompensaDeAscenso()
	}
}

object media{
	method puedeSubir(unVikingo,unaExpedicion){
		return true
	}
	
	method ascender(unVikingo){
		unVikingo.claseSocial(noble)
	}
}

object noble{
	method puedeSubir(unVikingo,unaExpedicion){
		return true
	}
}