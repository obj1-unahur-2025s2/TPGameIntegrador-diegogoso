import direcciones.*
import hechizos.*
object guerrero {
  var property image = "guerreroRPC.png"
  method alternarImagen() {
   if (image == "guerreroRPC.png"){
    image = "guerreroRPA.png"
   }else{
    image = "guerreroRPC.png"
   }
  }
  var property position = new Position (x=4, y=7)//game.at(4,7) lo mismo  
  var ultimaDireccion = norte
  method ultimaDireccion() = ultimaDireccion
  method moverseHacia(direccion) {
    self.alternarImagen()
    if (direccion == norte.direcc()) {
        self.position(self.position().up(1))
         ultimaDireccion=norte
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
  var vida = 80
  method vidaMaxima() = 80
  method darVida(cantidad) = (vida + cantidad).min(self.vidaMaxima())
  method sacarVida(cantidad) = (vida - cantidad).max(0)
 
  var fuerza = 20

  var mana = 10
  method manaMaxima() = 10
  method darMana(cantidad) = (mana + cantidad).min(self.manaMaxima())
  method sacarMana(cantidad) = (mana - cantidad).max(0)
  var magia = 5
  method magia() = magia

 // var arma = espadaDeDosManos

 // const armadura = armaduraPesada

  method echizos() = curacion
  
  method lanzarHechizo() {
    
  }
       method recibirAtaque(hechizo) {
  self.sacarVida(hechizo.danio())
 }
}
object arquero {
  var property image = "arqueroRPC.png"
  method alternarImagen() {
   if (image == "arqueroRPC.png"){
    image = "arqueroRPA.png"
   }else{
    image = "arqueroRPC.png"
   }
  }
  var property position = new Position (x=5, y=7)//game.at(4,7) lo mismo  
 var ultimaDireccion = norte
  method ultimaDireccion() = ultimaDireccion
  method moverseHacia(direccion) {
    self.alternarImagen()
    if (direccion == norte.direcc()) {
        self.position(self.position().up(1))
         ultimaDireccion=norte
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
  var vida = 60
  method vidaMaxima() = 60
  method darVida(cantidad) = (vida + cantidad).min(self.vidaMaxima())
  method sacarVida(cantidad) = (vida - cantidad).max(0)
  
  var fuerza = 15

  var mana = 20
  method manaMaxima() = 20
  method darMana(cantidad) = (mana + cantidad).min(self.manaMaxima())
  method sacarMana(cantidad) = (mana - cantidad).max(0)
  var magia = 5
  method magia() = magia

 // var arma = arco

  var cantidadDeFlechas = 30

  //const armadura = armaduraDeCuero

 // method echizos() = #{dashes, teletransporte}
  

 method recibirAtaque(hechizo) {
  self.sacarVida(hechizo.danio())
 }
}
object barbaro {
  var property image = "barbaroRPC.png"
  method alternarImagen() {
   if (image == "barbaroRPC.png"){
    image = "barbaroRPA.png"
   }else{
    image = "barbaroRPC.png"
   }
  }
  var property position = new Position (x=6, y=7)//game.at(4,7) lo mismo  
  var ultimaDireccion = norte
  method ultimaDireccion() = ultimaDireccion
  method moverseHacia(direccion) {
    self.alternarImagen()
    if (direccion == norte.direcc()) {
        self.position(self.position().up(1))
         ultimaDireccion=norte
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
  var vida = 150
  method vidaMaxima() = 150
  method darVida(cantidad) = (vida + cantidad).min(self.vidaMaxima())
  method sacarVida(cantidad) = (vida - cantidad).max(0)
  
  var fuerza = 30

  var magia = 0
  method magia() = magia

  var mana = 0
  method manaMaxima() = 0
  method darMana(cantidad) = (mana + cantidad).min(self.manaMaxima())
  method sacarMana(cantidad) = (mana - cantidad).max(0)

 // var arma = hacha

  //var armadura = nignuna

  method echizos() = ninguno

   method recibirAtaque(hechizo) {
  self.sacarVida(hechizo.danio())
 }
}

object mago  {
  var property image = "magoRPC.png"
  method alternarImagen() {
   if (image == "magoRPC.png"){
    image = "magoRPA.png"
   }else{
    image = "magoRPC.png"
   }
  }
  var property position = new Position (x=7, y=7)//game.at(4,7) lo mismo  
   var ultimaDireccion = norte
  method ultimaDireccion() = ultimaDireccion
  method moverseHacia(direccion) {
    self.alternarImagen()
    if (direccion == norte.direcc()) {
        self.position(self.position().up(1))
         ultimaDireccion=norte
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
  var vida = 60
  method vidaMaxima() = 60
  method darVida(cantidad) = (vida + cantidad).min(self.vidaMaxima())
  method sacarVida(cantidad) = (vida - cantidad).max(0)
  
  var fuerza = 5

  var mana = 50
  method manaMaxima() = 50
  method darMana(cantidad) = (mana + cantidad).min(self.manaMaxima())
  method sacarMana(cantidad) = (mana - cantidad).max(0)

  var magia = 30
  method magia() = magia

//  var arma = baculo

 // var armadura = #{tunica, sombreroDeMago}

//  method echizos() = #{curacion, fuego, agua, teletransporte, dash, fortaleza}

 method recibirAtaque(hechizo) {
  self.sacarVida(hechizo.danio())
 }
}