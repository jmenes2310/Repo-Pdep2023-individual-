import zonas.*

class Inmueble {
	
	const tamanio
	const ambientes
	const operacion
	const zona
	var estado
	
	method valor() 
	
	method zona (){
		return zona
	}
	
	method sePuedeVender(){
		return true
	}
}

class Casa inherits Inmueble{
	var precio
	
	override method valor(){
		return precio + zona.valorAgregado()
	}
}

class PH inherits Inmueble{
	
	override method valor(){
		return 500000+ 14000*tamanio + zona.valorAgregado()
	}
	
}

class Departamento inherits Inmueble{
	
	override method valor(){
		return 350000 * ambientes + zona.valorAgregado()
	}
}

