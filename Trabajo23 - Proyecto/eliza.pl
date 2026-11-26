eliza:-	writeln('================================================================='),
    writeln('      ELIZA - SISTEMA EXPERTO MEDICO'),
    writeln('⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⢤⣤⡀⠀⠀⠀⠀⠀⠀⢀⣤⠶⠦⡀⠀⠀⠀⠀⠀⠀⠀⠀'),
    writeln('⠀⠀⠀⠀⠀⠀⠀⢀⠴⡟⠛⠂⣼⠟⠸⠿⣷⣿⣷⡒⢿⡃⠘⣛⠾⣤⠀⠀⠀⠀⠀⠀⠀'),
    writeln('⠀⠀⠀⠀⠀⠀⡠⣥⢿⠟⣠⡾⠁⢘⣻⠿⠈⣯⣍⠻⡀⢿⣦⠹⡻⡌⢱⠀⠀⠀⠀⠀⠀'),
    writeln('⠀⠀⠀⠀⠀⡰⢻⡇⡞⣼⡟⢡⡾⣻⠏⢠⣶⡙⠻⡛⢿⡸⣿⡄⠁⢻⡘⣦⡀⠀⠀⠀⠀'),
    writeln('⠀⠀⠀⠀⢀⡇⣿⢸⢳⣿⢡⠏⡴⢋⣴⣿⣿⣿⣦⡈⢶⣧⢻⣧⠀⠘⡇⣀⢷⠀⠀⠀⠀'),
    writeln('⢀⡤⣠⠤⠼⠡⠏⣾⢸⣿⠘⣪⣥⣉⣩⣿⣿⣿⣦⣶⣶⡝⢸⣿⠀⠇⢃⣟⣸⠤⠤⢤⡤'),
    writeln('⠀⠙⢖⣬⣅⢠⢀⠐⢸⣏⠘⡗⠒⠚⣿⣿⣿⣿⡟⠒⠚⡏⡼⣿⠀⢺⠃⣀⣾⢠⠟⠋⠀'),
    writeln('⠀⠀⠀⠁⡜⣿⣺⣧⡀⠻⡀⢹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣏⢽⡟⠰⠬⠾⠗⠐⠍⠀⠀⠀'),
    writeln('⠀⠀⠀⣸⠃⡇⢺⡆⣠⣄⠁⠈⣿⣿⣏⠿⡻⢏⣿⣿⣿⣿⢘⣡⡆⡄⣾⡌⠷⠅⠀⠀⠀'),
    writeln('⠀⠀⠀⢁⢰⣇⢸⡃⣿⢉⣡⣤⣬⠙⠻⠿⠿⠿⠿⢛⣋⣀⡈⢩⣥⣅⠙⢓⣬⣇⡀⠀⠀'),
    writeln('⠀⠀⠀⡌⢸⣿⢸⣇⢰⣿⣿⡏⣴⣦⣤⣤⣶⣶⡆⣿⣿⣿⣿⢸⣿⣿⠸⣿⡿⢖⢺⠀⠀'),
    writeln('⠀⠀⢠⠁⣿⢿⡆⣿⠀⢻⣿⡇⣿⣿⣿⣿⣿⣿⡇⢸⣿⣿⡟⠸⣿⣿⠀⣿⣿⠯⡽⠀⠀'),
    writeln('⠀⢠⢱⣧⣿⢸⣧⢻⡇⠈⣻⣷⢸⣿⣿⣿⣿⣷⡶⣼⣿⠏⢁⣄⣼⡏⢠⣿⡧⢵⠃⠀⠀'),
    writeln('⠀⣸⣾⢻⢹⡈⣿⡘⣷⢸⣛⣛⠸⣿⣿⣿⣿⡿⠇⠟⡁⣠⣬⢉⡛⢁⣼⣿⡯⠭⠆⠀⠀'),
	writeln('Hola, mi nombre es Eliza. ¿En que puedo ayudarte?'),
	writeln(''),
	writeln('Consultas sobre Coronavirus (COVID-19) y Fiebre Tifoidea.'),
	writeln('Ingresa tu consulta en minusculas sin punto al final.'),
	writeln('Escribe "ayuda" para ver los comandos o "adios" para salir.'),
	writeln('================================================================='),
	readln(Input),
	eliza(Input),!.


% Condiciones de salida
eliza(Input) :- (Input == ['Adios'] ; Input == ['Adios', '.'] ; Input == [adios] ; Input == [adios, '.']),
	writeln('Adios. Espero haberte ayudado. Cuidate mucho.'), !.

% Bucle conversacional
eliza(Input) :-
	template(Stim, Resp, IndStim),
	match(Stim, Input),
	replace0(IndStim, Input, 0, Resp, R),
	escribir_respuesta(R),
	readln(Input1),
	eliza(Input1), !.

% Imprime la respuesta de manera legible respetando saltos de linea
escribir_respuesta([]) :- nl.
escribir_respuesta(['\n'|T]) :- nl, !, escribir_respuesta(T).
escribir_respuesta([H|T]) :- write(H), write(' '), escribir_respuesta(T).

















% ---------------- 1. TEMPLATES BASE DE ELIZA (SALUDOS Y CONVERSACION) ----------------

