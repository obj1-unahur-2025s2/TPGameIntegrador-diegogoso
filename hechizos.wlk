import direcciones.*
import wollok.game.*

class Hechizo {
  var property image = ""
  var property position = game.at(0,0)
  const property esMalvado

  method lanzar(lanzador) { 
    image = lanzador.poder()
    position = lanzador.position()
    game.addVisual(self)                           
    const direccionALanzar = lanzador.ultimaDireccion()

    (1..16).forEach({m =>
        game.schedule(m * 100, {  // Programa un movimiento cada 100ms
            self.moverseHacia(direccionALanzar) // Se mueve un paso
        })
    })

    game.schedule(1700, {
        self.eliminar()
        game.removeVisual(self)
    })
  }

  method danio() = 1

  method eliminar() {
    image = ""
  }

   method moverseHacia(direccion) {
    // ESTO DEPENDE DE 'direcciones.wlk'
    direccion.mover(self)
  }

  method recibirAtaque(unHechizo) {
    // Los hechizos no reciben ataques
  }
}

class Fuego inherits Hechizo { 
  override method lanzar(jugador) {
    image = "bolaDeFuego" + jugador.ultimaDireccion().nombre() + ".png"
    position = jugador.position()
    game.addVisual(self)                           
    const direccionALanzar = jugador.ultimaDireccion()

    (1..16).forEach({m =>
        game.schedule(m * 100, {  // Programa un movimiento cada 100ms
            self.moverseHacia(direccionALanzar) // Se mueve un paso
        })
    })

    game.schedule(1700, {
        self.eliminar()
        game.removeVisual(self)
    })
  } 

  override method danio() = 2
}

class Flecha inherits Hechizo { 
  override method lanzar(jugador) {
    image = "flecha" + jugador.ultimaDireccion().nombre() + ".png"
    position = jugador.position()
    game.addVisual(self)                           
    const direccionALanzar = jugador.ultimaDireccion()

    (1..16).forEach({m =>
        game.schedule(m * 100, {  // Programa un movimiento cada 100ms
            self.moverseHacia(direccionALanzar) // Se mueve un paso
        })
    })

    game.schedule(1700, {
        self.eliminar()
        game.removeVisual(self)
    })
  } 

  override method danio() = 3
}


class Hacha inherits Hechizo { 
  override method lanzar(jugador) {
    image = "hacha" + jugador.ultimaDireccion().nombre() + ".png"
    position = jugador.position()
    game.addVisual(self)                           
    const direccionALanzar = jugador.ultimaDireccion()

    (1..16).forEach({m =>
        game.schedule(m * 100, {  // Programa un movimiento cada 100ms
            self.moverseHacia(direccionALanzar) // Se mueve un paso
        })
    })

    game.schedule(1700, {
        self.eliminar()
        game.removeVisual(self)
    })
  } 

  override method danio() = 1
}