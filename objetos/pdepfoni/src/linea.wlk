import consumos.*
import packs.*
import noSePuedeHacerElConsumoException.*

class Linea{
	var numero
	var packs= []
	var consumos= []
	var tipoLinea
	var deuda = 0
	
	method elegirTipoLinea(unTipo){
		tipoLinea = unTipo
	}
	
	method agregarConsumo(unConsumo){
		consumos.add(unConsumo)
	}
	
	method agregarPack(unPack){
		packs.add(unPack)
	}
	
	method promedioConsumosEntre(unaFecha,otraFecha){
		const consumido = self.consumosEntre(unaFecha,otraFecha)
		return self.totalGastadoDe(consumido)/consumido.size()	
	}
	
	method totalGastadoDe(unosConsumos){
		return unosConsumos.sum({unConsumo=>unConsumo.costo()})
	}
	
	method consumosEntre (unaFecha,otraFecha){
		return consumos.filter({unConsumo=>unConsumo.consumidoEtre(unaFecha,otraFecha)})
	}
	
	method gastadoEnUltimoMes(){
		const consumidoUltimoMes = consumos.filter({unConsumo=>unConsumo.consumidoElUltimoMes()})
		return self.totalGastadoDe(consumidoUltimoMes)
	}
	
	method puedeHacer (unConsumo){
		return packs.any({unPack=>unPack.satisface(unConsumo)})
	}
	
	method consumir(unConsumo){
		if(self.puedeHacer(unConsumo)){
			self.agregarConsumo(unConsumo)
			self.realizarConsumo(unConsumo)
		} 
		else {
			tipoLinea.consumoNoRealizable(self,unConsumo)
			
				
		}
		
	}
	method realizarConsumo(unConsumo){
		const pack = self.masRecientePackQuePuedeHacer(unConsumo)
		pack.consumir(unConsumo)
	
	}
	
	method masRecientePackQuePuedeHacer(unConsumo){
		return packs.reverse().find({unPack=>unPack.satisface(unConsumo)})
	}
	
	method limpiezaDePacks(){
		packs.filter({unPack=>!unPack.esInutilizable()})
	}
	
	method sumarDeuda(unaCantidad){
		deuda+=unaCantidad
	}
}

object black{
	
	
	method consumoNoRealizable(unaLinea, unConsumo){
		unaLinea.sumarDeuda(unConsumo.costo())
	}
	
}
object platinum{
	
	method consumoNoRealizable(unaLinea, unConsumo){}
	
}

object comun{
	
	method consumoNoRealizable (unaLinea,unConsumo){
		throw new NoSePuedeHacerElConsumoException(message="no te alcanza ninguno de los packs para hacer el cosumo")
	}
}


