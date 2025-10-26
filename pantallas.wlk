import wollok.game.*
import juego.*

object pantallas {
	const property inicio = new Fondo(position=game.at(0,0), img="pantallaInicio.png")
	const property seleccion = new Fondo(position=game.at(0,0), img="seleccionDePersonajes.png")
}

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
    }
}

class Fondo inherits Visual{}