import noPuedeIrDeExpedicionException.*

class Expedicion {
	const lugaresAInvadir=#{}
	var vikingos = #{}
	
	
	method subirA(unVikingo){
		if (unVikingo.puedeIrA(self)){
			vikingos.add(unVikingo)
		}
		else{
			throw new NoPuedeIrDeExpedicionException()
		}
	}
	
	method valeLaPena(){
		return lugaresAInvadir.all({unLugar=>unLugar.valeLaPenaPara(vikingos)})
	}
	
	method realizar(){
		const botinObtenido = self.botinAObtener()
		self.dividirBotin(botinObtenido)
		
	}
	
	method botinAObtener(){
		return lugaresAInvadir.sum({unLugar=>unLugar.monedasDeOro(vikingos)})
	}
	
	method dividirBotin(unasMonedas){
		vikingos.forEach({unVikingo=>unVikingo.ganasMonedas(unasMonedas / vikingos.size())})
	}
}

class Capital {
	var defensores
	const riquezaDeLaTierra
	 
	method valeLaPenaPara(unosVikingos){
		return self.monedasDeOro(unosVikingos) >= unosVikingos.size()*3	
	}
	
	method monedasDeOro(unosVikingos){
		return self.defensoresDerrotados(unosVikingos) *riquezaDeLaTierra
	}
	
	method defensoresDerrotados(unosVikingos){
		return unosVikingos.min(defensores)
	}
	method serInvadidoPor(unosVikingos){
		defensores -= self.defensoresDerrotados(unosVikingos)
	}
}

class Aldea{
	var crucifijos
	
	method monedasDeOro(unosVikingos){
		return crucifijos
	}
	
	method valeLaPenaPara(unosVikingos){
		return self.monedasDeOro(unosVikingos) >=15
	}
	
	method serInvadidoPor(unosVikingos){
		crucifijos=0
	}	
}	
class AldeaAmurallada inherits Aldea{
	const vikingosRequeridos
	
	override method valeLaPenaPara(unosVikingos){
		return super(unosVikingos) && unosVikingos.size() >= vikingosRequeridos
	}
	
	
	
	
}
	
}
