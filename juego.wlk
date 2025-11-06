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
    var cantidadEnemigosPorGenerar = 3 // genera la cantidad de enemigos que le pases

    method jugador() = jugador

    method cambiarJugador(nuevoJugador) {
        jugador = nuevoJugador
    }
    
    method generarEnemigo() {
        if (cantidadEnemigosPorGenerar > 0) { 
            const enemigo = new Arania(
                position = game.at(0.randomUpTo(game.width()), 0.randomUpTo(game.height())),
                image = "arania.png",
                vidasRestantes = 3
            )
            enemigos.add(enemigo)
            game.addVisualCharacter(enemigo)
            cantidadEnemigosPorGenerar = (cantidadEnemigosPorGenerar - 1).max(0)
        } 
    }


    method moverEnemigos() {
        enemigos.copy().forEach({ enemigo => enemigo.moverAleatoriamente() })   // O se puede hacer que persiga al jugador
    }
    
    method removerEnemigo(enemigo) {  //para cuando muere un enemigo. Lo remueve del juego y de la lista
        game.removeVisual(enemigo)
        enemigos.remove(enemigo)
        // Verificar si ya no quedan enemigos y pasar al nivel del jefe
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
<<<<<<< Updated upstream
        game.schedule(1000, {
            game.removeVisual(jugador)
            pantallas.juego().removerVisual()
            pantallas.nivel2().agregarVisual()
        })
        
=======
        game.removeVisual(jugador)
        pantallas.juego().removerVisual()
        pantallas.nivel2().agregarVisual()        
>>>>>>> Stashed changes
        game.schedule(4000, {
            pantallas.nivel2().removerVisual()
            pantallas.juego().agregarVisual()
            game.addVisualCharacter(jefe)
            game.addVisualCharacter(jugador)
        })
    }


    /*method verificarPasoDeNivel() { // agregar desde aca hasta la linea 36
       const enemigosVivos = enemigos.filter({e => e.vida > 0})
       
        if (enemigosVivos.size() <= 0) {
            self.pasarDeNivel()
        }
    }
    method pasarDeNivel() {
    game.stop()  // Pausa el juego 3 segundos maso para que se vea el mensaje

    pantallas.juego().removerVisual()
    pantallas.nivel2().agregarVisual()
    pantallas.mensajeNivel2().agregarVisual()

    game.schedule(2000, {
        pantallas.mensajeNivel2().removerVisual()
        game.start()  // Reactiva el juego
    })
    // se puede agregar nuevos enemigos, cambiar el jugador, mostrar mensaje, si quieren
    }*/ //hasta aca agregar



/*  ESTO NO IRIA MAS, HICE QUE GENERE LA CANTIDAD QUE LE PASES Y NO HAGA FALTA HACER CADA OBJETO DE MANEAR MANUAL
    const arania = new Enemigo(
        position = game.at (12,13),
        image = "arania.png",
        vida = 5
    )
*/

//Creacion de los personajes


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

    method iniciarMenu() {
        game.title("gameGeneral")
        game.height(16)
        game.width(16)
        game.cellSize(64)

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

        keyboard.x().onPressDo({
            self.pasarDeNivel()
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
            
            game.onCollideDo(fuego, { elemento =>
                elemento.recibirAtaque(fuego)
            })
        })

        // Generar enemigos cada cierto tiempo


        game.onTick(5000, "generarEnemigo", { self.generarEnemigo() })

        

        
        // Mover enemigos
        game.onTick(2000, "moverEnemigos", { self.moverEnemigos() })

        game.onTick(6000, "verificarPasoDeNivel", { self.verificarPasoDeNivel() })

        
           
        /*
        enemigos.forEach({e => 
        game.addVisual(e)
            game.onTick(2000, "mueve aleatoriamente", {e.moverAleatoriamente() })
        })*/
      
    }
}
