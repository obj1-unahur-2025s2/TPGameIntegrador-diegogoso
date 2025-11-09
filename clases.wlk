import wollok.game.*
import direcciones.*
import hechizos.*
import personajes.*
import pantallas.*
import juego.*

class Jugador {
    const nombre
    var property image
    var property position = game.center()
    var vida = 5
    var direccionActual = este
    method alternarImagen(unaDireccion) {
        image = nombre + unaDireccion.nombre() + ".png"
    }

    // VERIFICAR EL MOVIMIENTO QUE NO SALGA DE PANTALLA

    method moverseHacia(direccion) {
        self.alternarImagen(direccion)
        direccion.mover(self)
        direccionActual = direccion
    }

    method ultimaDireccion() = direccionActual

    method vida() = vida

    method vidaMaxima() = 5

    method darVida() { vida = 5}

    method sacarVida(cantidad) {
       vida = (vida - cantidad).max(0)
        pantallas.barraDeVida().actualizarse(self)
        if(!self.estaVivo()) {
            juego.gameOver()
        }
    } 


    

    method estaVivo() = vida == 0
    
    method poder()  
}

class Guerrero inherits Jugador { 
    override method poder() = "lanza"
}

class Arquero inherits Jugador {
    override method poder() = "flecha"
}


class Barbaro inherits Jugador {
     override method poder() = "hacha"
}

class Mago inherits Jugador {
    override method poder() = "bolaDeFuego"

}



