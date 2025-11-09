import hechizos.*
import juego.*
import wollok.game.*
import direcciones.*
import pantallas.*

class Enemigo {
  var property position = self.posicionAleatoria()
  var property vida 
  var property image
  const poder 
  var ultimaDireccion = sur

  method image() = image

  method poder() = poder 

  method ultimaDireccion() = ultimaDireccion

  method moverAleatoriamente() {
    const direcciones = [norte, oeste, sur, este]
    const direccionAleatoria = direcciones.randomized().first()
    direccionAleatoria.mover(self)
    ultimaDireccion = direccionAleatoria
  }

  method posicionAleatoria() {
        const x = 2.randomUpTo(14)
        const y = 2.randomUpTo(14)
        return game.at(x, y)
    }

  method sacarVida(cantidad) { 
    vida = (vida - cantidad).max(0) 
    
    if (vida == 0) {
      // Cuando muere, delegamos en el objeto juego para que lo remueva de la lista y la pantalla
      juego.removerEnemigo(self)
      game.schedule(4000, {
      game.addVisual("charcoSangre.jpg")
      game.removeVisual("charcoSangre.jpg")       
      })
    }
  }

    method recibirAtaque(hechizo) {
      if (vida > 0 && !hechizo.esMalvado()) {
        self.sacarVida(hechizo.danio())
      }
    }
/*
  method morir() {
    game.removeVisual(self)
    //no aparece el charco
    game.schedule(4000, {
      game.addVisual("charcoSangre.jpg")
      game.removeVisual("charcoSangre.jpg")       
        })
    
  }*/
  method vida() = vida
  method estaVivo() = vida > 0

  /* para segundo nivel habria que cambiar este de arriba por este 
  method recibirDanio() {
    vida -= hechizo.danio().max(0)
    if (vida <= 0) {
        game.removeVisual(self)
        juego.verificarPasoDeNivel()
    }
}*/
}

class Arania inherits Enemigo {
  override method poder() = "telaarania.png"
  
  override method sacarVida(cantidad) {
    super(cantidad)
    game.schedule(200, { self.image("araniadanio.png") })
    game.schedule(400, { self.image("arania.png") })
    if (vida == 0) {
      juego.removerEnemigo(self)
    }
  }
  
}

class Orco inherits Enemigo {
  override method poder() = "bolaOscura.png"

override method sacarVida(cantidad) {
    super(cantidad)
    game.schedule(200, { self.image("orcoDanio.png") })
    game.schedule(400, { self.image("orco.png") })
    if (vida == 0) {
      juego.removerEnemigo(self)
    }
  }
}

class Jefe inherits Enemigo {
  // Usa el valor de `poder` pasado en el constructor (bolaDeFuegoVerde.png)
  // No hace falta override porque hereda method poder() = poder de Enemigo

  override method sacarVida(cantidad) {
    super(cantidad)
    game.schedule(200, { self.image("jefedanio.png") })
    game.schedule(400, { self.image("jefe.png") })
    if (!self.estaVivo()) {
      juego.removerEnemigo(self)
      pantallas.nivel2().removerVisual()
      juego.finDelJuego()
    }
  }
  
  override method poder() = "bolaDeFuegoVerde.png"
}

