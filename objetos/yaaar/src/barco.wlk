class BarcoPirata{
	const tripulacion =#{}
	var mision
	const capacidad
	
	method tripulacion(){
		return tripulacion
	}
	
	method esTemible(){
		return self.puedeRealizar(mision)
	}
	
	method puedeRealizar(unaMision){
		return unaMision.puedeSerCompletadaPor(self)
	}
	
	method tieneMuchosTripulantes(){
		return tripulacion.size() > capacidad*0.9
	}
	
	method algunTieneLlaveDeCofre(){
		return tripulacion.any({unPirata=>unPirata.tieneLlaveDeCofre()})
	}
	
	method esVulnerableA(otroBarco){
		return tripulacion.size() <= otroBarco.tripulacion().size() /2
	}
	
	method todosBorrachos(){
		tripulacion.all({unPirata=>unPirata.estaPasadoDeGrog()})
	}
	
	method puedeSerSaqueadaPor(unPirata){
		return unPirata.estaPasadoDeGrog()
	}
	
	method mision(){
		return mision
	}
	
	method tieneCapacidad(){
		return tripulacion.size() < capacidad
	}
	
	method incorporar(unPirata){
		if (unPirata.puedeFormarParteDe(self)){
			tripulacion.add(unPirata)
		}
	}
	
	method cambiarMision(unaMision){
		mision=unaMision
		self.echarInutiles()
	}
	
	method echarInutiles(){
		tripulacion.filter({unPirata=>unPirata.esUtilPara(mision)})
	}
	
	method elMasBorracho(){
		return tripulacion.max({unPirata=>unPirata.borrachera()})
	}
	
	method anclarEn(unaCiudadCostera){
		tripulacion.forEach({unPirata=>unPirata.tomarUnTrago()})
		tripulacion.remove(self.elMasBorracho())
		unaCiudadCostera.sumarHabitante()
	}
	
	method pasadosDeGrog(){
		return tripulacion.filter({unPirata=>unPirata.estaPasadoDeGrog()})
	}
	
	method cantidadDeBorrachos(){
		self.pasadosDeGrog().size()
	}
	
	method itemsDeBorrachos(){
		self.pasadosDeGrog().flatMap({unPirata=>unPirata.items()}).asSet()
	}
	
	method borrachoMasAdinerado(){
		self.pasadosDeGrog().max({unPirata=>unPirata.monedas()})
	}
	
	method elMasInvitador(){
		return tripulacion.max({unPirata=>unPirata.cuantosInvitoEn(self)})
	}
}