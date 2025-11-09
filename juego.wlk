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
    var aranias = 1
    var orcos = 1
    var enemigosPorGenerar = aranias + orcos
    var puedeAtacar = true

    method puedeAtacar() = puedeAtacar

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
        if (enemigosPorGenerar > 0 and aranias > 0) {
            self.generarArania()
            aranias -= 1
            enemigosPorGenerar = (enemigosPorGenerar - 1).max(0)
        }else if(enemigosPorGenerar>0 and orcos > 0){  self.generarOrco()
            orcos -= 1
            enemigosPorGenerar = (enemigosPorGenerar - 1).max(0)
        }
    }

    method moverEnemigos() {
        enemigos.copy().forEach({ enemigo => enemigo.moverAleatoriamente() })
    }

    method atacarEnemigos() {
        game.schedule(5000.randomUpTo(10000),{
            enemigos.forEach({ enemigo =>
            const ataque = new Hechizo(esMalvado = true, image = enemigo.poder())
            ataque.lanzar(enemigo)
            game.onCollideDo(ataque, { objetivo => objetivo.sacarVida(1) })
            })
        })
    }

    method removerEnemigo(enemigo) {
        game.removeVisual(enemigo)
        enemigos.remove(enemigo)
        self.verificarPasoDeNivel()
    }

    method verificarPasoDeNivel() {
        const enemigosVivos = enemigos.filter({ e => e.estaVivo() })
        if (enemigosVivos.size() == 0) {
            self.pasarDeNivel()
        }
    }

    method pasarDeNivel() {
        pantallas.barraDeVida().removerVisual()
        game.removeVisual(jugador)
        pantallas.juego().removerVisual()
        pantallas.nivel2().agregarVisual()
        game.schedule(4000, {
            pantallas.nivel2().removerVisual()
            pantallas.juego().agregarVisual()
            pantallas.barraDeVida().agregarVisual()
            game.addVisualCharacter(jugador)
            jugador.darVida()
            game.addVisualCharacter(jefe)
            enemigos.add(jefe)
        })
    }

    method limpiarVisualesFinales() {
        pantallas.barraDeVida().removerVisual()
        game.removeVisual(jugador)
        game.removeVisual(jefe)
        self.detenerEventos()
        pantallas.juego().removerVisual()
    }

    method detenerEventos() {
        game.removeTickEvent("generarEnemigo")
        game.removeTickEvent("moverEnemigos")
        game.removeTickEvent("atacarEnemigos")
    }

    method finDelJuego() {
        if (!jefe.estaVivo()) {
            self.limpiarVisualesFinales()
            pantallas.victoria().agregarVisual()
            game.schedule(4000, {
                pantallas.victoria().removerVisual()
                pantallas.creditos().agregarVisual()
                game.schedule(8000, {
                    pantallas.creditos().removerVisual()
                    self.reiniciarJuego()
                })
            })
        }
    }

    method iniciarMenu() {
        pantallas.inicio().agregarVisual()

        keyboard.enter().onPressDo({
            if (pantallas.inicio().hasVisual()) {
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
            if (!pantallas.inicio().hasVisual()) {
                self.reiniciarJuego()
            }
        })
    }

    method iniciar() {
        pantallas.seleccion().removerVisual()
        pantallas.juego().agregarVisual()
        pantallas.barraDeVida().agregarVisual()
        game.addVisualCharacter(jugador)

        keyboard.w().onPressDo({ jugador.moverseHacia(norte) })
        keyboard.s().onPressDo({ jugador.moverseHacia(sur) })
        keyboard.a().onPressDo({ jugador.moverseHacia(oeste) })
        keyboard.d().onPressDo({ jugador.moverseHacia(este) })

        keyboard.j().onPressDo({
            if (game.hasVisual(jugador) and self.puedeAtacar()) {
                puedeAtacar = false
                const poder = new Hechizo(esMalvado = false)
                poder.lanzar(jugador)
                game.onCollideDo(poder, { enemigo => enemigo.recibirAtaque(poder) })
                game.schedule(2000,{ puedeAtacar = true})
            }
        })

        if (enemigosPorGenerar > 0) {
            game.onTick(1000, "generarEnemigo", { self.generarEnemigo() })
        }

        game.onTick(1500, "moverEnemigos", { self.moverEnemigos() })
        game.onTick(4000, "atacarEnemigos", { self.atacarEnemigos() })
    }

    method gameOver() {
        self.limpiarVisualesFinales()
        pantallas.gameOver().agregarVisual()
        game.schedule(4000, {
            self.reiniciarJuego()
        })
    }

    method reiniciarJuego() {
        enemigos.clear()
        aranias = 1
        orcos = 1
        enemigosPorGenerar = aranias + orcos
        self.detenerEventos()
        game.clear()
        self.iniciarMenu()
    }
}