
//limites del tablero
const limiteMaximo = 15
const limiteMinimo = 0
object norte {
  method nombre() = "norte"
  method mover(personaje) {
    if(personaje.position().y() < limiteMaximo) {
      personaje.position(personaje.position().up(1))
    }
  }
}


object sur {
  method nombre() = "sur"
  method mover(personaje) {
    if(personaje.position().y() > limiteMinimo) {
      personaje.position(personaje.position().down(1))
    }
  }
}

object este {
  method nombre() = "este"
  method mover(personaje) {
    if(personaje.position().x() < limiteMaximo) {
      personaje.position(personaje.position().right(1))
    }
  }
}

object oeste {
  method nombre() = "oeste"
  method mover(personaje) {
    if(personaje.position().x() > limiteMinimo) {
      personaje.position(personaje.position().left(1))
    }
  }
}