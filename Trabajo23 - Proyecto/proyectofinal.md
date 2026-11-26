# Sistema Experto Medico de Enfermedades con Eliza en Prolog

## Requisitos del Proyecto

- **Enfermedades cubiertas:**
  - Coronavirus (COVID-19)
  - Fiebre Tifoidea

- **Funciones del Sistema Experto:**
  - Diagnosticar la enfermedad (cuestionario interactivo general, diagnostico por enfermedad especifica y busqueda inversa por sintomas).
  - Consultar sintomas.
  - Consultar medidas de prevencion.
  - Consultar tratamiento y cuidados.
  - Evaluar signos vitales clave (temperatura corporal).

- **Integracion con Eliza y Busqueda de Hechos:**
  - Mantener una estructura de *Eliza pequeño* (motor `match/2` + `replace0/5` + `template/3`).
  - Ampliar la base de conocimientos de Eliza con hechos y reglas médicas buscables mediante banderas (`flags`).

*(Nota: la integracion externa con RAG + LLM pequeño queda pendiente como extensión futura fuera de esta version en Prolog).*




---

## Arquitectura del Sistema en `eliza.pl`

A diferencia de un Eliza tradicional que solo responde frases estáticas, aquí `eliza.pl` conecta los patrones conversacionales (`template/3`) con **hechos reales de Prolog** a traves de banderas en `replace0/5`:

```text
Entrada del usuario ("sintomas de coronavirus" / "tengo fiebre")
         │
         ▼
   template/3 + match/2    ---> Reconoce la intención y extrae argumentos con s(_)
         │
         ▼
      replace0/5           ---> Detecta el flag (ej. flagSintomas, flagDiagnostico)
         │
         ▼
  Consulta a Prolog        ---> Busca en sintoma_de/2, prevencion_de/2, tratamiento_de/2
     (findall / reglas)         y riesgo_de/2
         │
         ▼
  escribir_respuesta/1     ---> Imprime la respuesta formateada en consola
```






### Componentes implementados en `eliza.pl`

1. **Base de Conocimiento Medica:**
   - `sintoma_de(Enfermedad, Sintoma)`
   - `prevencion_de(Enfermedad, Medida)`
   - `tratamiento_de(Enfermedad, Tratamiento)`
   - `riesgo_de(Enfermedad, Factor)`
   - `normalizar_enfermedad/2` (acepta sinonimos como `covid`, `covid19`, `tifoidea`, `fiebre_tifoidea` y frases de dos palabras como `fiebre tifoidea`).
2. **Modulo de Diagnostico (3 modalidades):**
   - **Diagnostico interactivo completo (`diagnosticar`):** Realiza 6 preguntas `si`/`no` sobre sintomas respiratorios, digestivos, contacto previo y consumo de agua/alimentos, calcula puntaje para COVID-19 vs. Fiebre Tifoidea y emite el veredicto y recomendación.
   - **Diagnostico dirigido (`diagnosticar coronavirus` / `diagnosticar fiebre tifoidea`):** Evalua los 3 criterios principales de la enfermedad solicitada.
   - **Busqueda inversa por sintomas (`tengo fiebre`, `tengo dolor abdominal`, `tengo fiebre y tos_seca`):** Encuentra qué enfermedad(es) de la base comparten uno o dos sintomas ingresados.
3. **Evaluacion de Signos Vitales:**
   - `mi temperatura es [valor]` $\rightarrow$ clasifica temperatura (Normal, Febrícula, Fiebre leve, moderada o alta).

---





## Comandos y Consultas Disponibles

| Categoría | Ejemplos de consulta en minusculas |
|:----------|:-------------------------------------|
| Ayuda y listado | `ayuda`, `que enfermedades conoces` |
| Sintomas | `sintomas de coronavirus`, `sintomas de fiebre tifoidea`, `cuales son los sintomas de covid` |
| Prevención | `prevencion de coronavirus`, `como prevenir la fiebre tifoidea` |
| Tratamiento | `tratamiento de coronavirus`, `como tratar la fiebre tifoidea` |
| Factores de riesgo | `factores de riesgo coronavirus`, `factores de riesgo de fiebre tifoidea` |
| Diagnostico | `diagnosticar`, `diagnosticar coronavirus`, `diagnosticar fiebre tifoidea` |
| Por sintomas | `tengo fiebre`, `tengo dolor abdominal`, `tengo tos seca`, `tengo fiebre y tos_seca` |
| Signos vitales | `mi temperatura es 39.2` |

---

