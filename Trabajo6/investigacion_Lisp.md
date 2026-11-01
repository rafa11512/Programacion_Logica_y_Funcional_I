# LISP y COMMON LISP

Common Lisp es un lenguaje multiparadigma derivado de Lisp (**LISt Processing**), uno de los lenguajes de alto nivel mas antiguos que aun se usa activamente. Es famoso por su capacidad de tratar el codigo como datos (**homoiconicidad**) y por su potente sistema de macros.


---
# Sintaxis y Fundamentos del Lenguaje

Lisp tiene una sintaxis minimalista, extremadamente uniforme, basada en **S-Expressions (Expresiones Simbólicas)** (expresiones simbolicas): tanto el codigo como los datos se representan con la misma estructura de listas anidadas.

### Uso de los Parentesis `()` y Notacion Prefija
En Lisp, todo esta envuelto en parentesis. Los parentesis definen listas, y el codigo fuente en si mismo esta escrito como listas. Cuando el interprete de Lisp evalua una lista, asume estrictamente que el primer elemento es una funcion (u operador) y el resto son sus argumentos.

*   **Notacion prefija:** Las operaciones van primero, seguidas de los operandos.
    *   En lugar de `2 + 3`, escribimos `(+ 2 3)`
    *   En lugar de `(5 * 4) + (2 - 1)`, escribimos `(+ (* 5 4) (- 2 1))`

### Código y Datos (El apóstrofe `'` o `quote`)
La **homoiconicidad** significa que el codigo fuente tiene la misma estructura que los datos. Si no quieres que Lisp evalue una lista como una funcion, le antepones un apóstrofe. Esto le indica al interprete: *"toma esto literalmente como una estructura de datos, no lo ejecutes"*.
*   `(+ 1 2)` evalua la funcion y retorna `3`.
*   `'(+ 1 2)` bloquea la evaluacion y retorna la lista literal `(+ 1 2)`.

### La Recursividad
Lisp fue pionero en el uso de la recursividad. En el paradigma funcional puro, se evitan los bucles iterativos tradicionales (`for` o `while`) que mutan variables. En su lugar, se utilizan funciones que se llaman a sí mismas, apoyándose en la optimización de memoria del compilador (como la recursión de cola o *tail-call optimization*).

### El significado del asterisco ``*`` (Earmuffs / Orejeras)
En Lisp, nombrar una variable global con asteriscos a los lados (ej. `*tasa-de-interes*`) no indica un puntero. Es una fuerte convención visual. Sirve para advertir a otros programadores que esa variable tiene ámbito dinámico y afecta el estado global. Si modificas una variable con orejeras, cambiarás el comportamiento de cualquier función que dependa de ella.








---

# Funciones Primitivas

* ## Definicion, Variables y Entornos

### 1. `defparameter`
#### Define una variable global (variable especial) y le asigna un valor. A diferencia de `defvar`, siempre sobrescribe el valor si el codigo se vuelve a cargar
```lisp
(defparameter *tasa-de-interes* 0.05)
(defparameter *tasa-de-interes* 0.10) ;; Se sobrescribe sin problema
*tasa-de-interes* ;; Retorna: 0.10
```

### 2. `defvar`
#### Define una variable global, pero solo le asigna un valor si esta no existía previamente. Ideal para preservar estados al recargar el codigo
```lisp
(defvar *contador* 0)
(defvar *contador* 100) ;; No hace nada, *contador* ya existía
*contador* ;; Retorna: 0
```

### 3. `setf`
#### Asigna o modifica el valor de una variable, celda de una lista, o cualquier lugar de almacenamiento (place) ya existente.
```lisp
(defparameter *x* 5)
(setf *x* 10)
*x* ;; Retorna: 10
```

### 4. `let`
#### Crea variables locales que solo existen dentro de un bloque de codigo. Todas las asignaciones se calculan "en paralelo", es decir, ninguna puede referirse a otra definida en el mismo `let`.
```lisp
(let ((x 10)
      (y 20))
  (+ x y)) ;; Retorna: 30. Fuera de este bloque, X e Y no existen.
```

