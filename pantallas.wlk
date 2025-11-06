import wollok.game.*
import juego.*

object pantallas {
	const property inicio = new Fondo(position=game.at(0,0), img="pantallaInicio.png")
	const property seleccion = new Fondo(position=game.at(0,0), img="seleccionDePersonajes.png")
	const property juego = new Fondo(position=game.at(0,0), img="fondoDelJuego.png")
	const property nivel2 = new Fondo(position=game.at(0,0), img="niveldosfondo.png")
} // agregar la ultima const

class Visual {
    var property position = game.at(0,0)
    const img = ""

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
    } // agregar desde 32 hasta 35
	/* const property mensajeNivel2 = new Visual(
    		position = game.center(),
    		img = "nivel2Mensaje.png"
		)*/
}

class Fondo inherits Visual{}