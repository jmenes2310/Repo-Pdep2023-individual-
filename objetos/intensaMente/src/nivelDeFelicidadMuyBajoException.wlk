class NivelDeFelicidadMuyBajoException inherits Exception{
	const nombre
	
	override method message(){
		return nombre +"tiene un nivel de felicidad menor a 1"
	}
	
	
}
