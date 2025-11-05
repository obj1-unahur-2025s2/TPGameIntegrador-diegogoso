import hechizos.*
import juego.*
import wollok.game.*
import direcciones.*

class Enemigo {
<<<<<<< HEAD
  var property position = self.posicionAleatoria()
  var property vida
  var property image
  var poder // debe retornar una imagen 

  method image() = image
  method poder() = poder 
=======
  var property position
  var property vida
  var property image

>>>>>>> b9ece30984de86c597447325ed03c42a35b299ea
  method moverAleatoriamente() {
    const direcciones = [norte, oeste, sur, este]
    const direccionAleatoria = direcciones.randomized().first()
    direccionAleatoria.mover(self)
  }

<<<<<<< HEAD
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
=======
  method recibirAtaque(hechizo) {
    vida -= hechizo.danio().max(0)
>>>>>>> b9ece30984de86c597447325ed03c42a35b299ea
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

