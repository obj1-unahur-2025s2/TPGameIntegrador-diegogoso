import direcciones.*
import wollok.game.*
import enemigos.*

class Hechizo {
  var property image = ""
  var property position = game.at(0,0)
  const property esMalvado
  var property estaVivo = true
  var pasos = 16


  method lanzar(jugador) {
      if(self.esMalvado()){ image = jugador.poder()}
      else{ image = jugador.poder() + jugador.ultimaDireccion().nombre() + ".png"}
      position = jugador.position()
      game.addVisual(self)
      self.moverHechizo(jugador.ultimaDireccion())
    }

  method moverHechizo(direccion){
    game.onTick(200, self, { 
        self.moverseHacia(direccion)
        pasos -= 1
        if (pasos <= 0) {
            self.destruir() // Llama al nuevo método destruir
        }
    })
  }

  method destruir() {
    game.removeTickEvent(self) // Detiene este tick en particular
    game.removeVisual(self) // Borra la visual
    estaVivo = false
  }

  method danio() = 1

  // ESTO DEPENDE DE 'direcciones.wlk'
  method moverseHacia(direccion) {

    direccion.mover(self)
  }

  method recibirAtaque(otroHechizo) {
    // Un hechizo no hace nada cuando choca con otro hechizo.
    // Se agrega este método vacío para evitar el error 
    // "MessageNotUnderstoodException" cuando dos hechizos colisionan.
  }

}

class BolaDeFuegoVerde inherits Hechizo {
  override method danio() = 2
}