template([hola, mi, nombre, es, s(_)], ['Hola', 0, ', en que te puedo ayudar hoy?'], [4]).
template([hola, mi, nombre, es, s(_), '.'], ['Hola', 0, ', en que te puedo ayudar hoy?'], [4]).
template([buendia, mi, nombre, es, s(_)], ['Buen dia', 0, ', en que te puedo ayudar?'], [4]).
template([hola, _], ['Hola, como te sientes hoy? Puedes escribir "ayuda" para ver opciones.'], []).
template([hola], ['Hola, como te sientes hoy? Puedes escribir "ayuda" para ver opciones.'], []).
template([buendia, _], ['Buen dia, como estas? En que te puedo orientar?'], []).
template([buendia], ['Buen dia, como estas? En que te puedo orientar?'], []).
template([como, estas, _], ['Muy bien, lista para ayudarte con tus consultas medicas.'], []).
template([como, estas], ['Muy bien, lista para ayudarte con tus consultas medicas.'], []).
template([gracias, _], ['De nada, para eso estoy.'], []).
template([gracias], ['De nada, para eso estoy.'], []).
template([estoy, preocupado], ['Entiendo tu preocupacion. Tener sintomas desconocidos puede generar incertidumbre. Que es lo que mas te preocupa?'], []).
template([estoy, mejor], ['Me alegra escuchar eso. Aun asi, continua siguiendo las indicaciones del profesional que te atiende.'], []).
template([ya, me, siento, bien], ['Que buena noticia. Recuerda completar cualquier tratamiento prescrito y mantener las medidas preventivas indicadas.'], []).
template([no, quiero, ir, al, medico], ['Entiendo que no quieras acudir, pero una valoracion profesional es importante cuando hay sintomas persistentes, intensos o que empeoran.'], []).
template([no, entiendo], ['No hay problema. Puedo explicartelo de una manera mas sencilla. Que parte te gustaria comprender mejor?'], []).
template([estas, segura], ['Mi informacion tiene fines educativos y de orientacion. No sustituye un diagnostico ni la valoracion de un profesional de salud.'], []).
template([explicame, mejor], ['Por supuesto. Intentare explicarlo con palabras sencillas y ejemplos para que sea mas facil de comprender.'], []).
template([puedes, repetir], ['Claro que si. Puedes preguntarme nuevamente y te proporcionare la informacion.'], []).

template([ayuda], [
	'------------------- Guia de uso de Eliza (Sistema Experto Medico) -------------------', '\n',
	'[Enfermedades cubiertas: Coronavirus / Fiebre Tifoidea]', '\n',
	'- "diagnosticar"                    : Cuestionario interactivo general (6 preguntas)', '\n',
	'- "diagnosticar [enfermedad]"       : Diagnostico especifico (ej. diagnosticar coronavirus)', '\n',
	'- "sintomas de [enfermedad]"        : Lista los sintomas caracteristicos', '\n',
	'- "prevencion de [enfermedad]"      : Medidas para evitar el contagio', '\n',
	'- "tratamiento de [enfermedad]"     : Cuidados y recomendaciones medicas', '\n',
	'- "especialista de [enfermedad]"    : Medicos especialistas que atiendend el caso', '\n',
	'- "medicamentos de [enfermedad]"    : Farmacos y medicinas sugeridas', '\n',
	'- "factores de riesgo [enfermedad]" : Grupos vulnerables y alertas clinicas', '\n',
	'- "tengo [sintoma]"                 : Analisis con 1 sintoma (ej. tengo fiebre)', '\n',
	'- "tengo [s1] y [s2]"               : Analisis con 2 sintomas simultaneos', '\n',
	'- "tengo [s1] , [s2] y [s3]"        : Analisis con 3 o mas sintomas (ej. tengo fiebre , tos_seca y cansancio)', '\n',
	'- "mi temperatura es [valor]"       : Evalua el nivel de fiebre (ej. mi temperatura es 38.8)', '\n',
	'- "adios"                           : Salir del sistema', '\n',
	'---------------------------------------------------------------------------------------------------'
], []).


% ---------------- 2. TEMPLATES DEL SISTEMA EXPERTO MEDICO ----------------

% Listado general de enfermedades
template([que, enfermedades, conoces, _], ['Actualmente estoy entrenada para diagnosticar e informar sobre:', '\n',
										   '1. Coronavirus (COVID-19)', '\n',	'2. Fiebre Tifoidea'], []).
template([que, enfermedades, conoces], ['Actualmente estoy entrenada para diagnosticar e informar sobre:', '\n',
										'1. Coronavirus (COVID-19)', '\n',	'2. Fiebre Tifoidea'], []).
template([enfermedades], ['Actualmente estoy entrenada para diagnosticar e informar sobre:', '\n',
						  '1. Coronavirus (COVID-19)', '\n',	'2. Fiebre Tifoidea'], []).

% Diagnostico interactivo guiado (especifico primero, general despues)
template([diagnosticar, fiebre, tifoidea], [flagDiagEnfermedadEspecifica, tifoidea], []).
template([diagnosticar, s(_)], [flagDiagEnfermedad], [1]).
template([diagnosticar], [flagDiagnostico], []).
template([diagnostico, fiebre, tifoidea], [flagDiagEnfermedadEspecifica, tifoidea], []).
template([diagnostico, s(_)], [flagDiagEnfermedad], [1]).
template([diagnostico], [flagDiagnostico], []).
template([quiero, un, diagnostico, _], [flagDiagnostico], []).
template([quiero, un, diagnostico], [flagDiagnostico], []).
template([quiero, saber, que, tengo], [flagDiagnostico], []).
template([me, siento, mal], [flagDiagnostico], []).

