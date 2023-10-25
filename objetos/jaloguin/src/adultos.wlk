class Adulto {
	var niniosQueLoAsustaron
	
	method seAsustaPor(unNinio){
		if(self.loAsusta(unNinio))	{
			const caramelos=self.cuantosCaramelosDa()
			unNinio.recibirCaramelos(caramelos)
			niniosQueLoAsustaron.add(unNinio)
		}
	}
	
	method cuantosCaramelosDa(){
		return self.tolerancia()/2
	}
	
	method loAsusta(unNinio){
		return self.tolerancia() < unNinio.nivelDeAtemorizacion()
	}
	
	method tolerancia(){
		return 10* niniosQueLoAsustaron.tienenMasDe15Caramelos()
	}
	
	method tienenMasDe15Caramelos(){
		niniosQueLoAsustaron.filter({unNinio=>unNinio.susCaramelosSonMasDe(15)}).size()
	}
}

class Abuelo inherits Adulto{
	
	override method loAsusta(unNinio){
		return true
	} 
	
	override method cuantosCaramelosDa(){
		return super()/2
	}
}

class AdultoNecio inherits Adulto{
	
	override method loAsusta(unNinio){
		return false
	}
}