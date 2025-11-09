# Red Water Mystery

## Equipo de desarrollo

* Augusto Morán
* Cristian Signorini
* Analía Rossotti
* Daiana Díaz
* Diego Goso
* Darío Robles
* Florencia Saharrea

## Capturas
![Pantalla Inicio](assets/capturas/inicio.png)
![Selección de Personajes](assets/capturas/seleccionPersonajes.png)
![Pantalla Nivel 1](assets/capturas/nivel1.png)
![Pantalla Final](assets/capturas/nivelFinal.png)
![Desarrolladores](assets/capturas/desarrolladores.png)


## Reglas de Juego / Instrucciones

**Objetivo**
El objetivo es sobrevivir a las hordas de enemigos (Arañas y Orcos) que aparecen en el mapa. Debes eliminarlos a todos usando el poder de tu personaje para poder avanzar de nivel y ganar el juego.

**Inicio del Juego**
1.  El juego comienza en una pantalla de inicio.
2.  Pasarás a una pantalla de **Selección de Personajes** donde podrás elegir entre cuatro héroes:
    * Guerrero
    * Arquero
    * Bárbaro
    * Mago
3.  Una vez seleccionado, comienza el Nivel 1.

**Controles**
* **Flechas (Arriba, Abajo, Izquierda, Derecha):** Mover a tu personaje por el mapa.
* **Barra Espaciadora:** Lanzar el poder especial de tu personaje (un proyectil de ataque).

**Mecánicas**
* **Vida:** Tu personaje comienza con 5 puntos de vida (según `clases.wlk`).
* **Ataque:** Al presionar "Espacio", lanzas un hechizo en la última dirección a la que te moviste.
* **Enemigos:** Los enemigos (Arañas y Orcos) aparecen en el mapa, se mueven aleatoriamente y lanzan sus propios proyectiles.
* **Daño:**
    * Si un proyectil enemigo te golpea, pierdes 1 punto de vida.
    * Si tu proyectil golpea a un enemigo, este pierde vida.
* **Game Over:** Si tu vida llega a 0, la partida termina (Game Over) y el juego se reinicia tras unos segundos.
* **Victoria:** Ganas el nivel cuando eliminas a todos los enemigos (`enemigosPorGenerar == 0` y `enemigos` está vacía).

## Otros

* **Curso/Facultad:** Programación Orientada a Objetos I - UNAHUR (Universidad Nacional de Hulingham)
* **Versión de wollok:** Wollok 1.0.2
* **Visibilidad:**
    * Queremos mantenerlo privado.