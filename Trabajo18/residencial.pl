% Mision 1 — El Dominio de la Calle

% Genero
mujer(ana).
mujer(carla).
hombre(beto).
hombre(diego).

% Dominio: persona/1
persona(ana).
persona(beto).
persona(carla).
persona(diego).

% Dominio: color/1
color(blanca).
color(verde).
color(roja).
color(azul).

% Dominio: bebida/1
bebida(agua).
bebida(cafe).
bebida(leche).
bebida(te).

% Dominio: mascota/1
mascota(gato).
mascota(perro).
mascota(pez).
mascota(loro).


% Mision 2 y Mision 4. Hechos del expediente y tablero de deduccion

% vive_en(Persona, NumeroCasa)
vive_en(ana, 1).        % Pista 1 (Hecho directo)
vive_en(beto, 2).       % Deduccion: Pistas 3, 5, 4, 9 y 12
vive_en(carla, 3).      % Deduccion: Pista 6 y descarte de casas
vive_en(diego, 4).      % Deduccion: Pistas 9, 12 y 4

% color_casa(NumeroCasa, Color)
color_casa(1, blanca).  % Deduccion: Pistas 1 y 2
color_casa(2, verde).   % Deduccion: Pistas 4, 5, 12 y 9
color_casa(3, roja).    % Deduccion: Pista 4
color_casa(4, azul).    % Deduccion: Pistas 9, 12 y 4

% bebe(Persona, Bebida)
bebe(ana, agua).        % Deduccion: Descarte y pista 8
bebe(beto, cafe).       % Pista 3 (Hecho directo)
bebe(carla, leche).     % Pista 6 (Hecho directo)
bebe(diego, te).        % Deduccion: Pista 12 y ubicacion en casa 4

% tiene(Persona, Mascota)
tiene(ana, gato).       % Deduccion: Pista 8
tiene(beto, perro).     % Deduccion: Descarte y verificacion pista 7
tiene(carla, pez).      % Pista 11 (Hecho directo)
tiene(diego, loro).     % Deduccion: Pista 10


% Mision 3. La fabrica de Reglas

% 1. dueno_del_pez(P) - determina quien tiene el pez
dueno_del_pez(P) :-
    tiene(P, pez).

% 2. color_de(Persona, Color) - relaciona a la persona con el color de su casa mediante la variable N
color_de(Persona, Color) :-
    vive_en(Persona, N),
    color_casa(N, Color).

% 3. vecinos(P1, P2) - determina si dos personas viven en casas contiguas
vecinos(P1, P2) :-
    vive_en(P1, N1),
    vive_en(P2, N2),
    abs(N1 - N2) =:= 1.

% 4. bebe_en_casa(N, B) - determina la bebida que se consume en la casa N
bebe_en_casa(N, B) :-
    vive_en(P, N),
    bebe(P, B).

% 5. perfil(P, N, Color, Bebida, Mascota) - expediente con todos los atributos de cada persona
perfil(P, N, Color, Bebida, Mascota) :-
    persona(P),
    vive_en(P, N),
    color_casa(N, Color),
    bebe(P, Bebida),
    tiene(P, Mascota).


% Mision 5. El expediente Completo

% resumen_pez(P, N, Color, Bebida) - resumen de datos de quien posee el pez
resumen_pez(P, N, Color, Bebida) :-
    dueno_del_pez(P),
    vive_en(P, N),
    color_casa(N, Color),
    bebe(P, Bebida).


% Extra. Buscador por listas y restricciones

izquierda(A, B, [A, B | _]).
izquierda(A, B, [_ | Resto]) :-
    izquierda(A, B, Resto).

vecino(A, B, Casas) :-
    izquierda(A, B, Casas).
vecino(A, B, Casas) :-
    izquierda(B, A, Casas).

buscar(Casas) :-
    Casas = [
        casa(1, _, _, _, _),
        casa(2, _, _, _, _),
        casa(3, _, _, _, _),
        casa(4, _, _, _, _)
    ],
    member(casa(1, _, ana, _, _), Casas),
    member(casa(_, blanca, ana, _, _), Casas),
    member(casa(_, _, beto, cafe, _), Casas),
    izquierda(casa(_, verde, _, _, _), casa(_, roja, _, _, _), Casas),
    member(casa(_, verde, _, cafe, _), Casas),
    member(casa(_, _, carla, leche, _), Casas),
    vecino(casa(_, _, _, _, perro), casa(_, _, _, agua, _), Casas),
    member(casa(_, _, _, agua, gato), Casas),
    member(casa(_, azul, diego, _, _), Casas),
    member(casa(_, _, _, te, loro), Casas),
    member(casa(_, _, carla, _, pez), Casas),
    member(casa(4, _, _, te, _), Casas).
