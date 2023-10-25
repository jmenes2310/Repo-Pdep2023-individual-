import gameflix.*
import suscripciones.*
import noPuedoJugarEsteJuegoException.*

class Clientes {
	const nombre 
	var saldo
	var humor
	var suscripcion
	
	method pedirQueFiltre (unaCategoria){
		return gameflix.filtrarJuegosPor(unaCategoria)
	}
	
	method pedirQueBusque(unJuego){
		return gameflix.buscarUn(unJuego)
	}
	
	method pedirQueRecomiende(){
		return gameflix.recomendacionAleatoria()
	}
	
	method actualizarSuscripcion(unaSuscripcion){
		suscripcion = unaSuscripcion
	}
	
	method pagarSuscripcion(){
		if (saldo >= suscripcion.precio()){
			saldo -= suscripcion.precio()
			}
		else {
			self.actualizarSuscripcion(prueba)
		}
	}
	
	method reducirHumor(unaCantidad){
		humor -= unaCantidad
	}
	
	method aumentarHumor(unaCantidad){
		humor += unaCantidad
	}
	
	method ponerPlataAlJuego(unaCantidad){
		saldo -=unaCantidad
	}
	
	method jugar(unJuego,unaHoras){
		if (suscripcion.permiteJuagarA(unJuego)){
			unJuego.serJugadoPor(self,unaHoras)
		}
		else {
			throw new NoPuedoJugarEsteJuegoException(message="tu suscripcion no te permite jugar este juego")
		}
	}
	
	
	
	
	
	
	
}
