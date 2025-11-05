import direcciones.*
import wollok.game.*



class Hechizo {
  var property image = ""
  var property position = game.at(0,0)

 method lanzar(jugador) {
    image = jugador.poder()               // Imagen de la bola de fuego
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





