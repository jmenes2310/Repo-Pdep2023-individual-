class ProcesoDeAsentamiento{
	method efectoSobre (unaNinia){
		unaNinia.asentarVarios(self.recuerdosParaAsentar(unaNinia))
	}
	
	method recuerdosParaAsentar(unaNinia)
}

object asentamiento inherits ProcesoDeAsentamiento {
		
	override method recuerdosParaAsentar(unaNinia){
		return unaNinia.recuerdosDelDia()
	}
		
}

object asentamientoSelectivo inherits ProcesoDeAsentamiento{
	
	const palabraClave = null
	
	override method recuerdosParaAsentar(unaNinia){
		return unaNinia.recuerdosDelDiaQueTienen(palabraClave)
	}
}

object profundizacion{
	
	method efectoSobre(unaNinia){
		unaNinia.profundizarRecuerdos()
	}
}

object controlHormonal{
	
	method efectoSobre(unaNinia){
		if(unaNinia.tieneUnPensamientoCentralEnElLargoPlazo() || unaNinia.todosLosRecuerdosTienenMismaEmocion()){
			unaNinia.desequilibrioHormonal()
		}
	}
	
}

object restauracionCognitiva{
	method efectoSobre(unaNinia){
		unaNinia.hacerFeliz(100)
	}
}