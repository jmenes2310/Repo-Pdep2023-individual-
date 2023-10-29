import inmobiliaria.*

object porTotalDeComisiones{
	
	method total(unEmpleado){
		return unEmpleado.comisiones()
	}
}

object porTotalDeOperacionesConcretadas{
	
	method total(unEmpleado){
		return unEmpleado.operacionesConcretadas().size()
	}
}

object porTotalDeReservas{
	
	method total(unEmpleado){
		return unEmpleado.reservas().size()
	}
}