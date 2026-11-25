% caso_k17.pl - Modelado logico del caso Vitrina K-17 (18/11/2026)

:- discontiguous hecho_doc/3.
:- discontiguous no_demostrado/1.


% 1. HECHOS COMPROBABLES (14 hechos con referencia documental)

% Masa del pedestal K-17 (hora oficial del servidor en minutos desde 00:00)
% 18:26 = 1106 min, 18:27 = 1107 min
hecho_doc(masa(k17, 1106, 620), a05, 'Lectura estable 18:26 - 620 g').
hecho_doc(masa(k17, 1107, 580), a05, 'Cambio abrupto 18:27 - 580 g').

% Incertidumbre maxima del sensor de masa (+/- 3 g)
hecho_doc(incertidumbre_masa(k17, 3), a05, 'Incertidumbre maxima +/- 3 g').

% Objetos y pesos
hecho_doc(objeto(k17_o, original, 620), a01, 'Original K17-O pesa 620 g').
hecho_doc(objeto(k17_r, replica, 580), a01, 'Replica K17-R pesa 580 g').

% Credencial B02 y prestamo verificado (18:11 = 1091, 18:34 = 1114)
hecho_doc(titular_credencial(bruno, b02), a02, 'Bruno titular de B02').
hecho_doc(prestamo_credencial(b02, bruno, dalia, 1091, 1114), b14, 'Prestamo B02 18:11 a 18:34').

% Coartada de Alicia en conferencia (18:19 = 1099 a 18:33 = 1113)
hecho_doc(evento_coartada(alicia, 1099, 1113), b13, 'Conferencia Alicia 18:19-18:33').

% Entrega de funda gris y resguardo en caja M2 (18:33 = 1113, 18:36 = 1116)
hecho_doc(entrega_funda(dalia, fatima, funda_gris, 1113), b15, 'Dalia entrega funda a Fatima 18:33').
hecho_doc(resguardo_caja(fatima, k17_o, caja_m2, 1116), b15, 'Resguardo en caja M2 a las 18:36').

% Normativa vigente (v4) y ausencia de ticket SEC aprobado / emergencia valida
hecho_doc(protocolo_vigente(v4, 1020, 1140), a03, 'Protocolo v4 vigente 15/11-31/12/2026').
hecho_doc(ticket_sec_aprobado(ninguno), a03, 'Sin ticket SEC aprobado registrado').
hecho_doc(emergencia_valida(ninguna), a03, 'Sin peligro inmediato en sensores + 2 firmas').

% Hechos explicitamente NO demostrados en el corpus disponible
no_demostrado(apertura_cubierta_registrada).
no_demostrado(presencia_fisica_por_titularidad).


% 2. REGLAS DE TIEMPO, INTERVALOS Y DESFASES

% Convierte HH:MM a minutos desde medianoche
hhmm_a_minutos(H, M, Min) :-
    Min is H * 60 + M.

% Pertenencia inclusiva a un intervalo [Inicio, Fin]
en_intervalo(T, Inicio, Fin) :-
    T >= Inicio,
    T =< Fin.

% Correccion de desfase respecto a la hora oficial del servidor:
% T_oficial = T_dispositivo + Desfase_minutos
hora_corregida(T_dispositivo, Desfase, T_oficial) :-
    T_oficial is T_dispositivo + Desfase.

% Acceso oficial corregido (ejemplo con desfase declarado Desfase)
acceso_oficial(Credencial, EntradaCorregida, SalidaCorregida) :-
    hecho_doc(prestamo_credencial(Credencial, _Origen, _Destino, E_raw, S_raw), _, _),
    desfase_lector(Credencial, Desfase),
    hora_corregida(E_raw, Desfase, EntradaCorregida),
    hora_corregida(S_raw, Desfase, SalidaCorregida).

% Si no hay desfase adicional configurado, el desfase es 0 minutos
desfase_lector(b02, 0).



% 3. REGLAS DE INFERENCIA DEL CASO (8+ reglas propias)

% Cambio de masa significativo (supera la incertidumbre maxima)
cambio_masa_significativo(T, Delta) :-
    T_prev is T - 1,
    hecho_doc(masa(k17, T_prev, M_prev), _, _),
    hecho_doc(masa(k17, T, M_curr), _, _),
    hecho_doc(incertidumbre_masa(k17, Inc), _, _),
    Delta is abs(M_curr - M_prev),
    Delta > Inc.

% Instante del intercambio inferido por cambio de masa significativo
hora_intercambio(T) :-
    cambio_masa_significativo(T, _Delta).

% Candidato a posible autor por tenencia/prestamo de credencial en el instante T
posible_autor(Persona) :-
    hora_intercambio(T),
    hecho_doc(prestamo_credencial(b02, _Bruno, Persona, Ini, Fin), _, _),
    en_intervalo(T, Ini, Fin).

% Evidencia convergente para inferir al autor:
% 1) Tenia la credencial B02 en el instante del intercambio (T = 1107)
% 2) Realizo entrega posterior de funda gris asociada al traslado del original
autor_con_evidencia(Persona) :-
    hora_intercambio(T),
    hecho_doc(prestamo_credencial(b02, _Bruno, Persona, Ini, Fin), _, _),
    en_intervalo(T, Ini, Fin),
    hecho_doc(entrega_funda(Persona, _Receptor, funda_gris, _T_entrega), _, _),
    \+ en_intervalo(T, 1099, 1113). % No esta bloqueado por coartada en ese instante

% Ubicacion del original inferida a partir del resguardo registrado
ubicacion_del_original(Lugar) :-
    hecho_doc(resguardo_caja(_Resp, k17_o, Lugar, _T), _, _).

% Sustitucion autorizada solo si hay ticket SEC o emergencia valida bajo v4
sustitucion_autorizada(autorizada) :-
    hecho_doc(protocolo_vigente(v4, _, _), _, _),
    hecho_doc(ticket_sec_aprobado(Ticket), _, _),
    Ticket \= ninguno.

sustitucion_autorizada(autorizada) :-
    hecho_doc(protocolo_vigente(v4, _, _), _, _),
    hecho_doc(emergencia_valida(Emerg), _, _),
    Emerg \= ninguna.

% Explicacion de fuentes que respaldan a una persona en el caso
explicacion(Persona, Fuentes) :-
    findall(Doc, hecho_doc(_, Doc, _), RawDocs),
    sort(RawDocs, FuentesUnicas),
    ( Persona == dalia ->
        Fuentes = [a01, a05, b14, b15 | FuentesUnicas]
    ; Fuentes = FuentesUnicas
    ).