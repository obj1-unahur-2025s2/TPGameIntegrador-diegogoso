import direcciones.*
import hechizos.*
object jugador {
     var property imageBase = "defaultRPC.png"
     var property imageAlt = "defaultRPA.png"
     var property image = imageBase

     method alternarImagen() {
          if (image == imageBase) {
               image = imageAlt
          } else {
               image = imageBase
          }
     }

     var property position = new Position(x=0, y=0)
     var ultimaDireccion = norte
     method ultimaDireccion() = ultimaDireccion

     method moverseHacia(direccion) {
          self.alternarImagen()
          if (direccion == norte.direcc()) {
               self.position(self.position().up(1))
               ultimaDireccion = norte
          } else if (direccion == oeste.direcc()) {
               self.position(self.position().left(1))
               ultimaDireccion = oeste
          } else if (direccion == este.direcc()) {
               self.position(self.position().right(1))
               ultimaDireccion = este
          } else {
               self.position(self.position().down(1))
               ultimaDireccion = sur
          }
     }

     var vida = 100
     method vidaMaxima() = 100
     method darVida(cantidad) = (vida + cantidad).min(self.vidaMaxima())
     method sacarVida(cantidad) = (vida - cantidad).max(0)

     var fuerza = 0

     var mana = 0
     method manaMaxima() = 0
     method darMana(cantidad) = (mana + cantidad).min(self.manaMaxima())
     method sacarMana(cantidad) = (mana - cantidad).max(0)

     var magia = 0
     method magia() = magia

     method echizos() = ninguno

     method lanzarHechizo() {
          // comportamiento por defecto (puede sobreescribirse)
     }

     method recibirAtaque(hechizo) {
          self.sacarVida(hechizo.danio())
     }
}

object guerrero inherits jugador {
     var property imageBase = "guerreroRPC.png"
     var property imageAlt = "guerreroRPA.png"
     var property image = imageBase

     var property position = new Position(x=4, y=7)

     var vida = 80
     method vidaMaxima() = 80

     var fuerza = 20

     var mana = 10
     method manaMaxima() = 10

     var magia = 5
     method magia() = magia

     method hechizos() = curacion
}

object arquero inherits jugador {
     var property imageBase = "arqueroRPC.png"
     var property imageAlt = "arqueroRPA.png"
     var property image = imageBase

     var property position = new Position(x=5, y=7)

     var vida = 60
     method vidaMaxima() = 60

     var fuerza = 15

     var mana = 20
     method manaMaxima() = 20

     var magia = 5
     method magia() = magia

     var cantidadDeFlechas = 30
}

object barbaro inherits jugador {
     var property imageBase = "barbaroRPC.png"
     var property imageAlt = "barbaroRPA.png"
     var property image = imageBase

     var property position = new Position(x=6, y=7)

     var vida = 150
     method vidaMaxima() = 150

     var fuerza = 30

     var magia = 0
     method magia() = magia

     var mana = 0
     method manaMaxima() = 0

     method hechizos() = ninguno
}

object mago inherits jugador {
     var property imageBase = "magoRPC.png"
     var property imageAlt = "magoRPA.png"
     var property image = imageBase

     var property position = new Position(x=7, y=7)

     var vida = 60
     method vidaMaxima() = 60

     var fuerza = 5

     var mana = 50
     method manaMaxima() = 50

     var magia = 30
     method magia() = magia

     method hechizos() = #{curacion, fuego, agua, teletransporte}

     // puede redefinir hechizos si se desea, por ejemplo:
     // method hechizos() = #{curacion, fuego, agua, teletransporte, dash, fortaleza}
}
