import direcciones.*
import wollok.game.*



class Hechizo {
  var property image = ""
  var property position = game.at(0,0)

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
    position = jugador.position()              // Aparece en el jugador
    game.addVisual(self)                           // Se muestra en pantalla

    const direccionALanzar = jugador.ultimaDireccion()      // Dirección actual del jugador

    (1..16).forEach({m =>
        game.schedule(m * 100, {
            self.moverseHacia(direccionALanzar)           // Se mueve paso a paso
        })
    })

    game.schedule(1700, {
        self.eliminarBolaDeFuego()                 // Limpia imagen
        game.removeVisual(self)                    // Se elimina del juego
    })
  }

  method eliminarBolaDeFuego() {
    image = ""
  }

  override method danio(jugador) = jugador.sacarVida(jugador.magia() * 3)

  method moverseHacia(direccion) {
    direccion.mover(self)
  }
}

class Agua inherits Hechizo {

  override method lanzar(jugador) {
    if (jugador.mana() >= 10) {
      jugador.sacarMana(10)
      position = jugador.position()
      game.addVisual(self)

      game.schedule(200, {
        self.expandir()
      })
      game.schedule(400, {
        game.removeVisual(self)
      })
    }
  }

  method expandir() {
    // efecto de expansión: reemplazar imagen o cambiar size
  }
  override method enfriamiento() = super() + 6000
  override method danio(jugador) = jugador.sacarVida(1.5 * jugador.magia())
}

class Teletransportacion inherits Hechizo {
  // implementar comportamiento de teletransporte cuando haga falta
}

