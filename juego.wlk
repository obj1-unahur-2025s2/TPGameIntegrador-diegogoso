import wollok.game.*
import pantallas.*
import clases.*
import direcciones.*
import hechizos.*
import enemigos.*

object juego {
    var jugador = arquero
    
    const enemigos = #{arania, arania2, arania3}
    
    method jugador() = jugador

    method cambiarJugador(nuevoJugador) {
        jugador = nuevoJugador
    }

    const arania = new Enemigo(
        position = game.at (12,13),
        image = "arania.png",
        vida = 5
    )

    const arania2 = new Enemigo(
        position = game.at (13,13),
        image = "arania.png",
        vida = 5
    )
        const arania3 = new Enemigo(
        position = game.at (14,13),
        image = "arania.png",
        vida = 5
    )

    const guerrero = new Guerrero(
        imageBase = "guerreroRPC.png",
        imageAlt = "guerreroRPA.png",
        image = "guerreroRPC.png",
        vida = 80,
        fuerza = 20,
        mana = 10,
        magia = 5,
        position = game.center()
    )

    const arquero = new Arquero(
        imageBase = "arqueroRPC.png",
        imageAlt = "arqueroRPA.png",
        image = "arqueroRPC.png",
        vida = 60,
        fuerza = 15,
        mana = 20,
        magia = 15,
        position = game.center()
    )

    
    const barbaro = new Barbaro(
        imageBase = "barbaroRPC.png",
        imageAlt = "barbaroRPA.png",
        image = "barbaroRPC.png",
        vida = 150,
        fuerza = 30,
        mana = 0,
        magia = 0,
        position = game.center()
    )

    const mago = new Mago(
        imageBase = "magoRPC.png",
        imageAlt = "magoRPA.png",
        image = "magoRPC.png",
        vida = 60,
        fuerza = 5,
        mana = 50,
        magia = 30,
        position = game.center()
    )

    method iniciarMenu() {
        game.title("gameGeneral")
        game.height(16)
        game.width(16)
        game.cellSize(64)

        pantallas.inicio().agregarVisual()

        keyboard.enter().onPressDo({
            pantallas.inicio().removerVisual()
            pantallas.seleccion().agregarVisual()
        })

        keyboard.u().onPressDo({
            if (pantallas.seleccion().hasVisual()) {
                self.cambiarJugador(arquero)
                self.iniciar()
            }
        })

        keyboard.i().onPressDo({
            if (pantallas.seleccion().hasVisual()) {
                self.cambiarJugador(barbaro)
                self.iniciar()
            }
        })

        keyboard.o().onPressDo({
            if (pantallas.seleccion().hasVisual()) {
                self.cambiarJugador(guerrero)
                self.iniciar()
            }
        })

        keyboard.p().onPressDo({
            if (pantallas.seleccion().hasVisual()) {
                self.cambiarJugador(mago)
                self.iniciar()
            }
        })
    }

    method iniciar() {
        pantallas.seleccion().removerVisual()
        pantallas.juego().agregarVisual()
        game.addVisualCharacter(jugador)

        keyboard.w().onPressDo({
            jugador.moverseHacia(norte)
        })

        keyboard.s().onPressDo({
            jugador.moverseHacia(sur)
        })

        keyboard.a().onPressDo({
            jugador.moverseHacia(oeste)
        })

        keyboard.d().onPressDo({
            jugador.moverseHacia(este)
        })

        keyboard.j().onPressDo({
            const fuego = new Fuego()
            fuego.lanzar(jugador)  
        })

        enemigos.forEach({e => 
        game.addVisual(e)
            game.onTick(2000, "mueve aleatoriamente", {e.moverAleatoriamente() })
        })
        
      
    }
}
