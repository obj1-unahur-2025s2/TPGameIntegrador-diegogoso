import wollok.game.*
import pantallas.*
import clases.*
import direcciones.*
import hechizos.*
import personajes.*

object juego {
    var enJuego = false
    var jugador = arquero
    const enemigos = []
    var aranias = 1
    var orcos = 2
    var enemigosPorGenerar = aranias + orcos
    var puedeAtacar = true

    method enJuego() = enJuego

    method puedeAtacar() = puedeAtacar

    method jugador() = jugador

    method cambiarJugador(nuevoJugador) {
        jugador = nuevoJugador
    }

    method generarArania() {
        const arania = new Arania(vida = 2, image= "arania.png")
        enemigos.add(arania)
        game.addVisualCharacter(arania)
        aranias = (aranias - 1).max(0)
    }

    method generarOrco() {
        const orco = new Orco(vida = 2, image= "orco.png")
        enemigos.add(orco)
        game.addVisualCharacter(orco)
        orcos = (orcos - 1).max(0)
    }

    method generarEnemigo() {
        if (enemigosPorGenerar > 0 and aranias > 0) {
            self.generarArania()
            enemigosPorGenerar = (enemigosPorGenerar - 1).max(0)
        }else if(enemigosPorGenerar > 0 and orcos > 0){  
            self.generarOrco()
            enemigosPorGenerar = (enemigosPorGenerar - 1).max(0)
        }
        // Remover tick cuando no hay más enemigos por generar
        if (enemigosPorGenerar == 0) {
            game.removeTickEvent("generarEnemigo")
        }
    }

    method moverEnemigos() {
        enemigos.forEach({ enemigo => if (enemigo.estaVivo()) { enemigo.moverAleatoriamente() } })
    }

    method atacarEnemigos() {
        enemigos.forEach({ enemigo =>
            if (!enemigo.estaVivo()) { return }
            // calcular dirección hacia el jugador y lanzar en esa dirección
            const jugadorObj = jugador
            const ataque = new Hechizo(esMalvado = true, image = enemigo.poder())
            if (jugadorObj != null) {
                const posJ = jugadorObj.position()
                const posE = enemigo.position()
                const dx = posJ.x() - posE.x()
                const dy = posJ.y() - posE.y()
                var absDx = dx
                if (absDx < 0) { absDx = -absDx }
                var absDy = dy
                if (absDy < 0) { absDy = -absDy }
                var direccion = este2
                if (absDx > absDy) {
                    if (dx > 0) { direccion = este2 } else { direccion = oeste2 }
                } else {
                    if (dy > 0) { direccion = norte2 } else { direccion = sur2 }
                }
                ataque.lanzarEnDireccion(enemigo, direccion)
            } else {
                ataque.lanzar(enemigo)
            }
            game.onCollideDo(ataque, { victima => victima.recibirAtaque(ataque) })
        })
    }

    method atacarJefe() {
        if (jefe.estaVivo()) {
            const bolaDeFuegoVerde = new BolaDeFuegoVerde(esMalvado = true, image = jefe.poder())
            const jugadorObj = jugador
            if (jugadorObj != null) {
                const posJ = jugadorObj.position()
                const posE = jefe.position()
                const dx = posJ.x() - posE.x()
                const dy = posJ.y() - posE.y()
                var absDx = dx
                if (absDx < 0) { absDx = -absDx }
                var absDy = dy
                if (absDy < 0) { absDy = -absDy }
                var direccion = este2
                if (absDx > absDy) {
                    if (dx > 0) { direccion = este2 } else { direccion = oeste2 }
                } else {
                    if (dy > 0) { direccion = norte2 } else { direccion = sur2 }
                }
                bolaDeFuegoVerde.lanzarEnDireccion(jefe, direccion)
            } else {
                bolaDeFuegoVerde.lanzar(jefe)
            }
            game.onCollideDo(bolaDeFuegoVerde, { victima => victima.recibirAtaque(bolaDeFuegoVerde) })
        }
    }

