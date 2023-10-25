class Legion {
	const ninios=#{}
	
	method nivelDeAtemorizacion (){
		return ninios.sum({unNinio=>unNinio.nivelDeAtemorizacion()})
	}
	
	method cantidadDeCaramelos(){
		return ninios.sum({unNinio=>unNinio.cantidadDeCaramelos()})
	}
	
	method lider(){
		return ninios.max({unNinio=>unNinio.nivelDeAtemorizacion()})
	}
	
	method recibirCaramelos(unaCantidad){
		self.lider().recibirCaramelos(unaCantidad)
	}
	
	method ninios(){
		return ninios
	}
}

//para las legiones de legiones no es necesario reaalizar ningun cambio ya que por polimofrfismo tanto unalegion con un ninio entienden los mismos mensajes