% Consulta de sintomas (soporta "fiebre tifoidea" y un solo termino)
template([sintomas, de, fiebre, tifoidea], [flagSintomasExacto, tifoidea], []).
template([cuales, son, los, sintomas, de, fiebre, tifoidea], [flagSintomasExacto, tifoidea], []).
template([cuales, son, los, sintomas, del, s(_)], [flagSintomas], [5]).
template([cuales, son, los, sintomas, de, s(_)], [flagSintomas], [5]).
template([sintomas, del, s(_)], [flagSintomas], [2]).
template([sintomas, de, s(_)], [flagSintomas], [2]).

% Consulta de prevencion
template([como, prevenir, la, fiebre, tifoidea], [flagPrevencionExacto, tifoidea], []).
template([como, se, previene, la, fiebre, tifoidea], [flagPrevencionExacto, tifoidea], []).
template([prevencion, de, fiebre, tifoidea], [flagPrevencionExacto, tifoidea], []).
template([prevencion, de, la, fiebre, tifoidea], [flagPrevencionExacto, tifoidea], []).
template([como, prevenir, el, s(_)], [flagPrevencion], [3]).
template([como, prevenir, la, s(_)], [flagPrevencion], [3]).
template([como, prevenir, s(_)], [flagPrevencion], [2]).
template([como, evitar, el, s(_)], [flagPrevencion], [3]).
template([prevencion, del, s(_)], [flagPrevencion], [2]).
template([prevencion, de, s(_)], [flagPrevencion], [2]).

% Consulta de tratamiento y cuidados
template([como, tratar, la, fiebre, tifoidea], [flagTratamientoExacto, tifoidea], []).
template([tratamiento, de, fiebre, tifoidea], [flagTratamientoExacto, tifoidea], []).
template([tratamiento, para, la, fiebre, tifoidea], [flagTratamientoExacto, tifoidea], []).
template([como, curar, la, fiebre, tifoidea], [flagTratamientoExacto, tifoidea], []).
template([como, tratar, el, s(_)], [flagTratamiento], [3]).
template([como, tratar, la, s(_)], [flagTratamiento], [3]).
template([como, tratar, s(_)], [flagTratamiento], [2]).
template([tratamiento, del, s(_)], [flagTratamiento], [2]).
template([tratamiento, para, s(_)], [flagTratamiento], [2]).
template([tratamiento, de, s(_)], [flagTratamiento], [2]).

% Consulta de Medico Especialista
template([que, especialista, atiende, la, fiebre, tifoidea], [flagEspecialistaExacto, tifoidea], []).
template([que, especialista, atiende, fiebre, tifoidea], [flagEspecialistaExacto, tifoidea], []).
template([que, especialista, trata, la, fiebre, tifoidea], [flagEspecialistaExacto, tifoidea], []).
template([que, especialista, trata, fiebre, tifoidea], [flagEspecialistaExacto, tifoidea], []).
template([especialista, de, fiebre, tifoidea], [flagEspecialistaExacto, tifoidea], []).
template([especialista, para, fiebre, tifoidea], [flagEspecialistaExacto, tifoidea], []).
template([especialistas, de, fiebre, tifoidea], [flagEspecialistaExacto, tifoidea], []).
template([que, especialista, atiende, el, s(_)], [flagEspecialista], [4]).
template([que, especialista, atiende, la, s(_)], [flagEspecialista], [4]).
template([que, especialista, atiende, s(_)], [flagEspecialista], [3]).
template([que, especialista, trata, el, s(_)], [flagEspecialista], [4]).
template([que, especialista, trata, la, s(_)], [flagEspecialista], [4]).
template([que, especialista, trata, s(_)], [flagEspecialista], [3]).
template([que, especialista, recomiendas, para, s(_)], [flagEspecialista], [4]).
template([a, que, medico, voy, por, s(_)], [flagEspecialista], [5]).
template([a, que, especialista, voy, por, s(_)], [flagEspecialista], [5]).
template([especialista, del, s(_)], [flagEspecialista], [2]).
template([especialista, de, s(_)], [flagEspecialista], [2]).
template([especialistas, de, s(_)], [flagEspecialista], [2]).
template([especialista, para, s(_)], [flagEspecialista], [2]).

% Consulta de Medicamentos puntuales
template([que, medicamentos, se, usan, para, fiebre, tifoidea], [flagMedicamentoExacto, tifoidea], []).
template([que, medicamento, se, usa, para, fiebre, tifoidea], [flagMedicamentoExacto, tifoidea], []).
template([que, medicamentos, hay, para, fiebre, tifoidea], [flagMedicamentoExacto, tifoidea], []).
template([medicamentos, de, fiebre, tifoidea], [flagMedicamentoExacto, tifoidea], []).
template([medicamentos, para, fiebre, tifoidea], [flagMedicamentoExacto, tifoidea], []).
template([medicinas, para, fiebre, tifoidea], [flagMedicamentoExacto, tifoidea], []).
template([que, medicamento, debo, tomar, para, el, s(_)], [flagMedicamento], [7]).
template([que, medicamento, debo, tomar, para, la, s(_)], [flagMedicamento], [7]).
template([que, medicamento, debo, tomar, para, s(_)], [flagMedicamento], [6]).
template([que, medicamentos, se, usan, para, el, s(_)], [flagMedicamento], [6]).
template([que, medicamentos, se, usan, para, la, s(_)], [flagMedicamento], [6]).
template([que, medicamentos, se, usan, para, s(_)], [flagMedicamento], [5]).
template([que, medicamentos, hay, para, el, s(_)], [flagMedicamento], [5]).
template([que, medicamentos, hay, para, la, s(_)], [flagMedicamento], [5]).
template([que, medicamentos, hay, para, s(_)], [flagMedicamento], [4]).
template([que, medicina, tomo, para, el, s(_)], [flagMedicamento], [5]).
template([que, medicina, tomo, para, la, s(_)], [flagMedicamento], [5]).
template([que, medicina, tomo, para, s(_)], [flagMedicamento], [4]).
template([que, medicina, para, s(_)], [flagMedicamento], [3]).
template([medicamentos, del, s(_)], [flagMedicamento], [2]).
template([medicamentos, de, s(_)], [flagMedicamento], [2]).
template([medicamentos, para, s(_)], [flagMedicamento], [2]).
template([medicina, para, s(_)], [flagMedicamento], [2]).
template([medicinas, para, s(_)], [flagMedicamento], [2]).

