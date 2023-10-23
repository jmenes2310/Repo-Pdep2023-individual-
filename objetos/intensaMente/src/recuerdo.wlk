class Recuerdo {
	const emocionEnEseMomento
	const descripcion
	const fecha 
	
	method emocionEnEseMomento(){
		return emocionEnEseMomento
	}
	
	method asentarse(unaNinia){
		emocionEnEseMomento.accionTrasAsentarse(unaNinia,self)
	}
	
	method esDificilDeExplicar (){
		return descripcion.size() >10
	}
	
	method incluye(unaPalabra){
		descripcion.contains(unaPalabra)
	}
	
	method noEsCentral(unaNinia){
		return unaNinia.recuerdosDelDia().contains(self) && !unaNinia.recuerdosCentrales().contains(self)
	}
	
	method esNegado(unaNinia){
		return !unaNinia.emocionDominante().niega(self.emocionEnEseMomento())
	}
	
	method tieneMismaEmocion(unRecuerdo){
		return self.emocionEnEseMomento() === unRecuerdo.emocionEnEseMomento()
	}
	
	method fecha (){
		return fecha
	}
	
	method anioEnQueOcurrio(){
		return fecha.year()
	}
}
