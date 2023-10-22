import suscripciones.*
import clientes.*
import noEstaElJuegoEnElCatalogoException.*

object gameflix {
	const catalogo = #{}
	const clientes =#{}
	
	method filtrarJuegosPor(unaCategoria){
		return catalogo.filter({unJuego=>unJuego.esDeCategoria(unaCategoria)})
	}
	
	method buscarUn(unNombre){
		return catalogo.findOrElse({unJuego=>unJuego.esDeNombre(unNombre)},{throw new NoEstaElJuegoEnElCatalogoException(nombreJuego = unNombre)})
		 
	}
	
	method recomendacionAleatoria(){
		return catalogo.anyOne()
	}
	
	method cobrar(){
		clientes.forEach({unCliente=>unCliente.pagarSuscripcion()})
	}
}
