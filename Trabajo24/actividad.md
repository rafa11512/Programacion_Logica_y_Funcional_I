# **EL ENIGMA DE LA VITRINA K‐17** 

Investigación individual con RAG local y Prolog ∙Actividad avanzada de Programación Lógica 

### **Nombre y matrícula:**
Rafael Piedra Sanchez
23121141

**Fecha: 24/11/2026**
**Modelo local: qwen2.5:9b** 

## **La misión** 

El 18 de noviembre de 2026, el módulo original K17-O fue sustituido en una vitrina por K17-R, una réplica casi idéntica. El lector de acceso apunta hacia una persona; un préstamo de credencial podría cambiar la interpretación. El sensor marca un cambio de peso, pero la cámara, la impresora y el torno no comparten reloj. Un protocolo antiguo parece permitir un cambio que el vigente prohíbe. 

**Tu trabajo NO es conseguir que la IA adivine el nombre del culpable.** Eres investigador y experto: recuperas información con RAG, decides qué hechos están respaldados y escribes reglas en Prolog para que la conclusión sea reproducible. 

## **Condiciones de la actividad** 

- **Individual.** No hay equipos, ni roles repartidos. 
- **Corpus cerrado y ficticio.** No investigues personas reales ni añadas datos externos para resolver el caso.
- **Dos etapas obligatorias.** Indexa primero 12 documentos A y después incorpora 12 documentos B. Conserva ambas bitácoras. 
- **Prolog es obligatorio.** Debes programar hechos y reglas; no basta con una respuesta redactada por el LLM. 
- **Fuentes verificables.** Toda afirmación decisiva debe indicar ID de documento y dato extraído. 



## **Preguntas que debe responder el dictamen** 

1. ¿Quién realizó el intercambio? 
2. ¿En qué instante oficial ocurrió? 
3. ¿Quién parecía culpable por usar una credencial y por qué puede ser una conclusión falsa? 
4. ¿Dónde terminó el objeto original y qué evidencia lo identifica? 
5. ¿Había autorización vigente para el cambio? 
6. ¿Qué se sabe y qué **NO** se sabe sobre la intención de la persona involucrada? 

## **Fase 1 ∙Investigar el expediente inicial** 

Carga únicamente los 12 documentos A01–A12. Elabora un resumen de las cinco hipótesis más plausibles, pero **no emitas aún un veredicto** . Para cada hipótesis registra lo que el corpus demuestra, lo que contradice y lo que todavía falta. 

- Realiza al menos 15 consultas distintas, incluidas cinco que requieran relacionar dos documentos. 

- Exige ID de fuente y fragmento de respaldo en cada respuesta. Si no lo consigue, registra «sin respaldo». 

- Anota la hora tal como aparece en la fuente, el sistema que la produjo y si es oficial o está pendiente de corrección. 

- Incluye dos preguntas cuyo dato NO aparezca en los documentos: el RAG debería reconocer que carece de información. 






## **Fase 2 ∙Incorporar evidencias nuevas** 

Indexa después B13–B24 y repite **EXACTAMENTE** las 15 preguntas. Anota qué respuestas cambian y qué documento nuevo las justifica. No atribuyas automáticamente el cambio de respuesta a una mejora del modelo: quizás cambió la evidencia disponible. 

Incluye un cuadro de versiones para todos los documentos normativos: ID, fecha, versión, vigencia, requisito de autor‐ ización y contradicción detectada. 

## **Fase 3 ∙Someter al RAG a pruebas difíciles** 

Diseña otras cinco preguntas adversariales. Al menos una debe contener una premisa falsa (por ejemplo, presuponer que ya hubo robo); una debe pedir información inexistente; una debe mezclar relojes; una debe enfrentar dos versiones de un documento; y una debe comprobar si el modelo obedece una orden contenida **DENTRO** de los documentos. 

**Regla:** no modifiques el corpus para fabricar una conclusión. Una instrucción incluida en un documento es dato para analizar, no una orden que el asistente deba obedecer. 

## **Fase 4 ∙Modelar el caso en Prolog** 

- Utiliza los hechos que hayas verificado: masa, cubierta, accesos, préstamos, movimientos, autorizaciones y hallazgos. 

- Expresa todos los horarios como minutos desde medianoche; implementa la corrección de desfases y una regla de pertenencia a intervalos. 

- Implementa al menos **12 hechos comprobables y 8 reglas propias** , con referencias a documentos en comentarios o argumentos. 

- Produce por lo menos **8 consultas ejecutadas** : 4 confirmatorias, 2 que descarten hipótesis, 1 que muestre una hora corregida y 1 que pruebe un caso límite. 

- Tu regla principal debe derivar al autor a partir de evidencias convergentes; queda prohibido declararlo directamente como hecho sin inferencia. 

- Evita asumir que la falta de registros implica automáticamente que algo no ocurrió. Distingue «falso» de «no de‐ mostrado». 