### 5. `let*`
#### Igual que `let`, pero evalúa las asignaciones en orden secuencial, permitiendo que una variable dependa de otra definida justo antes en el mismo bloque.
```lisp
(let* ((x 10)
       (y (* x 2)))
  (+ x y)) ;; Retorna: 30
```

### 6. `defun`
#### Macro de nivel superior para definir funciones nombradas y sus parámetros de entrada
```lisp
(defun cuadrado (x)
  (* x x))
(cuadrado 6) ;; Retorna: 36
```

### 7. `lambda`
#### Crea una función anónima (sin nombre), útil para pasarla como argumento temporal a otra función sin necesidad de definirla con `defun`
```lisp
(mapcar (lambda (x) (* x x)) '(1 2 3)) ;; Retorna: (1 4 9)
```

### 8. `defmacro`
#### Define una macro: una construcción que recibe codigo sin evaluar, lo transforma y genera nuevo codigo que si se evaluara. Permite extender la sintaxis del propio lenguaje
```lisp
(defmacro mi-si (condicion entonces sino)
  `(cond (,condicion ,entonces)
         (t ,sino)))
(mi-si (> 5 3) "sí" "no") ;; Retorna: "sí"
```



* ## Control de Flujo e Iteracion

### 9. `if`
#### Condicional básico. Toma tres argumentos: la condicion, la expresión a ejecutar si es verdadera (no NIL) y la expresión a ejecutar si es falsa (NIL).
```lisp
(if (> 5 3)
    "Cinco es mayor"
    "Tres es mayor") ;; Retorna: "Cinco es mayor"
```

### 10. `cond`
#### Macro condicional multiple, equivalente a un "switch/case" o "if-else if" en otros lenguajes. Evalúa cada cláusula en orden hasta encontrar una condicion verdadera
```lisp
(defparameter *x* 0)
(cond ((> *x* 0) "Positivo")
      ((< *x* 0) "Negativo")
      (t "Es Cero")) ;; Retorna: "Es Cero"
```

### 11. `when`
#### Ejecuta un cuerpo de codigo solo si la condicion es verdadera (no NIL). Es una versión simplificada de `if` sin rama "else", que además permite varias expresiones en el cuerpo.
```lisp
(when (> 5 3)
  (format t "Cinco es mayor~%")
  "resultado") ;; Imprime el mensaje y Retorna: "resultado"
```

### 12. `unless`
#### Ejecuta un cuerpo de codigo solo si la condicion es falsa (NIL). Es el complemento inverso de `when`.
```lisp
(unless (> 3 5)
  (format t "Tres NO es mayor~%")) ;; Imprime el mensaje
```

### 13. `progn`
#### Agrupa varias expresiones para que se ejecuten en secuencia, una tras otra, retornando unicamente el valor de la última.
```lisp
(progn
  (format t "Paso 1~%")
  (format t "Paso 2~%")
  "listo") ;; Imprime ambos pasos y Retorna: "listo"
