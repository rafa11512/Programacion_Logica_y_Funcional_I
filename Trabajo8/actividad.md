# `car` y `cdr` en Clisp

---

## Explicacion de las funciones

## `car`
Devuelve el **primer elemento** (la "cabeza") de una lista

**Ejemplo:**
```lisp
(car '(1 2 3 4 5)) ; retorna 1
(car '(ia (ib (ic a b v (1 2 3 4))))) ; retorna IA
```

## `cdr`
Devuelve el **resto de la lista** (la "cola"), es decir, devuelvela la lista sin su primer elemento
"Siempre devuelve una lista"

**Ejemplo:**
```lisp
(cdr '(1 2 3 4)) ; regresa: (2 3 4)
```

* ## `cadr`
Devuelve el segundo elemento de la lista


### Combinaciones y Contracciones

Para evitar escribir demasiados parentesis al buscar elementos profundos por ejemplo. `(car (cdr (cdr X)))`, LISP permite anidar llamadas a `car` y `cdr` para acceder a niveles mas profundos de las listas, asi como contraer hasta 4 operaciones juntas formando palabras como `cadr`, `cddr`, `cadddr`, etc.

Las contracciones se leen y ejecutan de **derecha a izquierda** (empezando por la letra mas cercana a la `r` final hacia la `c` inicial)
*   La letra **`a`** significa: aplica un **`car`**.
*   La letra **`d`** significa: aplica un **`cdr`**.
*   Ej: `(cadr A)` es similar a un `(car (cdr A))`

#### Ejemplos de uso
```lisp
(cadr '(1 2 3 4))                  ; 2  (segundo elemento)
(cddr '(1 2 3 4))                  ; (3 4) (lista sin los dos primeros elementos)
(cdddr '(1 2 3 4))                 ; (4)
(cddddr '(1 2 3 4 (a b c)))        ; ((A B C))
(car (cddddr '(1 2 3 4 (a b c))))  ; (A B C)
(caar (cddddr '(1 2 3 4 (a b c)))) ; A
(cdar (cddddr '(1 2 3 4 (a b c)))) ; (B C)
(cadar (cddddr '(1 2 3 4 (a b c)))) ; B
(cddar (cddddr '(1 2 3 4 (a b c)))) ; (C)
```



---

# Ejercicios Practicos

### a) (1 2 3 4 5 6 7 8 9 10)     
* ### Extraer: 6, 8, 10

```lisp
(cadr (cddddr '(1 2 3 4 5 6 7 8 9 10))) ; 6

(cadddr (cddddr '(1 2 3 4 5 6 7 8 9 10))) ; 8

(caddr (cdddr (cddddr '(1 2 3 4 5 6 7 8 9 10)))) ; 10
```

### b) (1 2 (3 4)(A B C D)) 
* ### Extraer: D, C, 4, 2, A


```lisp
(car (cdddr (car (cdddr '(1 2 (3 4)(A B C D)))))) ; D

(car (cddr (car (cdr (cddr '(1 2 (3 4)(A B C D))))))) ; C

(cadr (car (cddr '(1 2 (3 4)(A B C D))))) ; 4

(cadr '(1 2 (3 4)(A B C D))) ; 2

(caar (cdr (cddr '(1 2 (3 4)(A B C D))))) ; A
```

### c) ((A B C)(R (T X)(Z W)))
* ### Extraer: W, Z, T, R, X, A

```lisp
(caar '((A B C)(R (T X)(Z W)))) ; A

(caadr '((A B C)(R (T X)(Z W)))) ; R

(caadr (cadr '((A B C)(R (T X)(Z W))))); T

(cadr (cadr (cadr '((A B C)(R (T X)(Z W)))))) ; X

(car (cadr (cdr (cadr '((A B C)(R (T X)(Z W))))))) ; Z

(cadr (cadr (cdr (cadr '((A B C)(R (T X)(Z W))))))) ; W
```

### d) ((((a b)(c d)(f g))))    
* ### Extraer: a, b, c, d, f, g

```lisp
(caaaar '((((a b)(c d)(f g))))) ; A

(cadr (caaar '((((a b)(c d)(f g)))))) ; B

(caadr (caar '((((a b)(c d)(f g)))))) ; C

(cadr (cadr (caar '((((a b)(c d)(f g))))))) ; D

(caar (cddr (caar '((((a b)(c d)(f g))))))) ; F

(cadar (cddr (caar '((((a b)(c d)(f g))))))) ; G

```
