import wollok.game.*
import direcciones.*
import hechizos.*
import personajes.*

class Jugador {
    const nombre
    var property image
    var property position
    var vida 
    var direccionActual = este
    method alternarImagen(unaDireccion) {
        image = nombre + unaDireccion.nombre() + ".png"
    }

    // VERIFICAR EL MOVIMIENTO QUE NO SALGA DE PANTALLA

    method moverseHacia(direccion) {
        self.alternarImagen(direccion)
        direccion.mover(self)
        direccionActual = direccion
    }

    method ultimaDireccion() = direccionActual

    method vidaMaxima() = 5  

    method darVida() = (vida + 1).min(self.vidaMaxima())
    method sacarVida() = (vida - 1).max(0)


    method recibirAtaque() {
        if(vida >0){
            self.sacarVida()
        }else if(vida <= 0){
            self.morir()
        }
    }
      method morir() {
    image = "charcoSangre"
  }
    method estaVivo() = vida > 0
<<<<<<< HEAD
    
    method puedeLanzar(hechizo) = mana >= hechizo.costo()
=======
    method poder()  
>>>>>>> d2ba7ae7d32eef5c51d2ed19d910617069cbe747
}

class Guerrero inherits Jugador {
    
    override method poder() = "hacha.png"
}

class Arquero inherits Jugador {
    override method poder() = "flecha.png"
}


class Barbaro inherits Jugador {
     override method poder() = "arania.png"
}

class Mago inherits Jugador {
    override method poder() = "bolaDeFuego.png"

}
