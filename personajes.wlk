import wollok.game.*
import pantallas.*
import clases.*
import direcciones.*
import hechizos.*
import enemigos.*

const guerrero = new Guerrero(
    nombre = "guerrero",
    image = "guerreroeste.png"
)

const arquero = new Arquero(
    nombre = "arquero",
    image = "arqueroeste.png"
)

const barbaro = new Barbaro(
    nombre = "barbaro",
    image = "barbaroeste.png"
)

const mago = new Mago(
    nombre = "mago",
    image = "magoeste.png"
)

const orco = new Orco (
    vida = 1, // 8
    image = "orco.png",
    poder = "bolaOscura.png"
)

const arania = new Arania(
    vida = 1, // 8
    image = "arania.png",   
    poder = "telarania.png"
)

const jefe = new Jefe(
    vida = 1, // 16
    image = "jefe.png",
    poder = "bolaDeFuegoAzul.png"
)