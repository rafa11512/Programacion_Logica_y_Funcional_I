# Actividad. Laberinto

//Laberinto
| 👤 | 1   |    |     |     |     |    |    |
|-----------|-----------|-----------|-----------|-----------|-----------|-----------|-----------|
|    | 1    |    | 1  | 1  |    | 1   |    |
|    | 1    | 1  | 1  | 1  |    | 1   |    |
|    |      |    |    | 1  |    | 1   |    |
|    | 1    |    | 1  | 1  |    | 1   |    |
|    | 1    |    |    |    |    | 1   | 🚪 |

- 1; Pared/Obstaculo
- 0; Libre

### definiciones (main)
-  Definimos la matriz `laberinto` que sera el laberinto 
  -  donde 0 representa un camino que podemos seguir y 1 una pared u obstaculo
-  Coordenadas:
  -  El punto final `(destinoX, destinoY)` -> (n-1, n-1) donde n es el tamaño de la matriz
  -  EL punto de inicio `(inicialX, inicialY)` -> (0, 0)
-  Llama a la función resolver proporcioandole el "laberinto, el punto de inicio (0, 0), la meta y una lista vacia para almacenar la rutas exitosa"
  -  si la funcion resolver devuelve true, se imprime la lista con los caminos validos

### funcion resolver
- **Caso Base**; Si la posicion actual esta fuera de los limites de la matriz o choca con una pared (1), la funcion aborta ese camino devolviendo false
- **Registro y Meta**: Si la celda es valida
  - se guarda en la lista camino
  - inmediatamente verifica si es la meta final 
    - de ser asi, devuelve true siendo un exito
- **Marcaje temporal**: Para no caer en ciclos infinitos, en el codigo usa un truco donde se convierte la celda actual en una pared temporal (`lab[y][x] = 1`)
- **Buqueda por direcciones (->, Abajo, <-, Arriba)**: Se utiliza el operador || (O) para intentar moverse:
    -  a la derecha `(x+1, y)`
    -  bajo `(x, y+1)`
    -  izquierda `(x-1, y)`
    -  arriba `(x, y-1)`
  -  Y si una dirección encuentra la salida, las demas se ignoran
- **Backtracking (El Retroceso)**: Si las cuatro direcciones devuelven false, el explorador llego a un callejon sin salida
  - Aqui deshace sus pasos:
    - restaura la celda a camino libre (0), y borra esa coordenada de la lista y retrocede
### funcion imprimir lista de caminos
- Con una condicional para verifiacion un true o false de la funcion verificar, con true imprimimos la lista de caminos (y,x)
  - recibe un indice i que comienza en 0
  - el indice crecera de 0 al tamaño total de la lisa de caminos
  - imprimira la posicion (i) de la listade caminos
  - cuando el indice (i) imprimica y alcance el numero total de la lista de caminos se imprimira un mensaje de finalizacion

---
```java
import java.util.ArrayList;
import java.util.List;

public class Tarea4Laberinto {

    public static void main(String[] args) {
        int[][] laberinto = {
            {0, 1, 0, 0, 0, 0, 0, 0},
            {0, 1, 0, 1, 1, 0, 1, 0},
            {0, 1, 1, 1, 1, 0, 1, 0},
            {0, 0, 0, 0, 1, 0, 1, 0},
            {0, 1, 0, 1, 1, 0, 1, 0},
            {0, 1, 0, 0, 0, 0, 1, 0}
        };

        List<int[]> camino = new ArrayList<>();
        
        //punto final
        int destinoX = laberinto[0].length - 1; //7
        int destinoY = laberinto.length - 1; //5
        //punto inicial
        int inicialX = 0;
        int inicialY = 0;

        //punto de partida: 0,0
        if (resolver(laberinto, inicialX, inicialY, destinoX, destinoY, camino)) {
            imprimir(camino, 0);
        } else {
            System.out.println("el laberinto no tiene solucion");
        }
    }

    static boolean resolver(int[][] lab, int x, int y, int destX, int destY, List<int[]> cam) {

        //casos de error (fuera de limites o choca con pared/visitado)
        if (y < 0 || x < 0 || y >= lab.length || x >= lab[0].length || lab[y][x] == 1) {
            return false;
        }

        cam.add(new int[]{x, y}); // agregamos a la lista decaminos
        
        if (x == destX && y == destY) {
            return true; //meta
        }
        
        lab[y][x] = 1; //marcamos como visitado (1) -> convirtiendolo en pared

        //1 - llamadas usando OR (||), si alguna es true, retorna true
        // de izquierda a derecha (irecciones: derecha, abajo, izquierda, arriba)
        if (resolver(lab, x + 1, y, destX, destY, cam)
                || resolver(lab, x, y + 1, destX, destY, cam)
                || resolver(lab, x - 1, y, destX, destY, cam)
                || resolver(lab, x, y - 1, destX, destY, cam)) {
            return true;
        }
        // 2 - el Backtracking, solo si es f 
        lab[y][x] = 0; //restauramos la celda a camino libre
        cam.remove(cam.size() - 1);
        return false;
    }

    //imprimir la lista de pasos del laberrinto
    static void imprimir(List<int[]> cam, int i) {
        if (i == cam.size()) {
            System.out.println("fin del laberinto");
            return;
        }
        System.out.println("Paso " + i + ": (" + cam.get(i)[0] + ", " + cam.get(i)[1] + ")");
        imprimir(cam, i + 1);
    }
}

```
---