    method removerEnemigo(enemigo) {
        game.removeVisual(enemigo)
        enemigos.remove(enemigo)
        self.verificarPasoDeNivel()
    }

    method verificarPasoDeNivel() {
        const enemigosVivos = enemigos.filter({ e => e.estaVivo() })
        if (enemigosVivos.size() == 0) {
            game.removeTickEvent("moverEnemigos")
            game.removeTickEvent("atacarEnemigos")
            game.schedule(3000, {self.pasarDeNivel()})
        }
    }

    method pasarDeNivel() {
        pantallas.barraDeVida().removerVisual()
        game.removeVisual(jugador)
        pantallas.juego().removerVisual()
        pantallas.nivel2().agregarVisual()
         keyboard.enter().onPressDo{
            pantallas.nivel2().removerVisual()
            pantallas.juego().agregarVisual()
            pantallas.barraDeVida().agregarVisual()
            game.addVisualCharacter(jugador)
            jugador.restaurar()
            pantallas.barraDeVida().actualizarse(jugador)
            enemigos.clear()
            enemigos.add(jefe)
            game.addVisualCharacter(jefe)
            game.removeTickEvent("atacarEnemigos")
            game.onTick(2500, "moverJefe", { jefe.moverAleatoriamente() })
            game.onTick(3500, "atacarJefe", { self.atacarJefe() })
        }
    }

    method limpiarVisualesFinales() {
        game.clear() //limpia todo
        self.detenerEventos()
    }

    method detenerEventos() {
        enJuego = false
        game.removeTickEvent("generarEnemigo")
        game.removeTickEvent("moverEnemigos")
        game.removeTickEvent("atacarEnemigos")
        game.removeTickEvent("moverJefe")
        game.removeTickEvent("atacarJefe")
    }

