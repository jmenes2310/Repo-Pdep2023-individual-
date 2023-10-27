import YaNoPodesComerCaramelosPorQueEstasEnCamaException.*

class Salud {
	method consecuenciaPorComerCaramelos(unaCantidad,unNinio){
		if (self.sonMuchosCaramelos(unaCantidad)){
			unNinio.empeorarSalud()
		}
	}	
	
	method sonMuchosCaramelos(unaCantidad){
		return unaCantidad >10
	}
}

object sano inherits Salud{
	
	method empeorar(unNinio){
		unNinio.mitadDeActitud()
		unNinio.cambiarSalud(empachado)  
	}
}

object empachado inherits Salud{
	 
	 method empeorar(unNinio){
	 	unNinio.sinActitud()
	 	unNinio.cambiarSalud(enCama)  
	 }
}

object enCama inherits Salud{
	
	override method consecuenciaPorComerCaramelos(unaCantidad,unNinio){
		throw new YaNoPodesComerCaramelosPorqueEstasEnCamaException()
	}
}