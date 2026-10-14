% --- Familia Materna ---
% Abuela materna
madre_de(estela, sandra).
madre_de(estela, saul).

% En lugar de un hecho suelto, declaramos a los padres de Estela y Angelina para que las reglas de hermanas funcionen limpiamente:
madre_de(bisabuela_materna, estela).
madre_de(bisabuela_materna, angelina).

% Tía abuela materna y su familia
madre_de(angelina, noe).
madre_de(angelina, cesar).
madre_de(angelina, antonio_hijo_angelina).
madre_de(angelina, freddy).

padre_de(antonio_tio_materno, noe).
padre_de(antonio_tio_materno, cesar).
padre_de(antonio_tio_materno, antonio_hijo_angelina).
padre_de(antonio_tio_materno, freddy).

% Hijas de Noe
padre_de(noe, ashley).
padre_de(noe, anahi).

% Núcleo familiar (Sandra y Rafael padre)
madre_de(sandra, rafael_hijo).
madre_de(sandra, antonio_hermano).
madre_de(sandra, angel).

padre_de(rafael_padre, rafael_hijo).
padre_de(rafael_padre, antonio_hermano).
padre_de(rafael_padre, angel).

% Matrimonio
esposos(saul, sendy).

% --- Familia Paterna ---
madre_de(irene_abuela, rafael_padre).
madre_de(irene_abuela, juanelo).
madre_de(irene_abuela, enrique).
madre_de(irene_abuela, bonifacio_tio).

padre_de(bonifacio_abuelo, rafael_padre).
padre_de(bonifacio_abuelo, juanelo).
padre_de(bonifacio_abuelo, enrique).
padre_de(bonifacio_abuelo, bonifacio_tio).

% Hijos de Enrique (primos paternos)
padre_de(enrique, luis).
padre_de(enrique, daysi).

% Hijos de Bonifacio tío (primos paternos)
padre_de(bonifacio_tio, bonifacio_nieto).
padre_de(bonifacio_tio, irene_nieta).
padre_de(bonifacio_tio, chino).


%================================================ 2. CLASIFICACION DE GENERO (HOMBRE / MUJER)

hombre(rafael_padre).
hombre(rafael_hijo).
hombre(antonio_hermano).
hombre(angel).
hombre(saul).
hombre(antonio_tio_materno).
hombre(noe).
hombre(cesar).
hombre(antonio_hijo_angelina).
hombre(freddy).
hombre(bonifacio_abuelo).
hombre(juanelo).
hombre(enrique).
hombre(bonifacio_tio).
hombre(luis).
hombre(bonifacio_nieto).
hombre(chino).

mujer(estela).
mujer(angelina).
mujer(sandra).
mujer(sendy).
mujer(ashley).
mujer(anahi).
mujer(irene_abuela).
mujer(daysi).
mujer(irene_nieta).


%========================================= 3. REGLAS LOGICAS E INFERENCIAS

% Progenitor generico
progenitor_de(X, Y) :- padre_de(X, Y).
progenitor_de(X, Y) :- madre_de(X, Y).

% Hermanos (comparten al menos un progenitor y son distintos)
hermanos(X, Y) :-
    progenitor_de(P, X),
    progenitor_de(P, Y),
    X \= Y.

hermano_de(X, Y) :-
    hombre(X),
    hermanos(X, Y).

hermana_de(X, Y) :-
    mujer(X),
    hermanos(X, Y).

% Abuelos
abuelo_de(X, Y) :-
    padre_de(X, Z),
    progenitor_de(Z, Y).

abuela_de(X, Y) :-
    madre_de(X, Z),
    progenitor_de(Z, Y).

abuelo(X, Y) :- abuelo_de(X, Y).
abuelo(X, Y) :- abuela_de(X, Y).

% Tios y Tias
tio_de(X, Y) :-
    hermano_de(X, P),
    progenitor_de(P, Y).

tia_de(X, Y) :-
    hermana_de(X, P),
    progenitor_de(P, Y).

tio(X, Y) :- tio_de(X, Y).
tio(X, Y) :- tia_de(X, Y).

% Primos directos (hijos de hermanos)
primo_de(X, Y) :-
    hombre(X),
    progenitor_de(Px, X),
    progenitor_de(Py, Y),
    hermanos(Px, Py),
    Px \= Py.

prima_de(X, Y) :-
    mujer(X),
    progenitor_de(Px, X),
    progenitor_de(Py, Y),
    hermanos(Px, Py),
    Px \= Py.

primo(X, Y) :- primo_de(X, Y).
primo(X, Y) :- prima_de(X, Y).

% Conyuges
esposo_de(X, Y) :- esposos(X, Y), hombre(X).
esposa_de(X, Y) :- esposos(Y, X), mujer(X).
esposos_simetricos(X, Y) :- esposos(X, Y); esposos(Y, X).