    method finDelJuego() {
        if (!jefe.estaVivo()) {
            self.detenerEventos()
            pantallas.nivel2().removerVisual()
            
            // Mostrar anciano mago con mensaje de agradecimiento
            const posIntroduccion = game.at(7, 9)
            luzMagica.mostrar(posIntroduccion)
            game.schedule(800, { 
                luzMagica.desaparecer()
                ancianoMago.mostrar(posIntroduccion)
                game.say(ancianoMago, "¡Gracias por salvar a nuestro mundo!")
                
                // Esperar 6 segundos para que se lea el mensaje
                game.schedule(6000, {
                    ancianoMago.desaparecer()
                    luzMagica.mostrar(posIntroduccion)
                    
                    game.schedule(800, {
                        luzMagica.desaparecer()
                        
                        // Pausa de 1 segundo antes de mostrar victoria
                        game.schedule(1000, {
                            self.limpiarVisualesFinales()
                            pantallas.victoria().agregarVisual()
                            
                            // Esperar 7 segundos en pantalla victoria
                            game.schedule(7000, {
                                pantallas.victoria().removerVisual()
                                
                                // Pausa de 1 segundo antes de mostrar créditos
                                game.schedule(1000, {
                                    pantallas.creditos().agregarVisual()
                                    
                                    // Esperar 7 segundos en créditos antes de reiniciar
                                    game.schedule(7000, {
                                        pantallas.creditos().removerVisual()
                                        self.reiniciarJuego()
                                    })
                                })
                            })
                        })
                    })
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
                self.mostrarInstrucciones()
            }
        })

        keyboard.i().onPressDo({
            if (pantallas.seleccion().hasVisual()) {
                self.cambiarJugador(barbaro)
                self.mostrarInstrucciones()
            }
        })

        keyboard.o().onPressDo({
            if (pantallas.seleccion().hasVisual()) {
                self.cambiarJugador(guerrero)
                self.mostrarInstrucciones()
            }
        })

        keyboard.p().onPressDo({
            if (pantallas.seleccion().hasVisual()) {
                self.cambiarJugador(mago)
                self.mostrarInstrucciones()
            }
        })

        keyboard.q().onPressDo({
            if (!pantallas.inicio().hasVisual()) {
                self.reiniciarJuego()
            }
        })
    }

    method mostrarIntroduccion() {
        // Posición centro pero un poco más arriba en el tablero
        const posIntroduccion = game.at(7, 9)
        
        // T=0: Mostrar luz mágica inicial
        luzMagica.mostrar(posIntroduccion)
        
        // T=800ms: Luz desaparece y aparece anciano
        game.schedule(800, { luzMagica.desaparecer() })
        game.schedule(850, { 
            ancianoMago.mostrar(posIntroduccion)
            ancianoMago.mostrarIntroduccion()
        })
        
        // T=9350ms: Anciano desaparece y aparece luz (5 segundos más)
        game.schedule(9350, { ancianoMago.desaparecer() })
        game.schedule(9400, { luzMagica.mostrar(posIntroduccion) })
        
        // T=10150ms: Luz desaparece completamente
        game.schedule(10150, { luzMagica.desaparecer() })
    }

    method iniciar() {
        game.clear()
        enJuego = true
        puedeAtacar = true
        pantallas.seleccion().removerVisual()
        pantallas.juego().agregarVisual()
        pantallas.barraDeVida().agregarVisual()
        game.addVisualCharacter(jugador)
        pantallas.barraDeVida().actualizarse(jugador)
        
        // Mostrar introducción del anciano mago
        self.mostrarIntroduccion()
       
        keyboard.w().onPressDo({ jugador.moverseHacia(norte) })
        keyboard.s().onPressDo({ jugador.moverseHacia(sur) })
        keyboard.a().onPressDo({ jugador.moverseHacia(oeste) })
        keyboard.d().onPressDo({ jugador.moverseHacia(este) })
        keyboard.i().onPressDo({ self.mostrarInstrucciones() })
        //Reinicar el juego, durante la batalla
        keyboard.q().onPressDo({ if (!pantallas.inicio().hasVisual()) { self.reiniciarJuego() } })
        keyboard.j().onPressDo({
            if (game.hasVisual(jugador) and self.puedeAtacar() and self.enJuego()) {
                puedeAtacar = false
                const poder = new Hechizo(esMalvado = false)
                poder.lanzar(jugador)
                game.onCollideDo(poder, { victima => victima.recibirAtaque(poder) })
                game.schedule(1000,{puedeAtacar = true})
            }
        })

        if (enemigosPorGenerar > 0) {
            game.onTick(2000, "generarEnemigo", { self.generarEnemigo() })
        }
        
        // Sólo programar ticks de enemigos si hay enemigos por generar o ya hay enemigos
        if(self.enJuego() and (enemigosPorGenerar > 0 or enemigos.size() > 0)) {
            game.onTick(2500, "moverEnemigos", { self.moverEnemigos() })
            game.onTick(5000, "atacarEnemigos", { self.atacarEnemigos() })
        }
        
    }

    method mostrarInstrucciones() {
        pantallas.instrucciones().agregarVisual()
        game.schedule(4000, {
            pantallas.instrucciones().removerVisual()
            self.iniciar()
        })
    }

    method gameOver() {
        self.detenerEventos()
        self.limpiarVisualesFinales()
            //jefe.removerVisual()
            pantallas.gameOver().agregarVisual()
            game.schedule(4000, {
                pantallas.gameOver().agregarVisual()
                pantallas.creditos().agregarVisual()
                game.schedule(4000, {
                    self.reiniciarJuego()
                })
            })
    }

    method reiniciarJuego() {
        self.detenerEventos()
        game.clear()
        jefe.restaurar()
        jugador.restaurar()
        enemigos.clear()
        aranias = 1
        orcos = 2
        enemigosPorGenerar = aranias + orcos
        self.iniciarMenu()
    }

}