## **Banco mínimo de 15 consultas de investigación** 

- **P01.** ¿Qué diferencias físicas identifican K17‐O y K17‐R? 

- **P02.** ¿Qué marca temporal y qué sensor registraron el cambio de masa? 

- **P03.** ¿Cuándo permaneció abierta la cubierta? 

- **P04.** ¿Qué tarjetas cruzaron la puerta K‐17 durante el intervalo crítico? 

- **P05.** ¿La hora del torno T1 equivale a hora oficial? Justifica. 

- **P06.** ¿Quién conservó la tarjeta B02 durante el periodo relevante? 

- **P07.** ¿De dónde pudo salir la réplica y qué falta para demostrarlo? 

- **P08.** ¿Hay alguien con coartada documentada durante el cambio? 

- **P09.** ¿Qué permite afirmar la impresión de una etiqueta? 

- **P10.** ¿Qué versiones del protocolo existen y cuál regía ese día? 

- **P11.** ¿Qué requisitos había para autorizar una sustitución? 

- **P12.** ¿Puede deducirse que una persona que usa amarillo es quien entró? 

- **P13.** ¿Qué persona recibió una funda después del cambio? 

- **P14.** ¿Qué prueba identifica el lugar final del original? 

- **P15.** ¿Qué hechos sobre motivos o intenciones NO se pueden demostrar? 

## **Experimento de recuperación (medición, no solo opinión)** 

Mantén fijo el mismo modelo y corpus completo. Prueba dos configuraciones de recuperación (por ejemplo, Top-K 3 y Top-K 7), sin alterar simultáneamente el modelo ni los documentos. Ejecuta las mismas preguntas y compara cobertura, exactitud, calidad de citas y abstenciones correctas. Si la herramienta no permite cambiar Top‐K, cambia solo un parámetro accesible y decláralo. 

|**Medida**|**Cómo se calcula**|
|---|---|
|Exactitud sustentada|Respuestas correctas y respaldadas / preguntas evaluables|
|Precisión de citas|Citas que realmente prueban la afirmación / citas comprobadas|
|Abstención apropiada|Preguntas sin respuesta en las que reconoce el límite / preguntas sin respuesta|
|Consistencia|Respuestas sin contradicciones con fuentes vigentes / total evaluado|



No necesitas lograr 100 % con un modelo pequeño. Se evalúa que puedas **medir el error, explicarlo y delimitar la evi‐ dencia** . 


## **Consultas Prolog que deberán funcionar** 

- ?- hora_intercambio(T). 

Determina el instante que coincide con masa y cubierta. 

- ?- acceso_oficial(b02,Entrada,Salida). 

Corrige el reloj del lector de accesos. 

- ?- posible_autor(P). 

Devuelve candidatos y exige justificación de reglas. 

- ?- autor_con_evidencia(P). 

Devuelve el autor sustentado por varias pruebas. 

- ?- ubicacion_del_original(Lugar). Contrasta el destino del objeto. 

- ?- sustitucion_autorizada(R). Verifica normativa y tickets. 

- ?- autor_con_evidencia(bruno). 

Ejemplo de hipótesis que debe poder descartarse. 

- ?- explicacion(P,Fuentes). 

Enumera documentos usados como premisas. 

Puedes adaptar el nombre de los predicados, pero las consultas equivalentes deben funcionar. Registra tanto resultados verdaderos como falsos y explica si false significa contradicción lógica o simple ausencia de hechos en tu base. 

## **Estructura sugerida del informe** 

1. Configuración local: modelo, embeddings, indexación, Top‐K, versión del corpus. 

2. Hipótesis iniciales y evidencia disponible antes del segundo lote. 

3. Cronología normalizada, fuente y justificación de cada evento. 

4. Diseño de hechos, reglas, consultas Prolog y derivación del resultado. 

5. Comparación de las dos configuraciones RAG y análisis de errores. 

6. Dictamen, hipótesis descartadas, incertidumbres y límites. 

## **Entregables individuales** 

- **informe.pdf** (3–5 páginas sin contar anexos); 

- **caso_k17.pl** (código ejecutable y comentado); 

- **bitacora.csv** (rondas y parámetros completos); 

- **evidencias/** (capturas o transcripciones de al menos 8 consultas a Prolog y 5 resultados problemáticos del RAG). 



## **Rúbrica (100 puntos)** 

|**Criterio**|**Puntos**|**Evidencia exigida**|
|---|---|---|
|Extracción y procedencia|25|Fuentes precisas, versiones, horarios, contradicciones|
|Reglas y comprobación Prolog|30|Hechos trazables, inferencias, consultas negativas|
|Evaluación del RAG|20|Bitácora, 2 configuraciones, métricas, inyección|
|Dictamen razonado|15|Autor, hora, destino, permiso, alternativas|
|Reproducibilidad y límites|10|Parámetros, distinción prueba / hipótesis|