% Factores de riesgo y signos vitales
template([factores, de, riesgo, de, fiebre, tifoidea], [flagRiesgoExacto, tifoidea], []).
template([factores, de, riesgo, fiebre, tifoidea], [flagRiesgoExacto, tifoidea], []).
template([factores, de, riesgo, de, s(_)], [flagRiesgo], [4]).
template([factores, de, riesgo, del, s(_)], [flagRiesgo], [4]).
template([factores, de, riesgo, s(_)], [flagRiesgo], [3]).

template([mi, temperatura, es, s(_)], [flagTemperatura], [3]).
template([temperatura, de, s(_)], [flagTemperatura], [2]).

% Motor de busqueda por sintomas (3 o mas, 2 sintomas, o 1 sintoma)
% Coincidencias de 3 sintomas (con y sin coma)
template([tengo, los, sintomas, s(_), ',', s(_), y, s(_)], [flagTresSintomas], [3, 5, 7]).
template([mis, sintomas, son, s(_), ',', s(_), y, s(_)], [flagTresSintomas], [3, 5, 7]).
template([tengo, s(_), ',', s(_), y, s(_)], [flagTresSintomas], [1, 3, 5]).
template([tengo, s(_), s(_), y, s(_)], [flagTresSintomas], [1, 2, 4]).
template([mis, sintomas, son, s(_), s(_), y, s(_)], [flagTresSintomas], [3, 4, 6]).

% Coincidencias de 2 sintomas
template([tengo, los, sintomas, s(_), y, s(_)], [flagDosSintomas], [3, 5]).
template([mis, sintomas, son, s(_), y, s(_)], [flagDosSintomas], [3, 5]).
template([tengo, s(_), y, s(_)], [flagDosSintomas], [1, 3]).

% Sintomas individuales compuestos (2 palabras)
template([tengo, tos, seca], [flagBuscarSintomaExacto, tos_seca], []).
template([tengo, dolor, abdominal], [flagBuscarSintomaExacto, dolor_abdominal], []).
template([tengo, dolor, de, cabeza], [flagBuscarSintomaExacto, dolor_cabeza], []).
template([tengo, dolor, de, garganta], [flagBuscarSintomaExacto, dolor_garganta], []).
template([tengo, dificultad, para, respirar], [flagBuscarSintomaExacto, dificultad_respiratoria], []).
template([tengo, perdida, de, olfato], [flagBuscarSintomaExacto, perdida_olfato], []).
template([tengo, perdida, de, gusto], [flagBuscarSintomaExacto, perdida_gusto], []).
template([tengo, manchas, rosadas], [flagBuscarSintomaExacto, manchas_rosadas], []).

% Sintoma individual generico (1 sintoma)
template([tengo, s(_)], [flagBuscarSintoma], [1]).
template([que, enfermedad, causa, s(_)], [flagBuscarSintoma], [3]).

% Respuesta por defecto cuando no hay coincidencia
template(_, ['No entendi muy bien tu consulta.', '\n', 'Escribe "ayuda" para ver la lista de comandos disponibles.'], []).























% ---------------- 3. BASE DE CONOCIMIENTO MEDICA (HECHOS Y REGLAS) ----------------

% Declaracion de enfermedades
enfermedad(coronavirus).
enfermedad(tifoidea).

% Sinonimos de enfermedades para lenguaje natural
normalizar_enfermedad(coronavirus, coronavirus).
normalizar_enfermedad(covid, coronavirus).
normalizar_enfermedad(covid19, coronavirus).
normalizar_enfermedad(covid_19, coronavirus).
normalizar_enfermedad(sars, coronavirus).
normalizar_enfermedad(tifoidea, tifoidea).
normalizar_enfermedad(fiebre_tifoidea, tifoidea).

nombre_bonito(coronavirus, 'Coronavirus (COVID-19)').
nombre_bonito(tifoidea, 'Fiebre Tifoidea').

% a) Sintomas de Coronavirus
sintoma_de(coronavirus, fiebre).
sintoma_de(coronavirus, tos_seca).
sintoma_de(coronavirus, cansancio).
sintoma_de(coronavirus, dificultad_respiratoria).
sintoma_de(coronavirus, perdida_olfato).
sintoma_de(coronavirus, perdida_gusto).
sintoma_de(coronavirus, dolor_cabeza).
sintoma_de(coronavirus, dolor_garganta).
sintoma_de(coronavirus, dolor_muscular).
sintoma_de(coronavirus, diarrea).
sintoma_de(coronavirus, congestion_nasal).
sintoma_de(coronavirus, opresion_pecho).

% b) Sintomas de Fiebre Tifoidea
sintoma_de(tifoidea, fiebre).
sintoma_de(tifoidea, fiebre_alta).
sintoma_de(tifoidea, dolor_abdominal).
sintoma_de(tifoidea, dolor_cabeza).
sintoma_de(tifoidea, debilidad).
sintoma_de(tifoidea, perdida_apetito).
sintoma_de(tifoidea, diarrea).
sintoma_de(tifoidea, estrenimiento).
sintoma_de(tifoidea, manchas_rosadas).
sintoma_de(tifoidea, escalofrios).

