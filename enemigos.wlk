import hechizos.*
import juego.*
import wollok.game.*
import direcciones.*

class Enemigo {
<<<<<<< HEAD
  var property position
  var property vidasRestantes
=======
  var property position = self.posicionAleatoria()
  var property vida
>>>>>>> d2ba7ae7d32eef5c51d2ed19d910617069cbe747
  var property image
  var poder // debe retornar una imagen 

<<<<<<< HEAD
  method sacarVida(cantidad) {
    vidasRestantes = (vidasRestantes - cantidad).max(0)
    if (vidasRestantes == 0) {
      // Cuando muere, delegamos en el objeto juego para que lo remueva de la lista y la pantalla
      juego.removerEnemigo(self)
    }
  }

=======
  method image() = image
  method poder() = poder 
>>>>>>> d2ba7ae7d32eef5c51d2ed19d910617069cbe747
  method moverAleatoriamente() {
    const direcciones = [norte, oeste, sur, este]
    const direccionAleatoria = direcciones.randomized().first()
    direccionAleatoria.mover(self)
  }

<<<<<<< HEAD
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
=======
  method posicionAleatoria() {
        const x = 0.randomUpTo(game.width())
        const y = 0.randomUpTo(game.height())
        return game.at(x, y)
    }
      method sacarVida() = (vida - 1).max(0)
  method recibirAtaque() {
    if (vida >0){
      self.sacarVida()
    } 
    if (vida <= 0) {
      self.morir()
    }
  }
  method morir() {
    image = "charcoSangre"
    // aca deberia cargar pantalla game over
  }
  method vida() = vida
  method lanzarAtaque() {
    const ataque = new Hechizo()
    ataque.lanzar(self)
    game.onCollideDo(ataque, {objetivo => objetivo.recibirAtaque()})
>>>>>>> d2ba7ae7d32eef5c51d2ed19d910617069cbe747
  }
}

