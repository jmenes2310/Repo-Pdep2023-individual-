class Adorno {
	const pesoBase
	
	method importancia(){
		return pesoBase*self.superioridad()
	}
	
	method superioridad()
	
	method peso(){
		return pesoBase
	}
}

class Luz inherits Adorno{
	const lamparitas
	
	override method importancia(){
		return super() * lamparitas 
	}
}

class FiguraElaborada inherits Adorno{
	const volumen
	
	override method importancia(){
		return super() + volumen
	}
}

class Guirnalda inherits Adorno{
	const anioDeAdquisicion	
	
	method pesoActual(){
		return pesoBase - 100*self.aniosDesdeAdquisicion()
		
	}
	
	method aniosDesdeAdquisicion(){
		return new Date().year() - anioDeAdquisicion
	}
}