% c) Medicos Especialistas recomendados
especialista_de(coronavirus, 'Neumologo (especialista en sistema respiratorio y funcion pulmonar)').
especialista_de(coronavirus, 'Infectologo (especialista en enfermedades virales y transmisibles)').
especialista_de(coronavirus, 'Medico Internista (evaluacion integral y manejo de casos moderados/severos)').

especialista_de(tifoidea, 'Gastroenterologo (especialista en tracto digestivo e intestinos)').
especialista_de(tifoidea, 'Infectologo (especialista en infecciones bacterianas sistemicas)').
especialista_de(tifoidea, 'Medico Internista o Medico General (diagnostico clinico y control)').

% d) Medicamentos y farmacos puntuales sugeridos
medicamento_de(coronavirus, 'Paracetamol (para el control de la fiebre y alivio del dolor corporal)').
medicamento_de(coronavirus, 'Suero oral y liquidos abundantes (hidratacion constante indispensable)').
medicamento_de(coronavirus, 'Antivirales especificos (Paxlovid o Remdesivir, unicamente bajo prescripcion medica autorizada)').

medicamento_de(tifoidea, 'Antibioticos especificos (Ciprofloxacino, Azitromicina o Ceftriaxona bajo receta medica obligatoria)').
medicamento_de(tifoidea, 'Paracetamol (para controlar la fiebre alta continua)').
medicamento_de(tifoidea, 'Solucion de rehidratacion oral (electrolitos para reponer perdidas digestivas)').

% e) Factores de riesgo
riesgo_de(coronavirus, 'Adultos mayores de 60 anios o ninos menores de 5 anios').
riesgo_de(coronavirus, 'Comorbilidades: diabetes, hipertension, obesidad, asma o EPOC').
riesgo_de(coronavirus, 'Mujeres embarazadas o personas inmunodeprimidas').
riesgo_de(coronavirus, 'Contacto previo con caso confirmado en los ultimos 2 a 14 dias').

riesgo_de(tifoidea, 'Tomar agua sin hervir, sin clorar o de origen dudoso').
riesgo_de(tifoidea, 'Comer alimentos mal lavados o preparados sin higiene en la via publica').
riesgo_de(tifoidea, 'No lavarse las manos antes de comer o despues de ir al bano').
riesgo_de(tifoidea, 'Contacto con portadores o zonas con saneamiento deficiente').

% f) Prevencion
prevencion_de(coronavirus, 'Lavar frecuentemente manos con agua y jabon o usar gel antibacterial al 70%').
prevencion_de(coronavirus, 'Usar cubrebocas en lugares cerrados, concurridos o con poca ventilacion').
prevencion_de(coronavirus, 'Mantener distancia de al menos 1.5 metros de personas que tosan o estornuden').
prevencion_de(coronavirus, 'Ventilar habitaciones abriendo puertas y ventanas').
prevencion_de(coronavirus, 'Contar con el esquema de vacunacion y refuerzos al dia').

prevencion_de(tifoidea, 'Beber unicamente agua hervida, embotellada o clorada').
prevencion_de(tifoidea, 'Lavar y desinfectar frutas y verduras antes de consumirlas').
prevencion_de(tifoidea, 'Cocinar completamente carnes, pescados y mariscos').
prevencion_de(tifoidea, 'Lavarse las manos minuciosamente antes de manipular alimentos y despues de ir al bano').
prevencion_de(tifoidea, 'Evitar consumir alimentos en puestos ambulantes de dudosa higiene').

% g) Tratamiento general
tratamiento_de(coronavirus, 'Guardar reposo absoluto en casa y aislarse para evitar contagiar a otros').
tratamiento_de(coronavirus, 'Mantener hidratacion abundante tomando agua y electrolitos').
tratamiento_de(coronavirus, 'Tomar paracetamol para controlar la fiebre y dolor (evitar automedicarte con antibioticos)').
tratamiento_de(coronavirus, 'Monitorear la temperatura y acudir a urgencias si hay dificultad para respirar').

tratamiento_de(tifoidea, 'Tomar antibioticos especificos recetados por el medico y completar el tratamiento').
tratamiento_de(tifoidea, 'Hidratacion abundante con suero oral para evitar deshidratacion').
tratamiento_de(tifoidea, 'Seguir una dieta blanda y ligera, evitando irritantes y grasas').
tratamiento_de(tifoidea, 'Guardar reposo y acudir de inmediato a urgencias si hay dolor abdominal agudo').





















% ---------------- 4. PREDICADOS DE CONSULTA MEDICA Y DIAGNOSTICO ----------------

% Consulta dinamica de sintomas
consultar_sintomas(Entrada, R) :-
	normalizar_enfermedad(Entrada, Enf),
	nombre_bonito(Enf, Nombre),
	findall(S, sintoma_de(Enf, S), Lista),
	formatear_lista(Lista, TextoLista),
	R = ['Sintomas principales de', Nombre, ':', '\n', TextoLista], !.
consultar_sintomas(Entrada, ['No tengo informacion registrada sobre la enfermedad:', Entrada]).

% Consulta dinamica de prevencion
consultar_prevencion(Entrada, R) :-
	normalizar_enfermedad(Entrada, Enf),
	nombre_bonito(Enf, Nombre),
	findall(M, prevencion_de(Enf, M), Lista),
	formatear_lineas(Lista, Lineas),
	append(['Medidas de prevencion para', Nombre, ':'], Lineas, R), !.
