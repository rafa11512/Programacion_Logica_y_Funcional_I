# Predicados Mitologicos de Prolog

---

Se les llama "mitológicos" de forma coloquial porque parecen tener poderes casi mágicos dentro del motor de inferencia de Prolog: una misma definición, escrita muchas veces con apenas dos cláusulas de Horn (caso base + paso recursivo), funciona en múltiples direcciones o modos gracias a la unificación y al backtracking.

Donde en un lenguaje funcional como Common Lisp usarías mapcar, remove-if-not o funciones recursivas explícitas sobre listas, en Prolog estos predicados resuelven transformaciones, búsquedas y agrupaciones de forma declarativa.

---

### Predicados Mitologicos

#### 1. `append/3 (append(Lista1, Lista2, ListaTotal))`
Concatena dos listas, pero también divide una lista en dos partes o verifica prefijos y sufijos según qué argumentos pasen instanciados o libres:
```prolog
% Concatenar (modo salida)
?- append([k17, ronda_1], [ronda_2, cierre], Evidencias).
% Evidencias = [k17, ronda_1, ronda_2, cierre].

% Dividir / buscar particiones (backtracking)
?- append(Antes, [pista_clave|Despues], [h1, h2, pista_clave, h3]).
% Antes = [h1, h2],
% Despues = [h3].
```

#### 2. `permutation/2 (permutacion(Lista, Permutacion))`
Genera o comprueba si una lista es una reordenación de otra. Es útil cuando el orden de evaluación o de eventos no está fijo:
```prolog
?- permutation([h1, h2, h3], P).
% P = [h1, h2, h3] ;
% P = [h1, h3, h2] ;
% ...
```

#### 3. `subset/2 o subconjunto/2`
Permite obtener o comprobar subconjuntos de elementos a partir de un conjunto base de hipótesis, reglas o evidencias. Definido de forma clásica con cláusulas de Horn:
```prolog
subconjunto([], []).
subconjunto([Cabeza|Cola], [Cabeza|Sub]) :-
    subconjunto(Cola, Sub).
subconjunto([_|Cola], Sub) :-
    subconjunto(Cola, Sub).
```

#### 4. `reverse/2 (reverse(Lista, Invertida))`
Invierte el orden de los elementos de una lista (útil para reconstruir secuencias cronológicas inversas o pilas de deducción):
```prolog
?- reverse([p01, p02, p03], OrdenInverso).
% OrdenInverso = [p03, p02, p01].
```

#### 5. `flatten/2 (flatten(ListaAnidada, ListaPlana))`
Aplana listas anidadas de cualquier profundidad en una sola lista lineal:
```prolog
?- flatten([[h1, h2], [h3, [h4, h5]]], Plana).
% Plana = [h1, h2, h3, h4, h5].
```

#### 6. `maplist/3`
Aplica un predicado binario a cada elemento de una lista para construir otra transformada:
```prolog
maplist(_, [], []).
maplist(Predicado, [H1|T1], [H2|T2]) :-
    call(Predicado, H1, H2),
    maplist(Predicado, T1, T2).

% Ejemplo:
cuadrado(X, Y) :- Y is X * X.
?- maplist(cuadrado, [1, 2, 3], Resultados).
% Resultados = [1, 4, 9].
```

#### 7. `findall(Plantilla, Meta, Lista)`
Encuentra todas las instancias de `Plantilla` que satisfacen o hacen verdadera a `Meta`. Si ninguna satisface la meta, unifica con lista vacía `[]` y nunca falla:
```prolog
% Teniendo: numero(10). numero(20). numero(30).
?- findall(X, numero(X), Resultados).
% Resultados = [10, 20, 30].
```

#### 8. `bagof(Plantilla, Meta, Lista)`
Similar a `findall`, pero si existen variables libres no incluidas en la plantilla, agrupa las soluciones por cada variable libre diferente. Si no hay soluciones, falla (`false`):
```prolog
% Teniendo: nota(ana, 100). nota(beto, 80). nota(carla, 100).
?- bagof(Alumno, nota(Alumno, N), Lista).
% N = 80, Lista = [beto] ;
% N = 100, Lista = [ana, carla].
```

#### 9. `setof(Plantilla, Meta, Lista)`
Funciona como `bagof`, pero además **ordena el resultado y elimina cualquier elemento duplicado**:
```prolog
?- setof(N, Alumno^nota(Alumno, N), Calificaciones).
% Calificaciones = [80, 100].
```

#### 10. `select/3`
Elimina una ocurrencia de un elemento de una lista o inserta un elemento en distintas posiciones mediante backtracking.
```prolog
?- select(b, [a, b, c, b], SinB).
% SinB = [a, c, b] ;
% SinB = [a, b, c].
```

#### 11. `member/2`
Comprueba si un elemento pertenece a una lista o recorre uno a uno todos los elementos de la lista al hacer backtracking.
```prolog
?- member(X, [rojo, verde, azul]).
% X = rojo ;
% X = verde ;
% X = azul.
```

#### 12. `foldl/4`
Reduce o acumula los elementos de una lista de izquierda a derecha aplicando un predicado acumulador pred(Elemento, AcumAnterior, AcumNuevo).
```prolog
sumar(X, Acc, NuevoAcc) :- NuevoAcc is Acc + X.

?- foldl(sumar, [5, 10, 15], 0, Total).
% Total = 30.
```



---


* De esta investigacion, aplicar Predicados Mitologicos al Ejercicio de la Actividad #24 "El Enigma de la Vitrina K-17"