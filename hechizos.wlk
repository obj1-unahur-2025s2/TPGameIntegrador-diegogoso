import direcciones.*
import wollok.game.*

class Hechizo {
  var property image = ""
  var property position = game.at(0,0)
  const property esMalvado

method lanzar(jugador) {
  if(self.esMalvado()){image = jugador.poder()}
  else{ image = jugador.poder() + jugador.ultimaDireccion().nombre() + ".png"}
    position = jugador.position()
    game.addVisual(self)                           
    const direccionALanzar = jugador.ultimaDireccion()

    (1..16).forEach({m =>
        game.schedule(m * 100, {  // Programa un movimiento cada 100ms
            self.moverseHacia(direccionALanzar) // Se mueve un paso
        })
    })

    game.schedule(1700, {
        self.eliminarHechizo()
        game.removeVisual(self)
    })
  }

  // 4. El método de autodestrucción
  method eliminarHechizo() {
    image = ""
  }

  // 5. El método que usa la colisión para saber cuánto dañar
  method danio() = 1

  // 6. El método que usa el 'schedule' para moverse
  method moverseHacia(direccion) {
    // ESTO DEPENDE DE 'direcciones.wlk'
    direccion.mover(self)
  }
}

class BolaDeFuegoVerde inherits Hechizo {
  override method danio() = 2
}