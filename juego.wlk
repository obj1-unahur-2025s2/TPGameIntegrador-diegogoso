import wollok.game.*
import pantallas.*
import clases.*
import direcciones.*
import hechizos.*
import enemigos.*
import personajes.*

object juego {
    var jugador = arquero
    const enemigos = [arania1, arania2, orco1, orco2]
   // const cantidadEnemigosMaxima = 6 //genera la cantidad de enemigos que le pases
   
    method jugador() = jugador

    method cambiarJugador(nuevoJugador) {
        jugador = nuevoJugador
    }
    
 /*   method generarEnemigo() {
            if (enemigos.size() < cantidadEnemigosMaxima) { 
                const enemigo = new Enemigo()
                enemigos.add(enemigo)
                game.addVisual(enemigo)
            }
        }
*/
  /*  method moverEnemigos() {
        enemigos.copy().forEach({ enemigo => enemigo.moverAleatoriamente() })   //O se puede hacer que persiga al jugador
    }
    
    method removerEnemigo(enemigo) {  //para cuando muere un enemigo. Lo remueve del juego y de la lista
        game.removeVisual(enemigo)
        enemigos.remove(enemigo)
    }
    */

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




    const arania1 = new Enemigo(
        image = "arania.png",
        vida = 2,
        poder = "telaarania.png"
    )
        const arania2 = new Enemigo(
        image = "arania.png",
        vida = 2,
        poder = "telaarania.png"
    )   
       const orco1 = new Enemigo(
        image = "orco.png",
        vida = 3,
        poder = "bolaOscura.png"
    )    const orco2 = new Enemigo(
        image = "orco.png",
        vida = 3,
        poder = "bolaOscura.png"
    )


//Creacion de los personajes



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
            if(not pantallas.inicio().hasVisual()){
               game.removeVisual(jugador)
               pantallas.inicio().agregarVisual() 
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
            const poder = new Hechizo()
            poder.lanzar(jugador)  
            game.onCollideDo(poder, {objetivo => objetivo.recibirAtaque()})
        })

    /*    // Generar enemigos cada cierto tiempo
        game.onTick(5000, "generarEnemigo", { self.generarEnemigo() })
        
        // Mover enemigos
        game.onTick(2000, "moverEnemigos", { self.moverEnemigos() })
           
    */
        enemigos.forEach({e => 
        game.addVisual(e)
        game.onCollideDo(e, {objetivo => objetivo.recibirAtaque()})
  
            game.onTick(2000, "mueve aleatoriamente", {e.moverAleatoriamente()
            e.lanzarAtaque() })
        })
      
    }
}
