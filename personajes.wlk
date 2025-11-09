import wollok.game.*
import pantallas.*
import clases.*
import direcciones.*
import hechizos.*
import enemigos.*

const guerrero = new Guerrero(
    vida = 5,
    nombre = "guerrero",
    image = "guerreroeste.png"
)

const arquero = new Arquero(
    vida = 5,
    nombre = "arquero",
    image = "arqueroeste.png"
)

const barbaro = new Barbaro(
    vida = 5,
    nombre = "barbaro",
    image = "barbaroeste.png"
)

const mago = new Mago(
    vida = 5,
    nombre = "mago",
    image = "magoeste.png"
)

const orco = new Orco (
    vida = 1, // 8
    image = "orco.png",
    poder = "bolaOscura.png"
)

const arania = new Arania(
    vida = 6, // 8
    image = "arania.png",   
    poder = "telarania.png"
)

const jefe = new Jefe(
    vida = 12, // 16
    image = "jefe.png",
    poder = "bolaDeFuegoVerde.png"
)