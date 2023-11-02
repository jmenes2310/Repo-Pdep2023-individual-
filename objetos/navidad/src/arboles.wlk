import NoHayCapacidadException.*

class ArbolNavidenio{
	const regalos =#{}
	const tarjetas =#{}
	const adornos =#{}
	
	method capacidadDeContencion()
	
	method tieneCapacidad(){
		return self.capacidadDeContencion() > regalos.size()
	}
	
	method agregar(unRegalo){
		if (self.tieneCapacidad()){
			regalos.add(unRegalo)
		}
		else{
			throw new NoHayCapacidadException (message= "el arbol ya no tiene capacidad para alojar	 regalos")
		}
	}
	
	method beneficiarios(){
		return regalos.map({unRegalo=>unRegalo.destinatario()}).union(tarjetas.map({unaTarjeta=>unaTarjeta.destinatario()}))
	}
	
	method gastadoPorBenefactores(){
		return regalos.sum({unRegalo=>unRegalo.costo()}) + tarjetas.sum({unaTarjeta=>unaTarjeta.costo()})
	}
	
	method importancia(){
		return adornos.sum({unAdorno=>unAdorno.importancia()})
	}
	
	method precioPromedioDeRegalo(){
		return regalos.sum({unRegalo=>unRegalo.costo()}) / regalos.size()
	}
	
	method esPortentoso(){
		return self.CantidadDeregalosTeQuierenMucho >5 || self.algunaTarjetaEsGenerosa()
	}
	
	method CantidadDeregalosTeQuierenMucho(){
		regalos.filter({unRegalo=>unRegalo.esTequierenMucho(self)}).size()
	}
	
	method algunaTarjetaEsGenerosa(){
		return tarjetas.any({unaTarjeta=>unaTarjeta.esGenerosa()})
	}
	
	method adornoMasPesado(){
		return adornos.max({unAdorno=>unAdorno.peso()})
	}
}

class ArbolNavidenioNatural inherits ArbolNavidenio{
	var vejez
	const tamanioTronco
	
	override method capacidadDeContencion(){
		return vejez*tamanioTronco
	} 
	
}

class ArbolNavidenioArtificial inherits ArbolNavidenio{
	const cantidadVaras
	
	override method capacidadDeContencion(){
		return cantidadVaras
	}
	
	
}