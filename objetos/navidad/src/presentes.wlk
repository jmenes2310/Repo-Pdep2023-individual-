class Regalo {
	const precio
	const destinatario
	
	method destinatario(){
		return destinatario
	}
	
	method costo(){
		return precio
	}
	
	method esTeQuierenMucho(unArbol){
		return precio > unArbol.precioPromedioDeRegalo()
		
	}
}

class Tarjeta{
	const precio =2
	const destinatario
	const valorAdjunto
	
	method destinatario(){
		return destinatario
	}
	
	method costo(){
		return precio + valorAdjunto
	}
	
	method esGenerosa(){
		return valorAdjunto > 1000
	}
	
}