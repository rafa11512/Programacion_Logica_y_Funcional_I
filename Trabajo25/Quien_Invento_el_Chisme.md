# Analisis Comparativo: IA Local (llama3.1:latest) vs. IA en la Nube (Gemini) en Resolucion de Casos

# ¿Quien Invento el Chisme?

---

Para evaluar las diferencias reales de razonamiento, precision y manejo de contexto entre un modelo de lenguaje ejecutado localmente y un modelo fundacional de gran escala en la nube, se sometio a ambos sistemas exactamente al mismo desafio: resolver el Caso Aurora (CASO_AURORA_SIN_COMPUTADORA_ALUMNOS (1).pdf), un juego forense de 11 paginas compuesto por 36 tarjetas de evidencia, reglas estrictas, desfases horarios en cuatro relojes distintos, testimonios contradictorios y conteo de conjuntos con duplicados.

* Modelos y Entornos Evaluados
    * **IA Local**: `llama3.1:latest` (8B parámetros) ejecutado de forma privada a través de AnythingLLM (workspace optimizado) con recuperación documental (RAG).
    * **IA Grande (Nube)**: `Google Gemini` con procesamiento directo del documento PDF completo en su ventana de contexto nativa.

---

### Prompt Utilizado

A ambos modelos se les proporcionó exactamente la misma instrucción (prompt) para garantizar una comparación justa:

* Prompt:

"Analiza y resuelve completamente el caso Aurora del PDF adjunto, examinando las 36 tarjetas de evidencia y respondiendo todas las preguntas y actividades de las hojas de trabajo. Presenta las respuestas, cronologia, calculos, responsables y veredicto final, justificando cada conclusion con las tarjetas correspondientes, sin inventar informacion."

---

### Analisis de Resultados por Modelo

#### A. Desempeño de Gemini (IA Grande en la Nube)
Gemini proceso las 36 tarjetas y resolvio el 100% del caso sin errores logicos ni matematicos:
* Calibración de relojes: Aplicó correctamente cada desfase (CAF +4 min, PAT -3 min, TAL -6 min, BIB 0 min) a todas las tarjetas sin perder el hilo.
* Detección de coartadas falsas: Cruzó las Tarjetas 03, 06, 11 y 12 para demostrar que Celia mintió al culpar a Joel (a las 09:12 Celia estaba entrando a la oficina y Joel estaba dentro de la biblioteca de 09:09 a 09:18).
* Separación de roles (Autoría vs. Modificación vs. Amplificación):
    *  Inventora ($V_0$): Celia (09:14 real, folio rosa 42, Tarjetas 08, 25, 26, 27).
    * Modificador 1 ($V_1$ - Sala VIP): Diego (09:22 real, borrador amarillo, Tarjetas 14, 16, 29, 30)
    * Modificador 2 ($V_2$ - Confirmación Dirección): Hugo (09:26 real, Tarjetas 17, 19, 32).
    * Mayor Amplificadora: Elisa (24 volantes entregados, 18 lectores unicos, Tarjeta 33).
* Cálculo de conjuntos: Calculo correctamente la unión de lectores unicos: $18 + 6 + 3 - 1 = 26$ (descontando duplicados internos y el código 07 compartido entre Elisa y Hugo).

#### B.Desempeño de llama3.1:latest (IA Local en AnythingLLM)
Se analizaron dos ejecuciones del modelo local. Aunque demostro buena capacidad para estructurar tablas y seguir el formato solicitado, presento fallos criticos de razonamiento cruzado y alucinaciones al intentar integrar las 36 tarjetas:

* Ejecucion 1
    * **Acierto parcial**: Calculo bien los desfases iniciales de los relojes y el total de 26 lectores unicos ($18 + 5 + 3 = 26$).
    * **Error grave de autoria**: Atribuyo la invencion original ($V_0$) a Diego en lugar de Celia, confundiendo el borrador amarillo de las 09:28 (Tarjeta 16) con el inicio del rumor, a pesar de haber listado el folio rosa 42 de Celia (09:14) en su propia tabla cronologica.
    * **Inconsistencia temporal en la matriz**: En la matriz de transmisiones escribio que Diego hablo con Fabiola antes de que Fabiola recibiera el mensaje de Celia, rompiendo la causalidad temporal.

