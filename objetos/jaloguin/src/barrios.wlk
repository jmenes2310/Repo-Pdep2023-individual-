class Barrio {
	const niniosQueViven = []
	
	method niniosConMasCaramelos(){
		return self.niniosOrdenadosPorCantidadDeCaramelos().take(3)
	}
	
	method niniosOrdenadosPorCantidadDeCaramelos(){
		return niniosQueViven.sortedBy({unNinio , otroNinio =>unNinio.cantidadDeCaramelos() > otroNinio.cantidadDeCaramelos()})
	}
	
	method elemntosUsados(){
		const ninios= niniosQueViven.filter({unNinio=>unNinio.susCaramelosSonMasDe(10)})
		return ninios.flatMap({unNinio=>unNinio.elementosDeDisfraz()})
	}
	
	
}
