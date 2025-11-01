import hechizos.*
import juego.*
import wollok.game.*
import direcciones.*

class Enemigo {
  var property position
  var property image
  var vida

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
}


/*object goblin inherits Enemigo {
    override property position = game.at(10, 10)
    override property image = "" // IMAGEN DE GOBLIN
}*/