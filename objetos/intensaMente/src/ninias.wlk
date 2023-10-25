import nivelDeFelicidadMuyBajoException.*
import recuerdo.Recuerdo

class Ninia{
	var nombre
	var edad
	var property nivelDeFelicidad
	var emocionDominante=null
	const pensamientosCentrales = #{}
	const recuerdosDelDia = #{}
	const procesosMentales = #{}
	const memoriaLargoPlazo =[]
	var pensamientoActual = null

	method edad(){
		return edad
	}
	
	method recuerdosDelDia(){
		return recuerdosDelDia
	}
	method recuedosQueTienen(unaPalabra){
		recuerdosDelDia.filter({unRecuerdo=>unRecuerdo.incluye(unaPalabra)})
	}
	
	method recuerdosProfundizables(){
		return recuerdosDelDia.filter({unRecuerdo=>unRecuerdo.noEsCentral(self) && !unRecuerdo.esNegado(self)})
	}
	method enviarALargoPlazo(unosRecuerdos){
		memoriaLargoPlazo.addAll(unosRecuerdos)
	}
	
	method establecerEmocionDominante(unaEmocion){
		emocionDominante = unaEmocion
	}
	method nombre (){
		return nombre
	}
	method vivir(unaDescripcion)
	
	method aniadirPensamientoCentral(unPensamiento){
		pensamientosCentrales.add(unPensamiento)
	}
	
	method disminuirPorcenajeDeFelicidad(unPorcentaje){
		nivelDeFelicidad -= nivelDeFelicidad*unPorcentaje/100
		self.corroborarQueEsFeliz()
	}
	
	method corroborarQueEsFeliz(){
		if (self.nivelDeFelicidad() < 1){
			throw new NivelDeFelicidadMuyBajoException (nombre = self.nombre())
		}
	}
	
	method agregarRecuerdoDelDia(unRecuerdo){
		recuerdosDelDia.add(unRecuerdo)
	}
	

	method asentar(unRecuerdo){
		unRecuerdo.asentarse(self)
	}
	
	method recuerdosRecientesDelDia (){
		return recuerdosDelDia.reverse().take(5)
	}
	
	method pensamientosCentrales(){
		return pensamientosCentrales
	}
	
	method pensamientosCentralesDificilesDeExplicar(){
		return pensamientosCentrales.filter({unRecuerdo=>unRecuerdo.esDificilDeExplicar()})
	}
	
	method niega(unRecuerdo)
	
	method dormir()
	
	method profundizarRecuerdos(){
		self.enviarALargoPlazo(self.recuerdosProfundizables())
	}
	
	method tienePensamientoCentralEnLargoPlazo(){
		return pensamientosCentrales.intersection(memoriaLargoPlazo).size() >= 1
	}
	
	method todosLosRecuerdosTienenMismaEmocion(){
		recuerdosDelDia.all({unRecuerdo,otroRecuerdo=>unRecuerdo.tieneMismaEmocion(otroRecuerdo)})
	}
	
	method desequilibrioHormonal(){
		self.disminuirPorcenajeDeFelicidad(15)
	}
	
	method hacerFeliz(unNumero){
		nivelDeFelicidad = 1000.min(nivelDeFelicidad+unNumero)
	}
	
	method liberarRecuerdosDelDia(){
		recuerdosDelDia.clear()
	}
	
	method rememorar()
	
	method recuerdosMasAntiguosQueMitadDeEdad(){
		const anioActual = new Date().year()
		return memoriaLargoPlazo.filter({unRecuerdo=>unRecuerdo.anioEnQueOcurrio() < anioActual - self.edad()/2})
	}
	
	method repeticionesDe(unRecuerdo){
		return memoriaLargoPlazo.filter({recuerdo=>recuerdo == unRecuerdo }).size()
	}
	
	method dejaVu()
}

object riley inherits Ninia(nombre="Riley",edad=11,nivelDeFelicidad=1000){
	
	override method vivir(unaDescripcion){
		const recuerdo = new Recuerdo (emocionEnEseMomento=emocionDominante,fecha=new Date(),descripcion=unaDescripcion)
		self.agregarRecuerdoDelDia(recuerdo)
	}
	
	override method niega(unRecuerdo){
		emocionDominante.saberSiNiega(unRecuerdo.emocionEnEseMomento())
	}
	
	override method dormir (){
		procesosMentales.forEach({unProceso=>unProceso.efectoSobre(self)})
	}
	
	override method rememorar(){
		pensamientoActual = self.recuerdosMasAntiguosQueMitadDeEdad().anyOne()
	}
	
	override method dejaVu(){
		self.repeticionesDe(pensamientoActual) > 1
	}
}



