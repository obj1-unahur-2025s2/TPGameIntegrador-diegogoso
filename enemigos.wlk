import hechizos.*
import juego.*
import wollok.game.*
import direcciones.*

class Enemigo {
  var property position
  var property vidasRestantes
  var property image

  method sacarVida(cantidad) {
    vidasRestantes = (vidasRestantes - cantidad).max(0)
    if (vidasRestantes == 0) {
      // Cuando muere, delegamos en el objeto juego para que lo remueva de la lista y la pantalla
      juego.removerEnemigo(self)
    }
  }

  method moverAleatoriamente() {
    const direcciones = [norte, oeste, sur, este]
    const direccionAleatoria = direcciones.randomized().first()
    direccionAleatoria.mover(self)
  }

  method recibirAtaque(hechizo) {
    // Asume que hechizo.danio(self) devuelve la cantidad de daño
    self.sacarVida(hechizo.danio(self))
    juego.verificarPasoDeNivel()
  }

  method estaVivo() = vidasRestantes > 0
}

class Arania inherits Enemigo {
  override method sacarVida(cantidad) {
    super(cantidad)
    // efecto visual de daño
    game.schedule(200, { image = "araniadanio.png" })
    game.schedule(400, { image = "arania.png" })
  }
}
class Jefe inherits Enemigo {
  override method sacarVida(cantidad) {
    super(cantidad)
    // efecto visual de daño
    game.schedule(200, { image = "jefedanio.png" })
    game.schedule(400, { image = "jefe.png" })
  }
}

