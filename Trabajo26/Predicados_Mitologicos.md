# Predicados Mitologicos de Prolog

---

No son mitología griega: son predicados tan generales que parecen hacer magia porque la misma definición sirve para varios modos (concatenar o partir, insertar o enumerar posiciones). Casi todos se escriben con dos cláusulas Horn —hecho + paso recursivo— y el árbol SLD se encarga del resto. append/3, maplist/3 y permutacion/2 son el puente con mapcar y las listas de Lisp: misma idea, otro motor.

predicados que puedan hacer varias cosas...

---

### Predicados Mitologicos
funtor
- append
- permutacion
- subconjunto
- reverse
- findall
- flatten

algunos ya estan definidos dentro del mismo prolog como append/3

#### 1. `maplist`
El predicado **maplist** aplica un predicado a cad elemento de una lista y genera una lista transformada:
```prolog
maplist(_, [], []).
maplist(Predicado, [H1|T1], [H2|T2]) :-
    call(Predicado, H1, H2), maplist(Predicado, T1, T2).
```
* Ejemplo; Calcular el cuadrado de cada nuemro de una lista:
```prolog
cuadrado(X, Y) :- Y is X * X.
?- maplist(cuadrado, [1, 2, 3], Resultados).
% Resultados = [1, 4, 9].
```


#### 2. `findall(Plantilla, Meta, Lista)`
Encuentra todas las instancias de `Plantilla` que satisfacen `Meta`. Si ninguna satisface la meta, unifica con lista vacía `[]` y nunca falla:
```prolog
% Teniendo hechos: numero(10). numero(20). numero(30).
?- findall(X, numero(X), Resultados).
Resultados = [10, 20, 30].
```


#### 3. `bagof(Plantilla, Meta, Lista)`
Similar a `findall`, pero si existen variables libres no incluidas en la plantilla, agrupa las soluciones por cada variable libre diferente. Si no hay soluciones, falla (`false`):
```prolog
% Teniendo: nota(ana, 100). nota(beto, 80). nota(carla, 100).
?- bagof(Alumno, nota(Alumno, N), Lista).
N = 80, Lista = [beto] ;
N = 100, Lista = [ana, carla].
```


#### 4. `setof(Plantilla, Meta, Lista)`
Funciona como `bagof`, pero además **ordena el resultado y elimina cualquier elemento duplicado**:
```prolog
?- setof(N, Alumno^nota(Alumno, N), Calificaciones).
Calificaciones = [80, 100].
```



---


* De esta investigacion, aplicar Predicados Mitologicos al Ejercicio de la Actividad #24 "El Enigma de la Vitrina K-17"