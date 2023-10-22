import pdepfoni.*

class Consumo {
	var fechaConsumo 
	var mbConsumidos
	var segundosConsumidos
	
	method consumidoEntre (unaFecha,otraFecha){
		return fechaConsumo.between(unaFecha,otraFecha)
	}
	
	method consumidoElUltimoMes(){
		const hoy = new Date()
		const mesPasado = hoy.minusMonths(1)
		return self.consumidoEntre(mesPasado,hoy)
	}
	
	method segundosCosumidos(){
		return segundosConsumidos
	}
	
	method mbConsumidos(){
		return mbConsumidos
	}
	
}
	
	
class ConsumoDeLlamadas inherits Consumo(mbConsumidos = 0) {
	
	method costo(){
		if (segundosConsumidos > 30){
			return pdepfoni.precioFijoLlama() + (segundosConsumidos -30)*pdepfoni.costoPorSegundoLlamada()
		}
		else {
			return pdepfoni.precioFijoLlama()
		}
	}
	
}

class ConsumoDeInternet inherits Consumo(segundosConsumidos=0) {
	
	method costo(){
		return pdepfoni.precioPorMb() * self.mbConsumidos()
	}
}

