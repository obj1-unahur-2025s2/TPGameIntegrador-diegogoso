import wollok.game.*
import pantallas.*
import clases.*

object juego {
    var jugador = barbaro

    method jugador() = jugador

    method cambiarJugador(nuevoJugador) {
        jugador = nuevoJugador
    }
    
    method iniciarMenu(){
        // Configuración del juego
        game.title("gameGeneral")
        game.height(16)
        game.width(16)
        game.cellSize(64)

        // Mostrar la pantalla de inicio
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
        // Configuración del juego
        game.ground("fondo.png")
        pantallas.seleccion().removerVisual()
        game.addVisualCharacter(jugador)
    }
}