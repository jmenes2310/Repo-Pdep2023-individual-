object alegria {
	
	method accionTrasAsenarse(unaNinia,unRecuerdo){
		if (unaNinia.nivelDeFelicidad() > 500){
			unaNinia.aniadirPensamientoCentral(unRecuerdo)
		}
	}

	method niega(otraEmocion){
		return otraEmocion != self
	}

}

object tristeza {
	method accionTrasAsenarse(unaNinia,unRecuerdo){
		unaNinia.estabecerPensamientoCentral(unRecuerdo)
		unaNinia.disminuirPorcentajaDeFelicidad(10)
	}
	
	method niega(otraEmocion){
		return otraEmocion === alegria
	}
	
}

class EmocionPasiva{
	
	method accionTrasAsenarse(unaNinia,unRecuerdo){}
	method saberSiNiega(otraEmocion){}
}

const furia = new EmocionPasiva()
const temor = new EmocionPasiva()
const disgusto = new EmocionPasiva() 

