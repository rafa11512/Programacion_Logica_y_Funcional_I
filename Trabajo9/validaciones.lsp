; cd "/mnt/c/Users/Rafa115/Downloads/carpeta de pruebas/Programacion Logica y Funcional/Programacion_Logica_y_Funcional_I/Trabajo9”

; Ejercicio 1 — if / else: edad para cine
(defun validar-edad-cine (edad)
  (if (integerp edad)
      (if (< edad 0)
      (progn (print "Error: Edad negativa") nil) ;true
      (if (> edad 120) ;false
          (progn (print "Error: Edad no realista") nil) ; true
          (if (< edad 13) ;false
              (progn (print "AA (infantil)") t) ;true
              (if (< edad 18)
                  (progn (print "B (adolescentes)") t) ;true
                  (progn (print "B15/C (adultos)") t)
              )
          )
      )
  )
     (progn (print "Error: No es un numero entero (edad)") nil); No es entero
  ) 
)

;==============================================================================================================

; Ejercicio 2 — when: avisos, no bloqueos

(defun avisar-password (clave)

;longitud menor a 8
(when (< (length clave) 8)
(progn (print "Aviso: Clave Corta (<8) ") T) ;True
)

;contraseñas comunes
(when (or (String= clave "12345678")(String= clave "password"))
(progn (print "Aviso: Clave demasiado comun") T) ;True
)

;minusculas y no vacia
(when (and (not(String= clave "")) (string= clave (string-downcase clave))
      )
(progn (print "Aviso: no hay mayusculas") t) ;True
)

)

; convierte cadena a minusculas: string-downcase clave



;==============================================================================================================

; Ejercicio 3 — `unless`: no procesar si faltan datos

(defun procesar-solicitud (nombre correo edad acepta-terminos)
;con esto se ignora a edad
(declare (ignore edad))

; si la cadena es un string, y no esta vacia
(unless (and (stringp nombre)(>(length nombre) 0)) 
(print "Falta Nombre") ; nil
(return-from procesar-solicitud ) ; T
)

; si el correo es un string y tiene "@"
(unless (and (Stringp correo)(search "@" correo))
(print "Correo invalido") ; nil
(return-from procesar-solicitud) ; T
)

; si acepta "T" o rechaza "nil" los terminos
(unless acepta-terminos 
(print "Debe Aceptar Terminos") ; nil
(return-from procesar-solicitud ) ; T
)

(format t "Solicitud Procesada de ~a" nombre) t ; T
)



;==============================================================================================================

;; Ejercicio 4 — `case`: roles de un sistema escolar

; (permiso-por-rol "admin")   ; debe fallar: string no es eql al símbolo admin
(defun permiso-por-rol (rol)
  (case rol
    (admin (print "Puede crear usuarios y materias") t)
    (docente (print "Puede calificar y pasar lista") t)
    (alumno (print "puede consultar calificaciones") t)
    (padre (print "puede ver boleta de sus hijos") t)
    (t (print "Rol no reconocido") nil)
  )
)


;==============================================================================================================

; Ejercicio 5 — `cond`: semáforo de promedio

(defun semaforo-promedio (p)

(unless (numberp p)
    (print "Error, el valor ingresado no es un numero") ;nil
    (return-from semaforo-promedio) ;T
)
(unless (and (>= p 0) (<= p 100))
    (print "Error, el valor promedio fuera de [0, 100]") ;nil
    (return-from semaforo-promedio) ; T
)

; la primera verdadera, gana
(cond ((< p 60) (print "ROJO --> Reprobado"))
      ((< p 80) (print "AMARILLO --> Regular"))
      ((< p 90) (print "VERDE --> Bien"))
      (t (print "ORO --> Excelencia"))
)
      
)





;==============================================================================================================

; Ejercicio 6 — `and` / `or` / `not` + `if`: alta de usuario

;(and (condicion-1)
;     (condicion-2)
;     (condicion-3)
;     (condicion-4)
;     (condicion-5))

(defun alta-usuario (user pass edad pais bloqueado)

(if (and (and (stringp user) (>(length user) 4)) ;user es string y tiene mas de 4 caracteres
         (and (stringp pass) (> (length pass) 8)) ;pass es string y tiene mas de 8 caracteres
         (and (numberp edad) (> edad 13)) ;la edad es mayor a 13
         (and (stringp pais) (or (string= pais "MX") (string= pais "US") (string= pais "CO") (string= pais "AR")))
         (not bloqueado) ; si esta bloqueado; nil es T, T es nil: todo el if da de alta si es T
    )
(progn (print "Usuario dado de alta") t)
(progn (print "Alta rechazada") nil)
)

)


;==============================================================================================================

; Ejercicio 7 — `typecase`: triage según el tipo del dato