consultar_prevencion(Entrada, ['No tengo medidas de prevencion para:', Entrada]).

% Consulta dinamica de tratamiento
consultar_tratamiento(Entrada, R) :-
	normalizar_enfermedad(Entrada, Enf),
	nombre_bonito(Enf, Nombre),
	findall(T, tratamiento_de(Enf, T), Lista),
	formatear_lineas(Lista, Lineas),
	append(['Tratamiento y cuidados para', Nombre, ':'], Lineas, R), !.
consultar_tratamiento(Entrada, ['No tengo informacion de tratamiento para:', Entrada]).

% Consulta dinamica de Medicos Especialistas
consultar_especialista(Entrada, R) :-
	normalizar_enfermedad(Entrada, Enf),
	nombre_bonito(Enf, Nombre),
	findall(E, especialista_de(Enf, E), Lista),
	formatear_lineas(Lista, Lineas),
	append(['Especialistas recomendados para', Nombre, ':'], Lineas, R), !.
consultar_especialista(Entrada, ['No tengo informacion de especialistas para:', Entrada]).

% Consulta dinamica de Medicamentos puntuales
consultar_medicamentos(Entrada, R) :-
	normalizar_enfermedad(Entrada, Enf),
	nombre_bonito(Enf, Nombre),
	findall(Med, medicamento_de(Enf, Med), Lista),
	formatear_lineas(Lista, Lineas),
	append(['Medicamentos y farmacos sugeridos para', Nombre, '(consulta siempre con un medico):'], Lineas, R), !.
consultar_medicamentos(Entrada, ['No tengo informacion de medicamentos para:', Entrada]).

% Consulta dinamica de factores de riesgo
consultar_riesgo(Entrada, R) :-
	normalizar_enfermedad(Entrada, Enf),
	nombre_bonito(Enf, Nombre),
	findall(F, riesgo_de(Enf, F), Lista),
	formatear_lineas(Lista, Lineas),
	append(['Factores de riesgo para', Nombre, ':'], Lineas, R), !.
consultar_riesgo(Entrada, ['No tengo factores de riesgo registrados para:', Entrada]).

% Contador auxiliar de coincidencias de una lista de sintomas con una enfermedad
coincidencias_sintomas([], _, 0).
coincidencias_sintomas([S|Resto], Enf, Total) :-
	sintoma_de(Enf, S), !,
	coincidencias_sintomas(Resto, Enf, T1),
	Total is T1 + 1.
coincidencias_sintomas([_|Resto], Enf, Total) :-
	coincidencias_sintomas(Resto, Enf, Total).

% Busqueda inversa: dado 1 sintoma
buscar_por_sintoma(Sintoma, R) :-
	findall(Nombre, (sintoma_de(E, Sintoma), nombre_bonito(E, Nombre)), Enfs),
	Enfs \= [],
	formatear_lista(Enfs, Texto),
	R = ['El sintoma', Sintoma, 'puede presentarse en:', Texto, '\n', 'Escribe "diagnosticar" para hacer una evaluacion completa.'], !.
buscar_por_sintoma(Sintoma, ['No encontre', Sintoma, 'en mis registros de Coronavirus o Fiebre Tifoidea.']).

% Busqueda inversa con 2 sintomas simultaneos
buscar_dos_sintomas(S1, S2, R) :-
	coincidencias_sintomas([S1, S2], coronavirus, C_Covid),
	coincidencias_sintomas([S1, S2], tifoidea, C_Tif),
	( (C_Covid > 0 ; C_Tif > 0) ->
		( C_Covid > C_Tif ->
			R = ['Con', S1, 'y', S2, 'hay mayor coincidencia con Coronavirus (COVID-19) (', C_Covid, 'de 2 sintomas).', '\n',
				 'Escribe "diagnosticar" para confirmar o "tratamiento de coronavirus".']
		; C_Tif > C_Covid ->
			R = ['Con', S1, 'y', S2, 'hay mayor coincidencia con Fiebre Tifoidea (', C_Tif, 'de 2 sintomas).', '\n',
				 'Escribe "diagnosticar" para confirmar o "tratamiento de tifoidea".']
		;	R = ['La combinacion de', S1, 'y', S2, 'coincide con ambas enfermedades (Coronavirus y Fiebre Tifoidea).', '\n',
				 'Escribe "diagnosticar" para hacer un diagnostico diferencial guiado.']
		)
	;	R = ['No encontre una enfermedad que combine exactamente', S1, 'y', S2, 'en mis registros.']
	), !.

% Busqueda inversa con 3 o mas sintomas simultaneos
buscar_tres_sintomas(S1, S2, S3, R) :-
	coincidencias_sintomas([S1, S2, S3], coronavirus, C_Covid),
	coincidencias_sintomas([S1, S2, S3], tifoidea, C_Tif),
	( (C_Covid > 0 ; C_Tif > 0) ->
		( C_Covid > C_Tif ->
			R = ['Con los sintomas', S1, ',', S2, 'y', S3, 'hay mayor coincidencia con Coronavirus (COVID-19) (', C_Covid, 'de 3 sintomas coincidentes).', '\n',
				 'Escribe "diagnosticar" para confirmar o "tratamiento de coronavirus".']
		; C_Tif > C_Covid ->
			R = ['Con los sintomas', S1, ',', S2, 'y', S3, 'hay mayor coincidencia con Fiebre Tifoidea (', C_Tif, 'de 3 sintomas coincidentes).', '\n',
				 'Escribe "diagnosticar" para confirmar o "tratamiento de tifoidea".']
		;	R = ['Los sintomas', S1, ',', S2, 'y', S3, 'coinciden con ambas enfermedades (', C_Covid, 'sintomas en cada una).', '\n',
				 'Escribe "diagnosticar" para realizar el cuestionario diferencial.']
		)
	;	R = ['Ninguno de los sintomas (', S1, ',', S2, ',', S3, ') coincide con mis registros de Coronavirus o Tifoidea.']
	), !.

