import criteriosDeMejorEmpleado.*

object inmobiliaria{
	
	const empleados = #{}	
	var property porcentajePorVenta
	
	method concretar(unaOperacion,unEmpleado){
		unEmpleado.cobrarComision(unaOperacion.comisionTrasConcretar())
	}
	
	method mejorEmpleadoSegun(unCriterio){
		return empleados.max({unEmpleado => unCriterio.total(unEmpleado)})
	}
	
}

class Empleado{
	
	var comisiones
	var operacionesConcretadas
	var reservas
	
	method cobrarComision(unaComision){
		comisiones += unaComision
	}
	
	method comisiones(){
		return comisiones
	}
	
	method operacionesConcretadas(){
		return operacionesConcretadas
	}
	
	method reservas(){
		return reservas
	}
	
	method reservo(unaOperacion){
		return reservas.contains(unaOperacion)
	}
	
	method tendraProblemasCon(otroEmpleado){
		return self.cerroOperacionesEnLaMismaZonaQue(otroEmpleado) && self.concretoOperacionReservadaPor(otroEmpleado) || otroEmpleado.concretoOperacionReservadaPor(self)
		
	}
	
	method concretoOperacionReservadaPor(otroEmpleado){
		return operacionesConcretadas.any({unaOperacion=>otroEmpleado.reservo(unaOperacion)})
	}
	
	method cerroOperacionesEnLaMismaZonaQue(otroEmpleado){
		return self.zonasDondeConcreto().any({unaZona=>otroEmpleado.operoEnZona(unaZona)})
	}
	
	method zonasDondeConcreto(){
		return operacionesConcretadas.map({unaOperacion=>unaOperacion.zonaDelInmueblesAsociado()}).asSet()
	}
	
	method operoEnZona(unaZona){
		self.zonasDondeConcreto().contains(unaZona)
	}
	
	method reservarPara(unCliente,unaOperacion){
		if (unaOperacion.estaDisponible())
		unaOperacion.serReservadaPor(unCliente)
		reservas.add(unaOperacion)
	}
	
	method concretarPara(unCliente,unaOperacion){
		unaOperacion.serConcretadaPor(unCliente)
		operacionesConcretadas.add(unaOperacion)
	}
}

