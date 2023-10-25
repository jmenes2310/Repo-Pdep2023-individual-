object alegria {
	
	method accionTrasAsentarse(unaNinia,unRecuerdo){
		if (unaNinia.nivelDeFelicidad() > 500){
			unaNinia.aniadirPensamientoCentral(unRecuerdo)
		}
	}

	method niega(emocionProvenienteDeRecuerdo){
		return emocionProvenienteDeRecuerdo != self
	}
	
	method esAlegre(){
		return true
	}

}

object tristeza {
	method accionTrasAsentarse(unaNinia,unRecuerdo){
		unaNinia.estabecerPensamientoCentral(unRecuerdo)
		unaNinia.disminuirPorcentajaDeFelicidad(10)
	}
	
	method niega(emocionProvenienteDeRecuerdo){
		return emocionProvenienteDeRecuerdo === alegria
	}
	
	method esAlegre(){
		return false
	}
	
}

class EmocionPasiva{
	
	method accionTrasAsentarse(unaNinia,unRecuerdo){}
	method niega(otraEmocion){}
	
	method esAlegre(){
		return false
	}

}

const furia = new EmocionPasiva()
const temor = new EmocionPasiva()
const disgusto = new EmocionPasiva() 

class EmocionCompuesta{
	
	const emociones=#{}
	
	method niega(emocionProvenienteDeRecuerdo){
		return emociones.all({unaEmocion=>unaEmocion.niega(emocionProvenienteDeRecuerdo)})
	}
	
	method esAlegre(){
		return emociones.any({unaEmocion=>unaEmocion.esAlegre()})
	}
	
	method accionTrasAsentarse(unaNinia,unRecuerdo){
		emociones.forEach({unaEmocion=>unaEmocion.accionTrasAsentarse(unaNinia,unRecuerdo)})
	}
	
	
	
}

