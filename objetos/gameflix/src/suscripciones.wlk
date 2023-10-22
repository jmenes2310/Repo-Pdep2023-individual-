object premium{
	method precio(){
		return 50
	}
	method permiteJugarA(unJuego){
		return true
	}
}


object base {
	method precio(){
		return 25
	}
	method permiteJugarA(unJuego){
		return unJuego.valeMenosDe(30)
	}
}


class SuscripcionCategorica{
	var precio
	const categoria
	
	method precio(){
		return precio
	}
	
	method permiteJugarA(unJuego){
		return unJuego.esDeCategoria(categoria)
	}
	
}

const infantil = new SuscripcionCategorica(precio=10,categoria="infantil")
const prueba= new SuscripcionCategorica(precio=0,categoria="prueba")