import direcciones.*
import wollok.game.*

class Hechizo {
  var property image = ""
  var property position = game.at(0,0)
  const property esMalvado
  const pasos = 16



//Otra forma de lanzar los hechizos, yo lo noto algo más lento, aunque te deja lanzar uno atrás del otro
  /*method lanzar(jugador) {
    if(self.esMalvado()){ image = jugador.poder()}
    else{ image = jugador.poder() + jugador.ultimaDireccion().nombre() + ".png"}
    position = jugador.position()
    game.addVisual(self)
    const direccionALanzar = jugador.ultimaDireccion()
    if (pasos > 0) {
      game.onTick(200, "generarHechizo", { self.moverseHacia(direccionALanzar) })
    }
    game.schedule(3200, {
        game.removeVisual(self)
    })
}
  */




//Con este yo noto que no deja lanzar varios a la vez con la misma facilidad
/*method lanzar(jugador) {
  if(self.esMalvado()){image = jugador.poder()}
  else{ image = jugador.poder() + jugador.ultimaDireccion().nombre() + ".png"}
    position = jugador.position()
    game.addVisual(self)                           
    const direccionALanzar = jugador.ultimaDireccion()

    (1..16).forEach({m =>
        game.schedule(m * 200, {  // Programa un movimiento cada 100ms
            self.moverseHacia(direccionALanzar) // Se mueve un paso
        })
    })

    game.schedule(1700, {
        game.removeVisual(self)
    })
  }*/




//3 era oopcion, tambien funciona
method lanzar(jugador) {
    if (self.esMalvado()) { image = jugador.poder() }
    else { image = jugador.poder() + jugador.ultimaDireccion().nombre() + ".png" }
    position = jugador.position()
    game.addVisual(self)
    self.moverHechizo(jugador.ultimaDireccion(), pasos) 
  }

  // Mueve el hechizo paso a paso
  method moverHechizo(direccion, pasosRestantes) {
    if (pasosRestantes > 0) {
      self.moverseHacia(direccion) 
      game.schedule(200, { 
        self.moverHechizo(direccion, pasosRestantes - 1) 
      })
    } else {
      game.removeVisual(self)
    }
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