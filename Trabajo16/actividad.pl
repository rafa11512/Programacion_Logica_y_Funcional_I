% 1. La Tierra es un planeta.
planeta(tierra).

% 2. La Luna no es un planeta.
no_planeta(luna).
no_es_planeta(X) :- \+ planeta(X).

% 3. La Luna es un satelite.
satelite(luna).

% 4. La Tierra gira alrededor del Sol.
gira_alrededor(tierra, sol).

% 5. Todo planeta es un satelite.
satelite(X) :- planeta(X).

% 6. Todo planeta gira alrededor del Sol.
gira_alrededor(X, sol) :- planeta(X).

% 7. Algun planeta gira alrededor de la Luna.
algun_planeta_gira_alrededor_luna(X) :- planeta(X), gira_alrededor(X, luna).

% 8. Hay por lo menos un satelite
hay_al_menos_un_satelite :- satelite(_).






% --------------------------------- VECINDARIO, PERROS Y CARTEROS
% 9. Todos los perros del vecindario muerden a algún cartero.
todos_perros_vecindario_muerden_algun_cartero :-
    forall((perro(X), en_vecindario(X)), (cartero(Y), muerde(X, Y))).

% 10. Hay un cartero al que lo muerden todos los perros.
cartero_mordido_por_todos_los_perros(X) :-
    cartero(X), forall(perro(Y), muerde(Y, X)).

% 11. Todos los carteros son mordidos por algún perro.
todos_los_carteros_son_mordidos :-
    forall(cartero(X), (perro(Y), muerde(Y, X))).

% 12. Hay un perro que muerde a todos los carteros.
perro_muerde_a_todos_los_carteros(X) :-
    perro(X), forall(cartero(Y), muerde(X, Y)).

% 13. Todos los perros que asustan a algún cartero, lo muerden.
muerde(X, Y) :- perro(X), cartero(Y), asusta(X, Y).

% 14. Hay un perro que muerde a todos los perros que muerden a algún cartero.
perro_muerde_a_perros_mordedores_de_carteros(X) :-
    perro(X),
    forall((perro(Y), cartero(Z), muerde(Y, Z)), muerde(X, Y)).

% 15. Hay un solo perro que se muerde a sí mismo.
unico_perro_se_muerde_a_si_mismo(X) :-
    perro(X), muerde(X, X), \+ (perro(Y), muerde(Y, Y), Y \= X).

% ----------------------------------------------- BIBLIOTECA, LIBROS, AUTORES Y USUARIOS
% 16. La Biblioteca Nacional tiene el libro "Don Quijote de la Mancha".
libro('Don Quijote de la Mancha').
tiene(biblioteca_nacional, 'Don Quijote de la Mancha').

% 17. Todos los libros en la Biblioteca Nacional están catalogados.
catalogado(X) :- libro(X), tiene(biblioteca_nacional, X).

% 18. Existen libros que están en más de una biblioteca.
en_mas_de_una_biblioteca(X) :-
    libro(X), tiene(B1, X), tiene(B2, X), B1 \= B2.

% 19. Si un libro es raro, entonces no se puede prestar.
no_prestable(X) :- libro(X), raro(X).
prestable(X) :- libro(X), \+ raro(X).

% 20. La Biblioteca Central tiene más de 10,000 libros.
tiene_mas_de_10000_libros(Bib) :- cantidad_libros(Bib, N), N > 10000.

% 21. Todos los autores tienen al menos un libro en una biblioteca.
todos_los_autores_tienen_libro_en_biblioteca :-
    forall(autor(A), (escribio(A, L), libro(L), tiene(_, L))).

% 22. Existe un autor que tiene más de 5 libros publicados.
autor_con_mas_de_5_libros(A) :-
    autor(A), findall(L, escribio(A, L), Libros), length(Libros, Total), Total > 5.

% 23. No todos los libros de la biblioteca están en buen estado.
no_todos_libros_en_buen_estado(Bib) :-
    tiene(Bib, L), libro(L), \+ buen_estado(L).

% 24. Si un libro está en buen estado, puede ser prestado.
prestable(X) :- libro(X), buen_estado(X).

% 25. Todos los usuarios registrados pueden tomar prestado un libro.
puede_tomar_prestado(U, L) :- usuario_registrado(U), libro(L), prestable(L).

% 26. Existen libros que solo se pueden consultar en la biblioteca.
solo_consulta_en_sala(X) :- libro(X), \+ prestable(X).

% 27. Todo libro prestado debe ser devuelto en 15 días.
plazo_devolucion_dias(X, 15) :- libro(X), prestado(X).

% 28. Hay un libro que nadie ha pedido en préstamo.
libro_nunca_pedido(X) :- libro(X), \+ pidio_prestado(_, X).

% 29. Si un usuario tiene una multa, no puede pedir un libro prestado.
puede_pedir_prestado(U, L) :- usuario(U), libro(L), prestable(L), \+ tiene_multa(U).

% 30. Todos los libros escritos por un mismo autor están en la misma sección.
misma_seccion(X, Y) :- en_seccion(X, S), en_seccion(Y, S).
todos_libros_mismo_autor_misma_seccion :-
    forall((escribio(A, L1), escribio(A, L2)), misma_seccion(L1, L2)).

% 31. Existe un libro que tiene más de un ejemplar en la biblioteca.
tiene_multiples_ejemplares(L) :-
    libro(L), ejemplar_de(E1, L), ejemplar_de(E2, L), E1 \= E2.

% 32. Todo usuario con más de tres préstamos debe devolver uno para pedir otro.
debe_devolver_para_prestar(U) :-
    usuario(U), findall(L, prestamo_activo(U, L), P), length(P, C), C > 3.

% 33. Hay una sección de la biblioteca donde todos los libros son de ciencias.
seccion_exclusiva_ciencias(S) :-
    seccion(S), en_seccion(_, S),
    forall((libro(L), en_seccion(L, S)), de_ciencias(L)).

% 34. No todos los libros en la biblioteca tienen más de 100 páginas.
libro_con_100_o_menos_paginas(L) :-
    libro(L), tiene(_, L), paginas(L, P), P =< 100.

% 35. Existe un usuario que ha tomado prestados todos los libros de la sección infantil.
usuario_tomo_todos_libros_seccion_infantil(U) :-
    usuario(U),
    forall((libro(L), en_seccion(L, infantil)), tomo_prestado(U, L)).