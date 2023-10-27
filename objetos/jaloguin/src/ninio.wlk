import CantidadInsuficienteDeNiniosException.*
import legion.*
import noTenesTantosCaramelosException.*
import estadosDeSalud.*

class Ninio {
	const elementosDeDisfraz =#{}
	var actitud //indice de 1 a 10
	var cantidadDeCaramelos
	var salud = sano
	
	method elementosDeDisfraz(){
		return elementosDeDisfraz
	}
	
	method nivelDeAtemorizacion (){
		return self.sustoDeDisfraz() *actitud
	}
	
	method sustoDeDisfraz(){
		return elementosDeDisfraz.sum({unElemento=>unElemento.asusta()})
	}
	
	method cantidadDeCaramelos(){
		return cantidadDeCaramelos
	}
	
	method asustaA (unAdulto){
		unAdulto.seAsustaPor(self)
	}
	
	method susCaramelosSonMasDe(unaCantidad){
		return cantidadDeCaramelos>unaCantidad
	}
	
	method recibirCaramelos(unaCantidad){
		cantidadDeCaramelos += unaCantidad
	}

	method crearLegion(unosNinios){
		if (unosNinios.size()>=2 ){
		 	const legionDelTerror = new Legion(ninios=unosNinios)
		}
		else {
			throw new CantidadInsuficienteDeNiniosException()
		}
	}
	
	method comerCaramelos(unaCantidadDeCaramelos){
		if (self.tieneCaramelosSuficientes(unaCantidadDeCaramelos)){
			salud.consecuenciaPorComerCaramelos(unaCantidadDeCaramelos,self)
			cantidadDeCaramelos -= unaCantidadDeCaramelos
		}
		else {
			throw new NoTenesTantosCaramelosException()
		}
	}
	
	method tieneCaramelosSuficientes(unaCantidadDeCaramelos){
		return cantidadDeCaramelos > unaCantidadDeCaramelos
	}
	
	method empeorarSalud(){
		salud.empeorar(self)
	}
	
	method mitadDeActitud(){
		actitud/=2
	}
	
	method sinActitud(){
		actitud = 0
	}
	
	method cambiarSalud(unaSalud){
		salud = unaSalud
	}
}