(defun clasificar-triage (dato)

(typecase dato

  ; si el dato es numero -> Temperatura en °C
  (number
   (cond ((< dato 35) 'Hipotermia)
         ((< dato 37.5) 'Normal)
         ((<= dato 39) 'Fiebre)
         (t 'Fiebre-Alta)
   )
  )

  (string
    (cond ((string-equal dato "rojo") 'Rojo)
          ((string-equal dato "naranja") 'Naranja)
          ((string-equal dato "verde") 'Verde)
          (t (print "Color no reconocido") nil)
    )
  )

  ; (clasificar-triage '(Rafa 36))
  (list
    (let ((nombre (car dato)) (temp (cadr dato)))
      (list nombre (clasificar-triage temp))
    )
  )

  (t (print "Tipo no soportado") nil)
  
)
)



;==============================================================================================================

; Ejercicio 8 — `case` de códigos + `when` de recargo (paquetería)

;; *Objetivo**: Un validador de código de servicio (símbolo) y un when que suma recargo sin rechazar.
;; 
;; ase sobre codigo:
;; 
;;      Código  |    Servicio    |    Costo base      |     Peso máximo (kg) |
;; -------------|----------------|--------------------|----------------------|
;;      est     |      Estándar  |      80            |      20              |
;;      exp     |     Express    |     160            |    10                |
;;      noc     |      Nocturno  |     220            |     5                |
;;      int     |  Internacional |      450           |      15              |
;;      otro    |     -          |     error          |    -                 |
;; 
;;  Después del case (si el código fue válido):
;;  * unless (< peso peso-max)= → error "Excede peso del servicio", NIL.
;;  * when zona-riesgo es verdadero → suma 40 al costo e imprime "Recargo zona de riesgo +40".
;;  * Imprime costo final y T.
;; 
;; ista: case puede devolver varios valores con (values base max nombre), o puedes usar una lista (base max nombre).
;; 
;; *Pruebas mínimas**
;;  (cotizar-envio 'est 3.0 nil)
;;  (cotizar-envio 'exp 12.0 nil)   ; excede peso
;;  (cotizar-envio 'noc 2.0 t)      ; recargo
;;  (cotizar-envio 'xxx 1.0 nil)    ; código inválido
;; 
;; *Criterio**: El código se decide con case. El recargo no es un else: es un when (el envío sigue siendo válido).
;; 
;; *Extra**: si quieres que un código desconocido señale error de Lisp (no solo NIL), usa ecase en una variante y documenta la diferencia.


(defun cotizar-envio (codigo peso zona-riesgo)



)












;==============================================================================================================

; Ejercicio 9 — formulario completo: mezclar `if`, `when`, `unless` y `case`
;; **En este orden**:
;; 1. unless términos aceptados → rechazo inmediato.
;; 2. if para la edad:
;; 3. menor de 13 → rechazado
;; 4. entre 13 y 17 → solo si plan es el símbolo campus (cuenta tutelada)
;; 5. 18+ → cualquier plan
;; 6. case sobre rol (alumno docente admin) para el prefijo de cuenta: "a/", "d/", "s/". Rol inválido → NIL.
;; 7. case sobre plan (libre pro campus) para cuota mensual: 0, 99, 0. Plan inválido → NIL.
;; 8. when (eq rol 'admin) → aviso "Admin creado: revisa bitácora de auditoría".
;; 9. when password corta o común (reutiliza avisar-password) → avisos, sin rechazar.
;; 10. Si lo bloqueante pasó → imprime cuenta (prefijo+usuario), cuota y T.
;; 
;; **Pruebas mínimas (cinco casos)**
;; |  usuario   |    edad  |    rol   |     Plan  |temrinos|Esperado|
;; |------------|----------|----------|-----------|--------|--------|
;; |   lu       |   25     |alumno    |pro        |T       |OK |
;; |   pepe     |   15     |alumno    |pro        |T       |Rechazado (menor + plan no campus)|
;; |   nina     |   16     |alumno    |campus     |T       |OK Tutelada|
;; |   root     |   30     |admin     |libre      |T       |OK + Aviso auditoria|
;; |   x        |   22     |alumno    |pro        |NIL     |unless terminos|
;; 
;; 
;; **Criterio de autoevaluación**
;; Marca en el código dónde está cada constructo:
;; * ;; [UNLESS] terminos
;; * ;; [IF] edad / plan
;; * ;; [CASE] rol
;; * ;; [CASE] plan
;; * ;; [WHEN] admin
;; * ;; [WHEN] password
;; Si no puedes poner esas seis etiquetas, el ejercicio está incompleto.

(defun validar-registro (usuario correo edad rol plan password acepta-terminos)

)















;==============================================================================================================

; Ejercicio 10 — mini sistema: crédito escolar


















;==============================================================================================================
; sintaxis basica
; progn, listas, 
; pod ' y ´, quote
; 
; Funciones como:
;   - convierte cadena a minusculas: string-downcase clave
;   - stringp nombre
;   . integerp
;   - String=
;   - string-equal
;   - search
;   - unless
;   - format
;   - return-from
;   - length
;   - numberp
;   - typercase
;   - assoc
;   - (declare (ignore variable))

;   - stringp nombre
;   . integerp
;   - String=
;   - string-equal
;   - search
;   - format
;   - return-from
;   - length
;   - numberp
;   - typercase
;==============================================================================================================
