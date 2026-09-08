# Actividad. Matriz llenada con Trominos (Teselas)

| 3  | 3  |  4 |  4 |   |   |   |   |
|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
| 3 |   2  | 2  | 4  |   |   |  |   |
| 5 |   2  | 6  | 6  |  |   |  |  |
| 5 |  5   |  6 | 1  | 1 |  |   |  |
|  |**X**|   |   | 1 |  |  |  |
|  |     |  |  |  |  |  |  |
|  |     |  |  |  |  |  |  |
|  |     |  |  |  |  |  |  |

X; Hueco / Cuadro prohibido inicial (-1)

Números (1, 2, 3...); Cada número representa una pieza en forma de "L" de 3 cuadritos (Trominos).

### definicion (main)
* Definimos la matriz que sera nuestro tablero
  * el tamaño siempre debe ser cuadrado y multiplo de potencias de 2 (ej. 2x2, 4x4, 8x8)
* Coordenadas:
  * El punto de inicio del cuadrito vacio (filaHueco, colHueco) -> Puede ser cualquier coordenada al azar (ej. 2, 1)
  * Marcamos ese hueco inicial en el tablero con un -1 (que al imprimir sera una "X")
* Llama a la funcion principal llenarMatriz y le proporcionamos el tamaño total del tablero, la coordenada inicial (0,0) desde donde empieza a escanear, y la posicion de nuestro hueco 

### funcion llenarMatriz (resolver)
* Caso Base; Si el tablero a revisar es de solo 2x2, como ya tiene un hueco adentro, una sola pieza en forma de L encajara perfectamente en los 3 espacios vacoos, por lo que solo la coloca y termina
* Division del mapa (es el divide y venceras): Si el tablero es grande, el explorador lo corta por la mitad en forma de cruz, creando 4 cuadrntes mas pequeños 
* El Truco del Centro: Como cortamos el mapa en 4, el "Hueco" original se quedo atrapado en solo uno de los cuadrantes. Donde los otros 3 estan vacios
  * Para arreglarlo, colocamos una pieza central (en el ejemplo de arriba es la pieza 1) justo en el medio del tablero grande 
  * Las 3 puntas de esta pieza central caen en los 3 cuadrantes limpios, sirviendo como un "nuevo hueco falso" para cada uno 
* Busqueda por cuadrantes: El codigo revisa (usando if-else):
  * ¿El hueco original esta arriba a la izquierda? Si no, le pone una punta de la pieza central
  * ¿Esta arriba a la derecha? Si no, le pone una punta, y asi con los cuatro cuadrantes
* **Recursividad** (El bucle de repeticion): Ahora que los 4 cuadrantes tienen exactamente 1 hueco (uno real y tres falsos), el programa se llama a si mismo 4 veces para resolver cada cuadranre como si fuera un rompecabezas nuevo

### funcion imprimir (matriz)
* Recorre todo el tablero fila por fila y columna por columna con un doble ciclo (for)
  * Utiliza una condicional: si encuentra el valor -1, imprime una letra "X" para representar el hueco inicial
  * Si encuentra cualquier otro numero se imprime el identificador numerico de la tesela, acomodandolo para que se vea una cuadricula ordenada
  * Al terminar de imprimir una fila entera da un salto de linea para empezar a imprimir la de abajo

---
```java
public class Tarea5Matriz {

    private static int[][] matriz;
    private static int idTesela = 1;

    public static void main(String[] args) {
        
        int dimension = 8; //siempre debe ser 2^n x 2^n
        matriz = new int[dimension][dimension];

        //hueco (fila, columna)
        int filaHueco = 4;
        int colHueco = 1;
        matriz[filaHueco][colHueco] = -1; //X

        //origen (0,0)
        llenarMatriz(dimension, 0, 0, filaHueco, colHueco);

        imprimirMatriz(dimension);
    }

    public static void llenarMatriz(int lado, int filaInicio, int colInicio, int filaHueco, int colHueco) {
        
        //CASO BASE, si es un tablero de 2x2
        if (lado == 2) {
            int teselaActual = idTesela++;
            for (int i = 0; i < 2; i++) {
                for (int j = 0; j < 2; j++) {
                    //ponemos la pieza en los 3 espacios que NO son el hueco
                    if (!(filaInicio + i == filaHueco && colInicio + j == colHueco)) {
                        matriz[filaInicio + i][colInicio + j] = teselaActual;
                    }
                }
            }
            return;
        }

        //calculamos donde esta la mitad del cuadrante actual
        int mitad = lado / 2;
        int filaCentro = filaInicio + mitad;
        int colCentro = colInicio + mitad;

        //la pieza que ira en el medio para unir los cuadrantes
        int teselaCentral = idTesela++;

        //hueco de cada uno de los 4 sub cuadrantes
        int huecoFilaSupIzq, huecoColSupIzq;
        int huecoFilaSupDer, huecoColSupDer;
        int huecoFilaInfIzq, huecoColInfIzq;
        int huecoFilaInfDer, huecoColInfDer;

        //============= Cuadrante Superior Izquierdo
        if (filaHueco < filaCentro && colHueco < colCentro) {
            huecoFilaSupIzq = filaHueco;
            huecoColSupIzq = colHueco; //el hueco original ya estaba aqui
        } else {
            matriz[filaCentro - 1][colCentro - 1] = teselaCentral; //ponemos punta de la L
            huecoFilaSupIzq = filaCentro - 1;
            huecoColSupIzq = colCentro - 1;    //este es su nuevo hueco
        }

        //============= Cuadrante Superior Derecho
        if (filaHueco < filaCentro && colHueco >= colCentro) {
            huecoFilaSupDer = filaHueco;
            huecoColSupDer = colHueco;
        } else {
            matriz[filaCentro - 1][colCentro] = teselaCentral;
            huecoFilaSupDer = filaCentro - 1;
            huecoColSupDer = colCentro;
        }

        //============= Cuadrante Inferior Izquierdo
        if (filaHueco >= filaCentro && colHueco < colCentro) {
            huecoFilaInfIzq = filaHueco;
            huecoColInfIzq = colHueco;
        } else {
            matriz[filaCentro][colCentro - 1] = teselaCentral;
            huecoFilaInfIzq = filaCentro;
            huecoColInfIzq = colCentro - 1;
        }

        //============= Cuadrante Inferior Derech
        if (filaHueco >= filaCentro && colHueco >= colCentro) {
            huecoFilaInfDer = filaHueco;
            huecoColInfDer = colHueco;
        } else {
            matriz[filaCentro][colCentro] = teselaCentral;
            huecoFilaInfDer = filaCentro;
            huecoColInfDer = colCentro;
        }

        //llamada para cada cuadrante
        llenarMatriz(mitad, filaInicio, colInicio, huecoFilaSupIzq, huecoColSupIzq);
        llenarMatriz(mitad, filaInicio, colCentro, huecoFilaSupDer, huecoColSupDer);
        llenarMatriz(mitad, filaCentro, colInicio, huecoFilaInfIzq, huecoColInfIzq);
        llenarMatriz(mitad, filaCentro, colCentro, huecoFilaInfDer, huecoColInfDer);
    }

    private static void imprimirMatriz(int n) {
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                if (matriz[i][j] == -1) {
                    System.out.printf("%4s", "X"); //el hueco inicial
                } else {
                    System.out.printf("%4d", matriz[i][j]); // imprimimos los id de cada tesela
                }
            }
            System.out.println();
        }
    }
}
```
---