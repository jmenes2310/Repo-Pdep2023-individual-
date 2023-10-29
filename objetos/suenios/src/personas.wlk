import NoEsUnSuenioPorCumplirException.*

class Persona{
	const nombre
	const sueniosPorCumplir=#{}
	const sueniosCumplidos =#{}
	var felicidonios
	var edad
	const carrerasPorEstudiar=[]
	const carrerasCompletadas=[]
	var plataQueQuiereGanar
	const lugaresQueQuiereViajar = []
	var property hijos
	var personalidad
	
	
	method cumplir (unSuenio){
		if (sueniosPorCumplir.contains(unSuenio)){
			unSuenio.serCumplidoPor(self)
			sueniosPorCumplir.remove(unSuenio)
			sueniosCumplidos .add(unSuenio)
		}
		else {
			throw new NoEsUnSuenioPorCumplirException()
		}
	}
	
	method carrerasPorEstudiar(){
		return carrerasPorEstudiar
	}
	
	method yaCumplio(unSuenio){
		return sueniosCumplidos.contains(unSuenio)
	}
	
	method yaEstudio(unaCarrera){
		return carrerasCompletadas.contains(unaCarrera)
	}
	
	method completaCarrera(unaCarrera){
		carrerasCompletadas.add(unaCarrera)
	}
	
	method plataQueQuiereGanar(){
		return plataQueQuiereGanar
	}
	
	method sumarFelicidonios(unosFelicidonios){
		felicidonios += unosFelicidonios
	}
	
	method cambiarPersonalidad(unaPersonalidad){
		personalidad=unaPersonalidad
	}
	
	method cumplirSegunPersonalidad(){
		self.cumplir(personalidad.elegirSuenio())
	}
	
	method suenioMasImportante(){
		return sueniosPorCumplir.max({unSuenio=>unSuenio.felicidoniosQueBrinda()})
	}
	
	method sueniosPorCumplir(){
		return sueniosPorCumplir
	}
	
	method esFeliz(){
		return felicidonios > self.felicidoniosDeSueniosPendientes()
	}
	
	method esAmbiciosa(){
		return self.sueniosQueDanMuchaFelicidad(sueniosPorCumplir).size()>3 || self.sueniosQueDanMuchaFelicidad(sueniosCumplidos).size()>3
	}
	
	method sueniosQueDanMuchaFelicidad(unosSuenios){
		return unosSuenios.filter({unSuenio=>unSuenio.daMuchosFelicidonios()})
	}
	
	method felicidoniosDeSueniosPendientes(){
		return sueniosPorCumplir.sum({unSuenio=>unSuenio.felicidoniosQueBrinda()})
	}
}

object realista{
	
	method elegirSuenio(unaPersona){
		unaPersona.suenioMasImportante()
	}
	
}

object alocados{
	
	method elegirSuenio(unaPersona){
		unaPersona.sueniosPorCumplir().anyOne()
	}
}

object obsesivos{
	
	method elegirSuenio(unaPersona){
		unaPersona.sueniosPorCumplir().head()
	}
}