% Evaluacion de signos vitales (temperatura corporal)
evaluar_temperatura(Valor, R) :-
	number(Valor),
	( Valor =< 37.0 -> R = ['Temperatura de', Valor, 'C: Nivel NORMAL (36.0 - 37.0 C).']
	; Valor =< 38.0 -> R = ['Temperatura de', Valor, 'C: FEBRICULA (37.1 - 38.0 C). Mantente en observacion.']
	; Valor =< 38.4 -> R = ['Temperatura de', Valor, 'C: FIEBRE LEVE (38.1 - 38.4 C). Hidratate y monitorea sintomas.']
	; Valor =< 38.9 -> R = ['Temperatura de', Valor, 'C: FIEBRE MODERADA (38.5 - 38.9 C). Consulta a tu medico.']
	; R = ['Temperatura de', Valor, 'C: FIEBRE ALTA (>= 39.0 C). Requiere valoracion medica prioritaria.']
	), !.
evaluar_temperatura(Valor, ['Por favor ingresa un numero valido de temperatura, por ejemplo: mi temperatura es 38.5 (recibi:', Valor, ').']).

% Diagnostico interactivo paso a paso (preguntas si/no)
iniciar_diagnostico(R) :-
	nl,
	writeln('--- INICIANDO DIAGNOSTICO MEDICO ---'),
	writeln('Responde con "si" o "no" (en minusculas, sin punto):'),
	preguntar('1. Tienes fiebre (>= 38 C)?', P_Fiebre),
	preguntar('2. Tienes tos seca, dolor de garganta o perdida de olfato/gusto?', P_Resp),
	preguntar('3. Tienes dificultad para respirar u opresion en el pecho?', P_Disnea),
	preguntar('4. Tuviste contacto con un caso confirmado de COVID-19 recientemente?', P_Contacto),
	preguntar('5. Tienes dolor abdominal, perdida de apetito o manchas rosadas?', P_Abd),
	preguntar('6. Consumiste agua sin purificar o comida en la calle recientemente?', P_Agua),
	calcular_puntaje(P_Fiebre, P_Resp, P_Disnea, P_Contacto, P_Abd, P_Agua, CovidPts, TifPts),
	generar_veredicto(CovidPts, TifPts, R).

preguntar(Texto, Resp) :-
	write(Texto), write(' '), flush_output,
	readln(Entrada),
	( (Entrada == [si] ; Entrada == [s]) -> Resp = 1 ; Resp = 0 ).

calcular_puntaje(Fiebre, Resp, Disnea, Contacto, Abd, Agua, CovidPts, TifPts) :-
	CovidPts is Fiebre + (Resp * 2) + (Disnea * 2) + Contacto,
	TifPts is Fiebre + (Abd * 2) + (Agua * 2).

generar_veredicto(CovidPts, TifPts, R) :-
	CovidPts >= 3, CovidPts > TifPts, !,
	R = ['RESULTADO DEL DIAGNOSTICO: Alta probabilidad de CORONAVIRUS (COVID-19) (', CovidPts, 'pts vs', TifPts, 'pts tifoidea).', '\n',
		'Recomendacion: Guarda reposo en casa y escribe "tratamiento de coronavirus".'].

generar_veredicto(CovidPts, TifPts, R) :-
	TifPts >= 3, TifPts > CovidPts, !,
	R = ['RESULTADO DEL DIAGNOSTICO: Alta probabilidad de FIEBRE TIFOIDEA (', TifPts, 'pts vs', CovidPts, 'pts COVID).', '\n',
		'Recomendacion: Acude al medico para estudios clinicos y escribe "tratamiento de tifoidea".'].

generar_veredicto(CovidPts, TifPts, R) :-
	CovidPts >= 3, TifPts >= 3, !,
	R = ['RESULTADO DEL DIAGNOSTICO: Presentas sintomas compatibles con ambas (COVID:', CovidPts, 'pts, Tifoidea:', TifPts, 'pts).', '\n',
		'Recomendacion: Acude a revision medica presencial para prueba confirmatoria.'].

generar_veredicto(CovidPts, TifPts, R) :-
	R = ['RESULTADO DEL DIAGNOSTICO: Sintomas insuficientes para confirmar COVID-19 (', CovidPts, 'pts) o Fiebre Tifoidea (', TifPts, 'pts).', '\n',
		'Mantente hidratado y en observacion; si empeoran los sintomas consulta a un medico.'].

% Diagnostico enfocado a una sola enfermedad
diagnosticar_especifico(Entrada, R) :-
	normalizar_enfermedad(Entrada, coronavirus), !,
	nl, writeln('--- EVALUACION ESPECIFICA: CORONAVIRUS (COVID-19) ---'),
	preguntar('Tienes fiebre (>= 38 C)? (si/no)', P1),
	preguntar('Tienes tos seca o perdida de olfato/gusto? (si/no)', P2),
	preguntar('Presentas dificultad para respirar o cansancio extremo? (si/no)', P3),
	Total is P1 + P2 + P3,
	( Total >= 2 ->
		R = ['Resultado: Coincides con', Total, 'de 3 criterios clave de COVID-19. Escribe "tratamiento de coronavirus" o acude al medico.']
	;	R = ['Resultado: Bajo indicio de COVID-19 (', Total, 'de 3 criterios). Sigue medidas de prevencion.']
	).

