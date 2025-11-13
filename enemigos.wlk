import hechizos.*
import juego.*
import wollok.game.*
import direcciones.*
import pantallas.*

class Enemigo {
  var property position = self.posicionAleatoria()
  var property vida 
  var property image
  const poder = ""
  var ultimaDireccion = sur

  var pasosRestantes = 0
  var direccionActual = sur

  method image() = image

  method poder() = poder 

  method ultimaDireccion() = ultimaDireccion

  method moverAleatoriamente() { 
    const direccion = [norte, oeste, sur, este].randomized().first()
    pasosRestantes = 1.randomUpTo(6) //genero la cantidad de pasos aleatorios, entre 1 y 6
    direccionActual = direccion
    if (pasosRestantes > 0) {
        direccionActual.mover(self)  // ESTO DEPENDE DE 'direcciones.wlk'
        pasosRestantes = pasosRestantes - 1
    } else {
        self.moverAleatoriamente() //Cuando no quedan pasos, elije un  nuevo movimiento
    }
    ultimaDireccion = direccionActual
  }

  method posicionAleatoria() {
    const x = 2.randomUpTo(limiteMaximo)
    const y = 2.randomUpTo(limiteMaximo)
    return game.at(x, y)
    }

  method sacarVida(cantidad) { 
    vida = (vida - cantidad).max(0) 
  }

  method recibirAtaque(hechizo) {
    if (vida > 0 && !hechizo.esMalvado()) {
      self.sacarVida(hechizo.danio())
    }
  }
  method mostrarDanio() 
  method vida() = vida

  method estaVivo() = vida > 0
}

class Arania inherits Enemigo {
  override method poder() = "telaarania.png"
  
  override method sacarVida(cantidad) {
    super(cantidad)
    self.mostrarDanio()
    if (!self.estaVivo()) {
        juego.removerEnemigo(self)
        charcoDeSangre.dejarCharcoDeSangre(self.position())
       
      }  
  }
  
  override method mostrarDanio() {
        game.schedule(200, { self.image("araniadanio.png") })
    game.schedule(400, { self.image("arania.png") })
}
}

class Orco inherits Enemigo {
  override method poder() = "bolaOscura.png"

override method sacarVida(cantidad) {
  super(cantidad)
  self.mostrarDanio()
  if (!self.estaVivo()) {
        juego.removerEnemigo(self)
        charcoDeSangre.dejarCharcoDeSangre(self.position())
        
    }  
  }
  override method mostrarDanio() {
    game.schedule(200, { self.image("orcoDanio.png") })
    game.schedule(400, { self.image("orco.png") })
  }
}

class Jefe inherits Enemigo {
  const vidaInicial = 12
  method restaurar() { vida = vidaInicial }

  override method sacarVida(cantidad) {
    super(cantidad)
    self.mostrarDanio()
    if (!self.estaVivo()) {
      game.removeVisual(self)
      charcoDeSangre.dejarCharcoDeSangre(self.position())
      game.schedule(2100, {juego.finDelJuego()})
    }
  }
  
  override method poder() = "bolaDeFuegoVerde.png"

  override method mostrarDanio() {
    game.schedule(200, { self.image("jefedanio.png") })
    game.schedule(400, { self.image("jefe.png") })
  }
}

object charcoDeSangre {
  var property image = "charcoDeSangre.png"
  var property position = game.at(0,0)
  method dejarCharcoDeSangre(posicion) {
    self.image("charcoDeSangre.png")
    game.addVisual(self)
    self.position(posicion)
    game.schedule(2000, {game.removeVisual(self)})
  }
}