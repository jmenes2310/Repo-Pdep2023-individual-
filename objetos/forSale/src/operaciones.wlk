import inmuebles.*
import inmobiliaria.inmobiliaria
import NoSePuedeReservarException.*

class Operacion{
	const  inmuebleAsociado
	var estado
	
	method zonaDelInmueblesAsociado(){
		return inmuebleAsociado.zona()
	}
	
	method inmuebleAsociado(){
		return inmuebleAsociado
	}
	
	method estaDisponibles(){
		return estado == disponible
	}
	
	
	method serReservadaPor(unCliente){
		self.validar()
		estado.reservarA(self,unCliente)
	}
	
	method serConcretadaPor(unCliente){
		self.validar()
		estado.concretarA(self,unCliente)
	}
	
	method validar() {}
	
}


class Alquiler inherits Operacion{
	const cantidadDeMeses
	
	
	method comisionTrasConcretar(){
		return cantidadDeMeses * inmuebleAsociado.valor()/50000
	}
}


class Venta inherits Operacion{
	
	method comisionTrasConcretar(){
		return inmuebleAsociado.valor() * inmobiliaria.porcentajePorVenta() //el porcentaje lo tomo como que ya es 0,1 o 0,3 etc
	}
	
	method validar(){
		if (!inmuebleAsociado.puedeSerVendido()){
			throw new NoSePuedeVenderException()
		}
	}
}

//estados de operacion

class Reservada{
	var cliente
	
	method cliente(unCliente){
		cliente =unCliente
	}
	
	method reservarA(unaOperacion,unCliente){
		throw new NoSePuedeReservarException(mesagge ="ya habia una reserva hecha")
	}
	
	method concretarA(unaOperacion,unCliente){
		if(cliente == unCliente){
			unaOperacion.estado(new Cerrada(cliente=unCliente))
		}
		else {
			throw new NoSePuedeConcretarException(mesagge= "esta operacion ya ha sido reservada por otro cliente")
		}
	}
	
}

class Cerrada{
	const cliente
	
	method reservarA(unaOperacion,unCliente){
		throw new NoSePuedeReservarException (mesagge = "la operacion ya esta cerrada")
	}	
	
	method concretarA(unaOperacion,unCliente){
		throw new NoSePuedeConcretarException(mesagge= "esta operacion ya ha sido cerrada anteriormente")
	}
}

object disponible{
	
	method reservarA(unaOperacion,unCliente){
		unaOperacion.estado(new Reservada(cliente=unCliente))
	}
	
	method concretarA(unaOperacion,unCliente){
		unaOperacion.estado(new Cerrada(cliente=unCliente))
	}
	
}