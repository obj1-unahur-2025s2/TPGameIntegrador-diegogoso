object norte {
  method mover(jugador) {
    if(jugador.position().y() < 14){
      jugador.position(jugador.position().up(1))
    }
  }
}

object sur {
  method mover(jugador) {
    if(jugador.position().y() > 1){
      jugador.position(jugador.position().down(1))
    }
  }
}

object este {
  method mover(jugador) {
    if(jugador.position().x() < 14){
      jugador.position(jugador.position().right(1))
    }
  }
}

object oeste {
  method mover(jugador) {
    if(jugador.position().x() > 1){
      jugador.position(jugador.position().left(1))
    }
  }
}