diagnosticar_especifico(Entrada, R) :-
	normalizar_enfermedad(Entrada, tifoidea), !,
	nl, writeln('--- EVALUACION ESPECIFICA: FIEBRE TIFOIDEA ---'),
	preguntar('Tienes fiebre alta prolongada? (si/no)', P1),
	preguntar('Presentas dolor abdominal, debilidad o perdida de apetito? (si/no)', P2),
	preguntar('Tuviste diarrea/estrenimiento tras ingerir agua o comida dudosa? (si/no)', P3),
	Total is P1 + P2 + P3,
	( Total >= 2 ->
		R = ['Resultado: Coincides con', Total, 'de 3 criterios clave de Fiebre Tifoidea. Escribe "tratamiento de tifoidea" o acude al medico.']
	;	R = ['Resultado: Bajo indicio de Fiebre Tifoidea (', Total, 'de 3 criterios). Sigue medidas de higiene.']
	).

diagnosticar_especifico(Entrada, ['Solo puedo diagnosticar coronavirus o fiebre tifoidea, no:', Entrada]).

% Helpers de formato para listas
formatear_lista([], '').
formatear_lista([X], X) :- !.
formatear_lista([H|T], Texto) :-
	formatear_lista(T, Resto),
	atomic_list_concat([H, ', ', Resto], Texto).

formatear_lineas([], []).
formatear_lineas([H|T], ['\n', '-', H | Resto]) :-
	formatear_lineas(T, Resto).















% ---------------- 5. MOTOR DE EMPAREJAMIENTO Y SUSTITUCION (match y replace0) ----------------

match([], []).
match([], _) :- true.

match([S|Stim], [I|Input]) :-
	atom(S),
	S == I,
	match(Stim, Input), !.

match([S|Stim], [_|Input]) :-
	\+atom(S),
	match(Stim, Input), !.

% Flags sin captura de variable (IndStim = [])
replace0([], _, _, [flagDiagnostico], R) :- !, iniciar_diagnostico(R).
replace0([], _, _, [flagDiagEnfermedadEspecifica, Enf], R) :- !, diagnosticar_especifico(Enf, R).
replace0([], _, _, [flagSintomasExacto, Enf], R) :- !, consultar_sintomas(Enf, R).
replace0([], _, _, [flagPrevencionExacto, Enf], R) :- !, consultar_prevencion(Enf, R).
replace0([], _, _, [flagTratamientoExacto, Enf], R) :- !, consultar_tratamiento(Enf, R).
replace0([], _, _, [flagEspecialistaExacto, Enf], R) :- !, consultar_especialista(Enf, R).
replace0([], _, _, [flagMedicamentoExacto, Enf], R) :- !, consultar_medicamentos(Enf, R).
replace0([], _, _, [flagRiesgoExacto, Enf], R) :- !, consultar_riesgo(Enf, R).
replace0([], _, _, [flagBuscarSintomaExacto, Sintoma], R) :- !, buscar_por_sintoma(Sintoma, R).

% Caso base sin flag
replace0([], _, _, Resp, R) :- append(Resp, [], R), !.

% Flags medicos con 1 argumento
replace0([I|_], Input, _, [flagDiagEnfermedad], R) :- !, nth0(I, Input, Atom), diagnosticar_especifico(Atom, R).
replace0([I|_], Input, _, [flagSintomas], R) :- !, nth0(I, Input, Atom), consultar_sintomas(Atom, R).
replace0([I|_], Input, _, [flagPrevencion], R) :- !, nth0(I, Input, Atom), consultar_prevencion(Atom, R).
replace0([I|_], Input, _, [flagTratamiento], R) :- !, nth0(I, Input, Atom), consultar_tratamiento(Atom, R).
replace0([I|_], Input, _, [flagEspecialista], R) :- !, nth0(I, Input, Atom), consultar_especialista(Atom, R).
replace0([I|_], Input, _, [flagMedicamento], R) :- !, nth0(I, Input, Atom), consultar_medicamentos(Atom, R).
replace0([I|_], Input, _, [flagRiesgo], R) :- !, nth0(I, Input, Atom), consultar_riesgo(Atom, R).
replace0([I|_], Input, _, [flagBuscarSintoma], R) :- !, nth0(I, Input, Atom), buscar_por_sintoma(Atom, R).
replace0([I|_], Input, _, [flagTemperatura], R) :- !, nth0(I, Input, Atom), evaluar_temperatura(Atom, R).

% Flag medico con 2 sintomas
replace0([I1, I2|_], Input, _, [flagDosSintomas], R) :- !,
	nth0(I1, Input, S1),
	nth0(I2, Input, S2),
	buscar_dos_sintomas(S1, S2, R).

% Flag medico con 3 sintomas
replace0([I1, I2, I3|_], Input, _, [flagTresSintomas], R) :- !,
	nth0(I1, Input, S1),
	nth0(I2, Input, S2),
	nth0(I3, Input, S3),
	buscar_tres_sintomas(S1, S2, S3, R).

% Sustitucion posicional generica (0, 1, ...)
replace0([I|Index], Input, N, Resp, R) :-
	length(Index, M), M =:= 0,
	nth0(I, Input, Atom),
	select(N, Resp, Atom, R1), append(R1, [], R), !.

replace0([I|Index], Input, N, Resp, R) :-
	nth0(I, Input, Atom),
	length(Index, M), M > 0,
	select(N, Resp, Atom, R1),
	N1 is N + 1,
	replace0(Index, Input, N1, R1, R), !.
