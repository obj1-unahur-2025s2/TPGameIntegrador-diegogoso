import wollok.game.*
import pantallas.*
import clases.*
import direcciones.*
import hechizos.*
import enemigos.*



const guerrero = new Guerrero(
    nombre = "guerrero",
    image = "guerreroeste.png",
    vida = 80,
    fuerza = 20,
    mana = 10,
    magia = 5,
    position = game.center()
)

const arquero = new Arquero(
    nombre = "arquero",
    image = "arqueroeste.png",
    vida = 60,
    fuerza = 15,
    mana = 20,
    magia = 15,
    position = game.center()
)

const barbaro = new Barbaro(
    nombre = "barbaro",
    image = "barbaroeste.png",
    vida = 150,
    fuerza = 30,
    mana = 0,
    magia = 0,
    position = game.center()
)

const mago = new Mago(
    nombre = "mago",
    image = "magoeste.png",
    vida = 60,
    fuerza = 5,
    mana = 50,
    magia = 30,
    position = game.center()
)
const jefe = new Jefe(
    vidasRestantes = 10,
    //nombre = "jefe",
    image = "jefe.png",
    position = game.center()
)

   // magia = 20,
    
)