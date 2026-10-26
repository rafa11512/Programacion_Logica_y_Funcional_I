# Investigacion: Variables y Constantes de Individuo en Programación Lógica y Prolog

---

## 1. Introducción y Fundamentos Lógicos

La **Programación Lógica** descansa sobre las bases formales del cálculo de predicados de la **Lógica de Primer Orden (LPO)**. Dentro de este paradigma, el objetivo es representar y razonar acerca de un conjunto de objetos definidos en un entorno particular denominado **Dominio del Discurso** ($D$).

Para poder enunciar propiedades y relaciones sobre los objetos de este dominio, el lenguaje lógico divide los términos de individuo en dos categorías elementales:
* **Constantes de individuo:** Símbolos fijos que nombran de manera unívoca a un elemento concreto y determinado.
* **Variables de individuo:** Símbolos auxiliares que representan a cualquier individuo arbitrario o indeterminado perteneciente al dominio.

En lenguajes de programación declarativos como **Prolog**, esta distinción teórica no solo se conserva, sino que define directamente la sintaxis del lenguaje, determinando cómo se estructuran las bases de conocimiento y cómo se ejecuta el motor de inferencia.

---

## 2. Constantes de Individuo

### Concepto Teórico
Una **constante de individuo** (denotada usualmente en lógica matemática con letras minúsculas iniciales del alfabeto: $a, b, c$ o nombres propios) representa un objeto singular del dominio cuyo valor o referencia no cambia a lo largo de la evaluación. 

Por ejemplo, si el dominio son los cuerpos celestes, la constante $t$ puede representar "la Tierra". La asignación es fija y rígida.

### Implementación en Prolog
En Prolog, las constantes forman parte de los términos atómicos simples y se subdividen en:

1. **Átomos:**
   * Cadenas que inician obligatoriamente con **letra minúscula**:
     ```prolog
     tierra.
     sol.
     pedro.
     libro.
     ```
   * Cadenas delimitadas por comillas simples (`'...'`), necesarias si contienen espacios, mayúsculas o caracteres especiales:
     ```prolog
     'Don Quijote de la Mancha'.
     'Biblioteca Central'.
     ```
   * Símbolos predefinidos u operadores: `+`, `-`, `:-`, `;`.

2. **Números:**
   * Constantes numéricas, tanto enteros como flotantes:
     ```prolog
     10000.
     3.1416.
     -5.
     ```

---

## 3. Variables de Individuo

### Concepto Teórico
Una **variable de individuo** (denotada clásicamente como $x, y, z$) representa una posición vacía o marcador de posición que puede instanciarse con cualquier objeto del dominio. 

Su semántica proviene de la cuantificación:
* **Universal ($\forall x$):** La afirmación es válida para cualquier constante que sustituya a $x$.
* **Existencial ($\exists x$):** Existe al menos una constante en el dominio que al sustituir a $x$ hace verdadera la expresión.

### Implementación en Prolog
En Prolog, las variables tienen las siguientes características fundamentales:

1. **Sintaxis estricta:**
   * Comienzan siempre con una **letra Mayúscula** o con un carácter de **guión bajo** (`_`):
     ```prolog
     X
     Persona
     Libro_Prestado
     _resultado
     ```

2. **Estados de una variable:**
   * **Libre (Unbound):** No contiene ningún valor ni apunta a ningún objeto.
   * **Ligada (Bound):** Ha sido unificada temporalmente con una constante, un número u otra estructura.
   * **Desligada por Backtracking:** Si una rama de búsqueda lógica falla, Prolog retrocede (*backtracking*), deshace la ligadura y la variable vuelve a estar libre para probar otras alternativas.

3. **Variable Anónima (`_`):**
   * Representa una variable cuyo valor individual no es necesario recuperar. Evita advertencias de variables singleton en el compilador:
     ```prolog
     % Se valida si X tiene algun progenitor sin importar quien sea:
     tiene_progenitor(X) :- progenitor_de(_, X).
     ```

---

## 4. Relación e Interacción entre Constantes y Variables

La relación operativa entre constantes y variables articula los procesos de deducción, consulta y cómputo en la programación lógica mediante tres pilares:

```
[ Base de Conocimiento (Hechos con Constantes) ]
              padre_de(jose, antonio).
                         |
                         v (Consulta con Variable)
              ?- padre_de(jose, Hijo).
                         |
                         v [Algoritmo de Unificación]
              Hijo = antonio (Variable ligada a Constante)
```

### A. Instanciación y Especialización
Las reglas lógicas se expresan de manera abstracta mediante **variables**, pero se vuelven aplicables al sustituirlas por **constantes**.
* *Regla formal:* $\forall x (\text{Planeta}(x) \rightarrow \text{OrbitaAlSol}(x))$
* *Prolog:* `orbita_al_sol(X) :- planeta(X).`
* Si existe el hecho con constante `planeta(tierra).`, la variable `X` se especializa con el valor `tierra`, concluyendo `orbita_al_sol(tierra)`.

### B. Algoritmo de Unificación
Es el mecanismo por el cual dos términos se confrontan para determinar si pueden ser idénticos mediante la asignación adecuada de valores:
* Una **constante** solo unifica con otra constante si son idénticas (`pedro = pedro` tiene éxito; `pedro = juan` falla).
* Una **variable libre** unifica de manera universal con cualquier constante, quedando ligada a ella mientras dure la rama de ejecución (`X = pedro` tiene éxito y asigna el átomo a la variable).

### C. Modo de Consulta (Verificación vs. Búsqueda)
* **Consulta con Constantes (Comprobación booleana):**
  Determina si una tupla concreta de individuos existe en el espacio de verdades de la base de conocimiento.
  ```prolog
  ?- padre_de(jose, antonio).
  % Salida: true.
  ```
* **Consulta con Variables (Extracción de información / Búsqueda de soluciones):**
  Le pide al intérprete que determine todas las constantes que satisfacen el predicado.
  ```prolog
  ?- padre_de(jose, Quien).
  % Salida: Quien = antonio.
  ```

---

## 5. Cuadro Comparativo

| Criterio | Constantes de Individuo | Variables de Individuo |
| :--- | :--- | :--- |
| **Definición lógica** | Nombres propios o etiquetas fijas de objetos ($a, b, c$). | Marcadores de posición o incógnitas del dominio ($x, y, z$). |
| **Sintaxis en Prolog** | Inician en **minúscula** o comillas simples (`marte`, `'Luna'`). | Inician en **Mayúscula** o guión bajo (`X`, `Planeta`, `_`). |
| **Comportamiento en memoria** | Estático, inmutable y permanente. | Dinámico (transita entre estados libre y ligado). |
| **Función en Hechos** | Declaran los datos concretos de la base de hechos. | Expresan generalizaciones o relaciones universales. |
| **Función en Consultas** | Verifican si una afirmación específica es cierta (`true/false`). | Descubren y extraen los elementos que cumplen la condición. |
| **Mecanismo asociado** | Validación directa por equivalencia de símbolos. | Unificación, ligadura (*binding*) y retroceso (*backtracking*). |

---

## 6. Conclusión

En la programación lógica y en Prolog, las **constantes de individuo** representan el conjunto de **hechos y datos reales conocidos** (el universo de entidades), mientras que las **variables de individuo** representan el **mecanismo de razonamiento, generalización e interrogación**. La ejecución de un programa lógico consiste fundamentalmente en encontrar qué constantes pueden asignarse a las variables para que el conjunto de fórmulas declaradas se mantenga verdadero.