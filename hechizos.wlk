import direcciones.*
import wollok.game.*



class Hechizo {
  var property image = ""
  var property position = game.at(0,0)

<<<<<<< HEAD
  method enfriamiento() = 2000
  method lanzar(jugador)
  method danio(jugador)
  method eliminar() {
    image = ""
  }

}
class Curacion inherits Hechizo {
  override method lanzar(jugador) {
    const mana = 5
    jugador.darVida(10)
    jugador.darVida(jugador.magia())
    jugador.sacarMana(mana)
  }
  override method enfriamiento() = super() + 5000
  override method danio(jugador) = 0
}

class Fuego inherits Hechizo { 
  override method lanzar(jugador) {
    image = "bolaDeFuego" + jugador.ultimaDireccion().nombre() + ".png"             // Imagen de la bola de fuego
=======
 method lanzar(jugador) {
    image = jugador.poder()               // Imagen de la bola de fuego
>>>>>>> d2ba7ae7d32eef5c51d2ed19d910617069cbe747
    position = jugador.position()              // Aparece en el jugador
    game.addVisual(self)                           // Se muestra en pantalla

    const direccionALanzar = jugador.ultimaDireccion()      // Dirección actual del jugador

    (1..16).forEach({m =>
        game.schedule(m * 100, {
            self.moverseHacia(direccionALanzar)           // Se mueve paso a paso
        })
    })

    game.schedule(1700, {
        self.eliminarHechizo()                 // Limpia imagen
        game.removeVisual(self)                    // Se elimina del juego
    })
  }

  method eliminar() {
    image = ""
  }
<<<<<<< HEAD

  override method danio(jugador) = 1

  method moverseHacia(direccion) {
=======
   method eliminarHechizo() {
    image = ""
  }
 method moverseHacia(direccion) {
>>>>>>> d2ba7ae7d32eef5c51d2ed19d910617069cbe747
    direccion.mover(self)
  }
}




<<<<<<< HEAD
  method expandir() {
    // efecto de expansión: reemplazar imagen o cambiar size
  }
  override method enfriamiento() = super() + 6000
  override method danio(jugador) = 1.5 * jugador.magia()
}

class Teletransportacion inherits Hechizo {
  // implementar comportamiento de teletransporte cuando haga falta
}
=======
>>>>>>> d2ba7ae7d32eef5c51d2ed19d910617069cbe747

