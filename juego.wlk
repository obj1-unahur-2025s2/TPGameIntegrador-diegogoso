import wollok.game.*
import pantallas.*
import clases.*
import direcciones.*
import hechizos.*
import enemigos.*
import personajes.*

object juego {
    var jugador = arquero
    const enemigos = []
    var enemigosPorGenerar = aranias + orcos // genera la cantidad de enemigos que le pases
    const aranias = 1
    const orcos = 1

    method jugador() = jugador

    method cambiarJugador(nuevoJugador) {
        jugador = nuevoJugador
    }

    method generarArania() {
        enemigos.add(arania)
        game.addVisualCharacter(arania)
    }

    method generarOrco() {
        enemigos.add(orco)
        game.addVisualCharacter(orco)
    }

    method generarEnemigo() {
        if (enemigosPorGenerar > 0) { 
            self.generarArania()
            enemigosPorGenerar = (enemigosPorGenerar - 1).max(0)
            self.generarOrco()
            enemigosPorGenerar = (enemigosPorGenerar - 1).max(0)
        } 
    }

    method moverEnemigos() {
        enemigos.copy().forEach({ enemigo => enemigo.moverAleatoriamente() })   // O se puede hacer que persiga al jugador
    }

    method atacarEnemigos() {
        enemigos.forEach({ enemigo =>
            const ataque = new Hechizo(esMalvado = true)
            ataque.lanzar(enemigo)
            game.onCollideDo(ataque, {objetivo => objetivo.recibirAtaque(ataque)})
        })
    }

    method removerEnemigo(enemigo) {
        game.removeVisual(enemigo) // Lo saca de la pantalla
        enemigos.remove(enemigo)   // Lo saca de la lista de enemigos
        self.verificarPasoDeNivel()
    }

    method verificarPasoDeNivel() {
        // Consideramos enemigos "vivos" aquellos que existen en la lista y su método estaVivo() devuelve true
        const enemigosVivos = enemigos.filter({ e => e.estaVivo() })
        if (enemigosVivos.size() == 0) {
            self.pasarDeNivel()
        } 
    }

    method pasarDeNivel() {
        // Cambia el fondo actual por el fondo del nivel 2 (jefe)
        pantallas.barraDeVida().removerVisual()
        game.removeVisual(jugador)
        pantallas.juego().removerVisual()
        pantallas.nivel2().agregarVisual()
        game.schedule(4000, {
            pantallas.nivel2().removerVisual()
            pantallas.juego().agregarVisual()
            pantallas.barraDeVida().agregarVisual()
            game.addVisualCharacter(jugador)
            game.addVisualCharacter(jefe)
            enemigos.add(jefe)
        })
    }

    method finDelJuego() {
        if (!jefe.estaVivo()) {
            // Si el jefe murió, termina el juego
            pantallas.barraDeVida().removerVisual()
            game.removeVisual(jugador)
            pantallas.juego().removerVisual()
            pantallas.victoria().agregarVisual()
            game.schedule(2000, {
                pantallas.creditos().agregarVisual()
            })
            game.schedule(4000, {
                self.reiniciarJuego()
            })
        }
    }

    method iniciarMenu() {
        pantallas.inicio().agregarVisual()

        keyboard.enter().onPressDo({
            if (pantallas.inicio().hasVisual()){
                pantallas.inicio().removerVisual()
                pantallas.seleccion().agregarVisual()
            }
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

        keyboard.q().onPressDo({
            if(!pantallas.inicio().hasVisual()){
               game.removeVisual(jugador)
               pantallas.inicio().agregarVisual() 
            }
        })
    }

    method iniciar() {
        pantallas.seleccion().removerVisual()
        pantallas.juego().agregarVisual()
        pantallas.barraDeVida().agregarVisual()
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
            if(game.hasVisual(jugador)) {
                const fuego = new Fuego(esMalvado = false)
                fuego.lanzar(jugador)  
                game.onCollideDo(fuego, { enemigo =>
                    enemigo.recibirAtaque(fuego)
                })
            }
        })

        // Generar enemigos cada cierto tiempo
        if(enemigosPorGenerar > 0) {
            game.onTick(1000, "generarEnemigo", { self.generarEnemigo() })
        }
        
        // Mover enemigos
        game.onTick(1500, "moverEnemigos", { self.moverEnemigos() })
        
        // que lancen su poder
        game.onTick(4000, "atacarEnemigos", { self.atacarEnemigos() })
    }

    method gameOver() {
        pantallas.barraDeVida().removerVisual()
        game.removeVisual(jugador)
        pantallas.juego().removerVisual()
        pantallas.gameOver().agregarVisual()
        game.schedule(4000, {
            self.reiniciarJuego()
        })
    }

    method reiniciarJuego() {
        // Limpiamos enemigos y removemos la visual del jugador actual antes de
        // reasignar la referencia `jugador` a la instancia por defecto.
        enemigos.clear()
        game.removeVisual(jugador)
        jugador = arquero
        pantallas.barraDeVida().removerVisual()
        pantallas.juego().removerVisual()
        // Volvemos al menú. No llamamos a `game.stop()` porque detener el motor
        // impide que `game.addVisualCharacter(jugador)` funcione correctamente
        // al reiniciar (el engine ya no procesa nuevas visuales).
        self.iniciarMenu()
    }
}