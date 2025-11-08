import wollok.game.*

object pantallas {
	const property inicio = new Fondo(position=game.at(0,0), img="pantallaInicio.png")
	const property seleccion = new Fondo(position=game.at(0,0), img="seleccionDePersonajes.png")
	const property juego = new Fondo(position=game.at(0,0), img="fondoDelJuego.png")
	const property nivel2 = new Fondo(position=game.at(0,0), img="niveldosfondo.png")
	const property barraDeVida = new BarraDeVida(position = game.at(0,14), img = "1barradevida.png")
	const property victoria = new Fondo(position=game.at(0,0), img="findeljuego.png")
	const property creditos = new Fondo(position=game.at(0,0), img="creditos.png")
	const property gameOver = new Fondo(position=game.at(0,0), img="gameover.png")
} 

class Visual {
    var property position = game.at(0,0)
    var img = ""

    method image() = img
    
    method agregarVisual(){
    	if (!game.hasVisual(self)){
    		game.addVisual(self)
    	}
    }

	method hasVisual() { 
		return game.hasVisual(self) 
	}
    
    method removerVisual(){
    	if (game.hasVisual(self)){
    		game.removeVisual(self)
    	}
    }
	 // agregar desde 32 hasta 35
	/* const property mensajeNivel2 = new Visual(
    		position = game.center(),
    		img = "nivel2Mensaje.png"
		)*/
}

class Fondo inherits Visual{}

class BarraDeVida inherits Visual{
	method actualizarse(unJugador) {
		img = unJugador.vida().toString() + "barradevida.png"
	}
}