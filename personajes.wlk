import wollok.game.*
import pantallas.*
import clases.*
import direcciones.*
import hechizos.*
import enemigos.*

    const guerrero = new Guerrero(
        nombre = "guerrero",
        image = "guerreroeste.png",
        vida = 5,
        position = game.center()
    )

    const arquero = new Arquero(
        nombre = "arquero",
        image = "arqueroeste.png",
        vida = 5,
        position = game.center()
    )

    const barbaro = new Barbaro(
        nombre = "barbaro",
        image = "barbaroeste.png",
        vida = 5,
        position = game.center()
    )

    const mago = new Mago(
        nombre = "mago",
        image = "magoeste.png",
        vida = 5,
        position = game.center()
    )