```

### 14. `dolist`
#### Itera sobre cada elemento de una lista, ejecutando un cuerpo de codigo para cada uno. Se usa principalmente por sus efectos secundarios (como imprimir), ya que normalmente retorna NIL.
```lisp
(dolist (fruta '(manzana pera uva))
  (format t "Fruta: ~A~%" fruta))
;; Imprime:
;; Fruta: MANZANA
;; Fruta: PERA
;; Fruta: UVA
```

### 15. `dotimes`
#### Repite un cuerpo de codigo un número fijo de veces, útil como bucle contador tradicional.
```lisp
(dotimes (i 3)
  (format t "Iteración ~A~%" i))
;; Imprime:
;; Iteración 0
;; Iteración 1
;; Iteración 2
```

* ## Manipulación Estructural de Listas

### 16. `cons`
#### Construye una lista nueva añadiendo un elemento al principio de otra lista
```lisp
(cons 'fresa '(manzana pera)) ;; Retorna: (FRESA MANZANA PERA)
```

### 17. `car`
#### Retorna el primer elemento de una lista (la "cabeza")
```lisp
(car '(manzana pera plátano)) ;; Retorna: MANZANA
```

### 18. `first`
#### Sinónimo semántico de `car`. Retorna el primer elemento de una lista; se prefiere por legibilidad cuando se trabaja conceptualmente con listas (en vez de pares punteados).
```lisp
(first '(manzana pera plátano)) ;; Retorna: MANZANA
```

### 19. `cdr`
#### Retorna el resto de la lista (todo excepto el primer elemento)
```lisp
(cdr '(manzana pera plátano)) ;; Retorna: (PERA PLÁTANO)
```

### 20. `list`
#### Crea y retorna una nueva lista a partir de todos los argumentos proporcionados
```lisp
(list 1 'dos "tres" 4.0) ;; Retorna: (1 DOS "tres" 4.0)
```

### 21. `append`
#### Concatena los elementos de múltiples listas en una única lista nueva
```lisp
(append '(1 2) '(3 4) '(5)) ;; Retorna: (1 2 3 4 5)
```

### 22. `length`
#### Retorna un número entero que representa la cantidad de elementos de una lista o secuencia
```lisp
(length '(a b c d e)) ;; Retorna: 5
```

### 23. `nth`
#### Retorna el elemento que se encuentra en la posición n de una lista (empezando en el índice 0)
```lisp
(nth 2 '(cero uno dos tres)) ;; Retorna: DOS
```

### 24. `last`
#### Retorna la última celda (sublista) de una lista, no solo el último elemento suelto.
```lisp
(last '(a b c d)) ;; Retorna: (D)
```

### 25. `subseq`
#### Extrae y retorna una subsecuencia de una lista, indicando el índice inicial y, opcionalmente, el límite final (exclusivo)
```lisp
(subseq '(a b c d e) 1 4) ;; Retorna: (B C D)
```

### 26. `push`
#### Inserta un elemento al inicio de una lista, modificando directamente la variable que contiene esa lista (es una macro que combina `cons` y `setf`).
```lisp
(defparameter *pila* '(2 3 4))
(push 1 *pila*)
*pila* ;; Retorna: (1 2 3 4)
```

### 27. `pop`
#### Extrae y elimina el primer elemento de una lista, modificando la variable original y retornando el elemento eliminado.
```lisp
(defparameter *pila* '(1 2 3 4))
(pop *pila*)  ;; Retorna: 1
*pila*        ;; Retorna: (2 3 4)
```

* ## Predicados y Lógica

### 28. `atom`
#### Predicado que retorna T si el argumento NO es una lista (es decir, es un átomo: número, símbolo o string)
```lisp
(atom 45)        ;; Retorna: T
(atom '(1 2 3))  ;; Retorna: NIL
```

### 29. `listp`
#### Predicado que evalúa si el argumento es una lista (incluida la lista vacía NIL)
```lisp
(listp '(1 2 3)) ;; Retorna: T
(listp 'hola)    ;; Retorna: NIL
```

### 30. `null`
#### Predicado que retorna T si el argumento es la lista vacía o el valor NIL (el "falso" de Lisp)
```lisp
(null '())  ;; Retorna: T
(null NIL)  ;; Retorna: T
(null '(1)) ;; Retorna: NIL
```

### 31. `eq`
#### Comparador de identidad estricta. Retorna T solo si ambos argumentos son exactamente el mismo objeto en memoria
```lisp
(eq 'a 'a)     ;; Retorna: T
(eq 3.0 3.0)   ;; Retorna: NIL (en la mayoría de implementaciones, porque cada 3.0 puede residir en una dirección de memoria distinta)
```

### 32. `equal`
#### Comparador estructural. Retorna T si dos expresiones tienen componentes idénticos o equivalentes en valor y estructura
```lisp
(equal (list 1 2) (list 1 2)) ;; Retorna: T
(equal "hola" "hola")         ;; Retorna: T
```

* ## Búsqueda, Filtrado y Ordenamiento

### 33. `member`
#### Busca un elemento dentro de una lista. Si lo encuentra, retorna el resto de la lista a partir de ese elemento; si no, retorna NIL
```lisp
(member 3 '(1 2 3 4 5)) ;; Retorna: (3 4 5)
```

### 34. `find`
#### Busca un elemento dentro de una secuencia (lista, vector, etc.) y lo retorna si existe; retorna NIL si no se encuentra.
```lisp
(find 3 '(1 2 3 4 5)) ;; Retorna: 3
(find 9 '(1 2 3 4 5)) ;; Retorna: NIL
```

### 35. `assoc`
#### Busca una clave dentro de una lista de asociación (una lista de pares `(clave . valor)`) y retorna el par completo si la encuentra, o NIL si no.
```lisp
(assoc 'b '((a . 1) (b . 2) (c . 3))) ;; Retorna: (B . 2)
```

### 36. `remove`
#### Retorna una copia de la lista en la que se eliminaron todas las ocurrencias del elemento especificado (no modifica la lista original)
```lisp
(remove 'x '(x a b x c x)) ;; Retorna: (A B C)
```

### 37. `remove-if`
#### Retorna una copia de la lista eliminando los elementos que sí cumplen con una condición (función predicado) dada.
```lisp
(remove-if #'evenp '(1 2 3 4 5 6)) ;; Retorna: (1 3 5)
```

### 38. `reverse`
#### Invierte el orden de los elementos de nivel superior de una lista, produciendo una copia nueva (no modifica la lista original)
```lisp
(reverse '(primero segundo tercero)) ;; Retorna: (TERCERO SEGUNDO PRIMERO)
```

### 39. `sort`
#### Ordena una secuencia de manera destructiva (modifica la lista original en memoria) según una función predicado dada (como `<` o `>`). Por su naturaleza destructiva, conviene usarla como `(setf mi-lista (sort mi-lista #'<))` para no perder la referencia correcta
```lisp
(sort (list 4 1 5 2) #'<) ;; Retorna: (1 2 4 5)
```

* ## Programacion Funcional (Orden Superior) y Utilidades

### 40. `mapcar`
#### Aplica una función a cada uno de los elementos de una o más listas, devolviendo una nueva lista con los resultados
```lisp
(mapcar #'1+ '(1 2 3 4)) ;; Retorna: (2 3 4 5)
```

### 41. `reduce`
#### Aplica una función binaria combinando los elementos de la lista de izquierda a derecha hasta reducirlos a un solo valor
```lisp
(reduce #'+ '(10 20 30)) ;; Retorna: 60 (10+20+30)
```

### 42. `apply`
#### Ejecuta una función pasándole una lista completa de elementos como si fueran argumentos individuales
```lisp
(apply #'+ '(1 2 3 4)) ;; Retorna: 10
```

### 43. `funcall`
#### Invoca directamente una función a partir de un valor funcional (por ejemplo, una obtenida con `#'` o una `lambda`), pasándole los argumentos de forma individual.
```lisp
(funcall (lambda (x y) (+ x y)) 3 4) ;; Retorna: 7
(funcall #'+ 3 4)                    ;; Retorna: 7
```

### 44. `format`
#### Imprime texto formateado (similar a printf). El primer argumento `t` indica salida hacia la consola estándar. `~A` es un marcador de posición genérico y `~%` inserta un salto de línea
```lisp
(format t "Hola ~A, tienes ~A años~%" "Juan" 25)
;; Imprime: Hola Juan, tienes 25 años
;; Retorna: NIL
```

### 45. `random`
#### Genera y retorna un número pseudoaleatorio entre 0 (inclusive) y el límite proporcionado (exclusivo)
```lisp
(random 10) ;; Retorna un número aleatorio entre 0 y 9.
```

---

Links de apoyo.

- [Referencia 1. Apuntes Proramacion Logica y Funcional](https://ealcaraz85.github.io/prolog.io/#org9ff7cae)
- [Referencia 2. Funciones básicas](https://medium.com/@davidcabreraygarcia/2-funciones-b%C3%A1sicas-c787bd355b5b)
- [Referencia 3. LISP - Quick Guide](https://www.tutorialspoint.com/lisp/lisp_quick_guide.htm)

