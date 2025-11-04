import hechizos.*
import juego.*
import wollok.game.*
import direcciones.*

class Enemigo {
  var property position
  var property vida
  var property image

  method moverAleatoriamente() {
    const direcciones = [norte, oeste, sur, este]
    const direccionAleatoria = direcciones.randomized().first()
    direccionAleatoria.mover(self)
  }

  method recibirAtaque(hechizo) {
    vida -= hechizo.danio().max(0)
    if (vida <= 0) {
      game.removeVisual(self)
    }
  }
  /* para segundo nivel habria que cambiar este de arriba por este 
  method recibirAtaque(hechizo) {
    vida -= hechizo.danio().max(0)
    if (vida <= 0) {
        game.removeVisual(self)
        juego.verificarPasoDeNivel()
    }
}*/
}

