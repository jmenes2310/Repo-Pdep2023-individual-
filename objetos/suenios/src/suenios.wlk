import NoPasaValidacionException.*

class Suenio {
	
	method serCumplidoPor(unaPersona){
		self.validar(unaPersona)
		unaPersona.sumarFelicidonios(self.felicidoniosQueBrinda())
		
	}
	
	method validar(unaPersona){} //para mi no es abstracta porque hay suenios que no tienen validaciones
	
	method felicidoniosQueBrinda()
	
	method daMuchosFelicidonios(){
		return self.felicidoniosQueBrinda()>100
	}
}

class SuenioMultiple inherits Suenio{
	const suenios
	
	
	override method felicidoniosQueBrinda(){
		return suenios.sum({unSuenio=>unSuenio.felicidoniosQueBrinda()})
	}
	
	override method validar(unaPersona){
		suenios.forEach({unSuenio=>unSuenio.validar(unaPersona)})
	}

}

class Recibirse inherits Suenio{
	const carrera
	
	override method validar(unaPersona){
		
		if (!unaPersona.carrerasPorEstudiar().contains(carrera) || unaPersona.yaEstudio(carrera) ){
			throw new NoPasaValidacionException()
		}
		unaPersona.completaCarrera(carrera)
	}
	
}

class ConseguirTrabajo inherits Suenio{
	const paga 
	
	override method validar(unaPersona){
		
		 if (unaPersona.plataQueQuiereGanar() > paga){
		 	throw new NoPasaValidacionException()
		 }
	}
}

class Adoptar inherits Suenio{
	const cantidadDeHijos
	
	override method validar(unaPersona){
		if (unaPersona.hijos() > 1){
			throw new NoPasaValidacionException()
		}
		unaPersona.hijos(cantidadDeHijos)
	}
}

//estas dos clases no tienen validaciones
class TenerUnHijo inherits Suenio{
	
	
}

class Viajar inherits Suenio{
	const unLugar
	//para esta clase se me ocurrio la validacion de que unLugar tiene que estar en los lugares que la persona quiereVisitar
	//seria una validacion similar a recibirse
	
}

