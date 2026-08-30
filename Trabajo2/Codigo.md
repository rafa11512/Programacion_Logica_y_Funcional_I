# Ejercicio 2. Validacion de Parentesis con pilas en java

### Validar el numero de parentesis de cierre y de apretura "()", si son correctos y este bien escrita la expresion, usando pilas.

### - Ejemplo: "((()()))(())()" es correcto, "(()))(()" es incorrecto

### Explicacion de la validacion
Para saber si los parentesis estan bien escritos, usando pilas:
1. **Si encontramos un '(' de apertura;** lo guardamos en la pila (**push**)
2. **Si encontramos un ')' de cierre;** verificamos lo siguiente:
   - **a.** si la pila esta vacia, significa que hay un ')' de cierre sin '(' de apertura correspondiente, es incorrecto (**false**).
   - **b.** si la pila tiene elementos, sacamos el '(' de apertura superior de la pila, formando el "()" (**pop**)
3. **Validacion final:**
   - Esta vacia la pila? **si** --> Correcto (**true**), todos los parentesis se cerraron en orden
   - Esta vacia la pila? **no** --> Incorrecto (**false**), quedaron parentesis abiertos sin cerrar

```java

package prolog;

import java.util.ArrayDeque;
import java.util.Deque;

public class Tarea2 {

    public static void main(String[] args) {

        String expresion = "((())()";
        char[] parentesis = expresion.toCharArray();

        if (validacion(parentesis) == true) {
            System.out.println("La expresion: " + expresion + " es correcta");
        } else {
            System.out.println("La expresion: " + expresion + " es incorrecta");
        }

    }

    public static boolean validacion(char[] parentesis) {
        Deque<Character> pila = new ArrayDeque<>();

        for (int i = 0; i < parentesis.length; i++) {
            if (parentesis[i] == '(') {
                pila.push(parentesis[i]);
            }
            if (parentesis[i] == ')') {
                if (pila.isEmpty() == true) {
                    return false; //parentesis de cierre sin parentesis de apertura, al inicio de la pila
                }
                pila.pop();
            }
        }

        boolean valida = pila.isEmpty();
        if (valida == true) { // si la pila esta vacia
            return true; //correcta
        } else {
            return false; //false, error
        }

    }

}

```