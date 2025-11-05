import direcciones.*
import wollok.game.*



class Hechizo {
  var property image = ""
  var property position = game.at(0,0)

<<<<<<< HEAD
 method lanzar(jugador) {
    image = jugador.poder()               // Imagen de la bola de fuego
=======
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
    image = "bolaDeFuego.png"               // Imagen de la bola de fuego
>>>>>>> b9ece30984de86c597447325ed03c42a35b299ea
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
   method eliminarHechizo() {
    image = ""
  }
 method moverseHacia(direccion) {
    direccion.mover(self)
  }
}




<<<<<<< HEAD
=======
  method expandir() {
    // efecto de expansión: reemplazar imagen o cambiar size
  }
  override method enfriamiento() = super() + 6000
  override method danio(jugador) = jugador.sacarVida(1.5 * jugador.magia())
}

class Teletransportacion inherits Hechizo {
  // implementar comportamiento de teletransporte cuando haga falta
}
>>>>>>> b9ece30984de86c597447325ed03c42a35b299ea

