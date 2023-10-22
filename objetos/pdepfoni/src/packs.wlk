import consumos.*

class Pack {
	var tieneVencimiento
	var vencimiento
	var credito 
	var mb
	
	method estaVigente(){
		const hoy = new Date()
		return vencimiento > hoy	
	}
	
	method tieneVencimiento(){
		return tieneVencimiento
	}
	method cubre(unConsumo)
	
	method satisface(unConsumo){
		return self.cubre(unConsumo) && (!self.tieneVencimiento() || self.estaVigente())
	}
	
	method esInutilizable(){
		return (credito == 0 && mb == 0) || (!self.tieneVencimiento() && self.estaVigente())
	}
	
	method credito(){
		return credito
	}
	
}

class PackMbLibres inherits Pack(credito=0){
	
	override method cubre(unConsumo){
		return mb > unConsumo.mbConsumidos()
	}
	
	method consumir (unConsumo){
		mb-=unConsumo.mbConsumidos()
	}
}

class PackMbLibresPlusPlus inherits PackMbLibres(credito=0){
	
	override method cubre(unConsumo){
		return mb + 0.1 > unConsumo.mbConsumidos()
	}
	
	override method consumir (unConsumo){
		super(unConsumo)
		if (mb == 0){
			mb += 0.1
		}
	}
}


class PackCreditoDisponible inherits Pack(mb=0){ 
	
	override method cubre (unConsumo){
		return credito > unConsumo.costo()
	}	
		
	method consumir(unConsumo){
		credito -= unConsumo.costo() 
	}
	
}


