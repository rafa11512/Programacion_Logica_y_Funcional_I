# Practica: Chatbot Eliza en SWI-Prolog y Ampliacion de la Base de Conocimientos

---

### ¿Que es y como funciona `eliza.pl`?

El archivo `eliza.pl` es una implementacion didactica del chatbot Eliza escrita en **Prolog** (Programming in Logic). A diferencia de los lenguajes imperativos (como C, Python o Java) donde se programan algoritmos paso a paso con bucles `while` y condicionales `if/else`, en Prolog el bot opera mediante **reglas logicas, unificacion de terminos, listas y recursion**.

### El "Efecto Eliza"
Aunque Eliza no poseia comprension semantica real ni conciencia de lo que leia, muchas personas que interactuaban con ella le atribuian emociones, empatia y una inteligencia genuina, o llegaban a creer quehablaban con un niño. A este fenomeno psicológico, donde los seres humanos asumen equivocadamente que una maquina tiene intenciones o comprension consciente detras de patrones de texto, se le conoce formalmente como el **Efecto Eliza**.

----

#### Estructura de la Base de Conocimientos: `template/3`
Cada regla de respuesta en Eliza se modela como un hecho con el predicado `template/3`:
$$\text{template}(\text{PatrónEstímulo}, \text{PatrónRespuesta}, \text{ListaÍndices}).$$

Por ejemplo:
```prolog
template([estoy, jugando, s(_)], [que, tal, esta, 0, '?', vale, la, pena, probarlo], [2]).
```
1. **Patron de Estimulo (`Stim`):** Lista con las palabras esperadas. El termino `s(_)` representa una variable o comodin que capturara cualquier palabra en esa posicion.
2. **Patron de Respuesta (`Resp`):** Lista con las palabras que dirá Eliza. Los números `0, 1, 2...` representan marcadores de posicion donde se insertaran las palabras capturadas.
3. **Lista de Indices (`IndStim`):** Lista con las posiciones (comenzando en 0) de la entrada de donde se debe extraer la palabra para colocarla en el marcador `0`, `1`, etc. En el ejemplo, `[2]` indica que la palabra en el indice 2 de la entrada (`s(_)`) reemplazara al `0` de la respuesta.

---

## Ejercicio. 20 Templates

20 saludos/preguntas, predicados que tiengan la estructura del template sin usar flags como flagLike/flagDo/flagIs)

``` prolog
template([que, piensas, de, gears, of, war], ['oh hablas del mejor juego del mundo'], []).

template([estoy, jugando, s(_)], [que, tal, esta, 0, '?', vale, la, pena, probarlo], [2]).

template([como, estas], ['muy bien y lista para ayudarte en lo que necesites'], []).

template([que, es, programacion], ['la programacion es una disciplina que se ocupa de diseñar y construir software'], []).

template([dame, una, lista, de, videojuegos], [estos, son, unos, buenos, videojeugos, recomendados, ':', '\n', '- ', gears, of, war, '\n', '- ', elden, ring], []).

template([eres, una, persona, real, '?'], ['no soy una entidad humana sino un programa de procesamiento de texto'], []).

template([quiero, un, cafe],['un buen cafe bien cargado siempre ayuda a revivir el dia'], []).

template([que, pelicula, me, recomiendas, '?'], ['te recomiendo interestelar o el club de la pelea son buenisimas'], []).

template([no, se, que, hacer], ['empieza por lo mas facil que tengas pendiente y de ahi vas avanzando'], []).

template([compre, un, s(_)], [que, chido, y, que, tal, te, ha, funcionado, tu, 0, '?'], [2]).

template([tengo, examen, de, s(_)], [estudia, con, calma, los, temas, clave, y, te, ira, muy, bien, en, 0], [3]).

template([no, compila, mi, codigo], ['revisa los puntos y comas o los parentesis suele ser un error de sintaxis'], []).

template([estoy, aprendiendo, s(_)], [es, un, tema, muy, util, que, es, lo, que, mas, te, ha, costado, de, 0, '?'], [2]).

template([mi, comida, favorita, es, s(_)], [que, rico, donde, preparan, el, mejor, 0, de, tu, ciudad, '?'], [4]).

template([no, tengo, dinero], ['es momento de recortar gastos hormiga y aguantar a la quincena'], []).

template([no, puedo, dormir], ['apaga el celular un rato antes y toma un vaso con agua'], []).

template([hace, demasiado, calor], ['toma mucha agua y busca un ventilador porque el sol esta bravo'], []).

template([hace, mucho, frio], ['abrigate con una buena chamarra y preparate un chocolate caliente'], []).

template([estoy, muy, aburrido], ['ponte a jugar algo o sal a dar una vuelta para despejarte'], []).

template(['?'], ['---- guia de uso de eliza ----',
'\n', '- "como estas" : para respuesta ',
'\n', '- "te gustan las [texto] ?" : para respuesta usando flagLike',
'\n', '- "Adios." Para salir del sistema'], []).
```
