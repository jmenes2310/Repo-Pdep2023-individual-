class NoEstaElJuegoEnElCatalogoException inherits Exception {
	const nombreJuego
	
	override method message (){
		return "no esta en el catalogo el juego llamado " + nombreJuego
	}
	
}