* Ejecucion 2
    * **Caida en la trampa narrativa (Alucinacion)**: Creyo la coartada falsa de Celia y concluyo que Joel invento el rumor a las 09:11 (Tarjeta 05), afirmando que "alguien copió su pregunta sin signo de interrogación" y que "Joel se lo dijo a Celia a las 09:12".
    * **Desalineacion de tarjetas (RAG chunking)**: Corrio la numeracion de las tarjetas (Tarjeta 01 la reporto como el aviso de la 02, Tarjeta 02 como la 03, etc.) y solo cito hasta la Tarjeta 10 en la cronologia, omitiendo la calibracion de relojes y dando por "Confiable" la declaracion falsa de Celia (Tarjeta 11).
    * **Falta de calculos**: No desgloso la tabla de lectores unicos ni realizo la resta de interseccion del codigo 07.

---

### Comparativa entre ambas

|Criterio                    |IA Local (llama3.1:latest + AnythingLLM) | IA Grande (Gemini)                       |
|----------------------------|-----------------------------------------|------------------------|
|Privacidad y Soberania      | Excelente (100% local). Ningun dato sale de la computadora; ideal para documentos confidenciales.                                        |  Dependiente de la nube. Requiere enviar el documento a servidores externos.                      |
|Costo Operativo             |  Gratis / Hardware propio (sin limites de tokens ni suscripciones).                                       | Freemium / Pago por uso segun plan o API.                       |
|Ventana de Contexto y RAG   |  Limitada en la practica; al fragmentar el PDF en chunks, pierde la vision global entre tarjetas lejanas (ej. Tarjeta 01 vs. Tarjeta 31).                                       | Contexto masivo nativo. Lee todo el PDF simultaneamente sin fragmentarlo ni perder referencias cruzadas.                       |
|Razonamiento Multi-salto    | Débil en cadenas largas. Le cuesta cruzar 4 o 5 pistas simultaneas (reloj + ubicacion + testigo + hora real).                                        | Muy solido. Triangula multiples fuentes y detecta contradicciones ocultas.                       |
|Consistencia entre intentos | Variable. En un intento culpo a Diego y en el otro cayo en la trampa de culpar a Joel.                                        | Alta estabilidad. Mantiene coherencia logica estricta de principio a fin.                       |
|Precision Matematica        | Regular (acerto en el primer intento, pero omitio el conteo en el segundo).                                        | Exacta (resolvio desfases horarios y teoria de conjuntos sin fallos).                       |

---

### ¿Cuundo usar cada una?

1. ¿Que tan buena es llama3.1:latest (IA Local)?
Muy buena para tareas de privacidad estricta, resumenes rapidos, extraccion de datos simples, redaccion asistida, clasificacion basica y trabajo offline sin costo por consultad
* Sus limitaciones: Cuando el problema exige deduccion lgica compleja, cruces de multiples documentos, aritmetica temporal estricta o deteccion de engaños, un modelo de 8B parametros tiende a perder coherencia, mezclar indices o aceptar afirmaciones falsas como verdaderas

2. ¿Que tan buena es Gemini (IA Grande)?
Muy buena para analisis forense, auditoria de documentos extensos, razonamiento logico profundo, triangulacióo de evidencias y problemas matematicos/combinatorios donde un solo error invalida el resultado
* Sus limitaciones: Requiere conexion a internet y subir la informacion a la nube, lo cual puede ser una restriccion en entornos con datos altamente confidenciales

Por lo que la IA local es excelente como asistente privado y operativo para tareas cotidianas, pero para razonamiento analitico complejo y verificacion rigurosa, los modelos grandes como Gemini mantienen una ventaja en precision y capacidad deductiva