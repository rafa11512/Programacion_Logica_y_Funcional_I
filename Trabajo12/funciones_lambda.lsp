(setq lst '(1 2 3))
`(a b ,@lst)    ; (a b 1 2 3)

;; mapcar: Aplica una funcion a cada uno de los elementos de una lista y
;; devuelve una nueva lista con los resultados.

;; Sintaxis: (mapcar #'funcion lista)

(defun suma (a)
(+ a a)
)

(mapcar #'suma '(1 2 3 4 5))  ; (2 4 6 8 10)

(mapcar #'1+ '(1 2 3 4 5))  ; (2 3 4 5 6)


(mapcar (lambda (x) (* x 2)) '(1 2 3 4)) ; (2 4 6 8)

(mapcar (lambda (lst) (apply #'+ lst)) '((1 2 3) (4 5 6) (7 8 9))) ; (6 15 24)

(mapcar (lambda (x) (if evenp x)) '(1 2 3 4 5)) ; (2 4)

(mapcar #'char-upcase '("a" "b" "c")) ; ("A" "B" "C")


;; ==============================================================================================

;; Lambda: 
;; (lambda (parametros) cuerpo)
(lambda (x) (* x 2))

(apply (lambda (x y) (+ x y)) '(5 9))

(defun aplicar-operacion (operacion lista)
  (mapcar operacion lista))
  (aplicar-operacion (lambda (x) (* x x)) '(1 2 3 4 5)) 

; ==============================================================================================


; ========================= AREAS Y VOLUMENES USANDO LAMBDA

(defun calcular-figuras (L lista)
  (mapcar L lista))

;;  VOLUMENES

;Volumen de Cubo (1 parametro: lado = 5) -> V = lado^3
(calcular-figuras (lambda (x) (* x x x)) '(5))

;Volumen de Esfera (1 parametro: radio = 4) -> V = (4/3) * pi * r^3
(calcular-figuras (lambda (r) (* 4/3 pi r r r)) '(4))

;Volumen de Cilindro (2 parametros: radio = 3, altura = 10) -> V = pi * r^2 * h
(mapcar (lambda (r h) (* pi (* r r) h)) '(3) '(10))

;Volumen de Cono (2 parametros: radio = 3, altura = 10) -> V = (pi * r^2 * h) / 3
(mapcar (lambda (r h) (/ (* pi (* r r) h) 3)) '(3) '(10))

;Volumen de Piramide / Tetraedro (2 parametros: base = 15, altura = 10) -> V = (base * h) / 3
(mapcar (lambda (b h) (/ (* b h) 3)) '(15) '(10))

;Volumen de Paralelepipedo (3 parametros: largo = 2, ancho = 3, alto = 4) -> V = l * a * h
(mapcar (lambda (l a h) (* l a h)) '(2) '(3) '(4))

;;  AREAS

;Cuadrado (1 parametro: lado = 4) -> A = lado^2
(calcular-figuras (lambda (l) (* l l)) '(4))

;Circulo (1 parametro: radio = 2) -> A = pi * r^2
(calcular-figuras (lambda (r) (* pi (* r r))) '(2))

;Rectangulo / Romboide (2 parametros: base = 5, altura = 4) -> A = b * h
(mapcar (lambda (b h) (* b h)) '(5) '(4))

;Triangulo (2 parametros: base = 10, altura = 5) -> A = (b * h) / 2
(mapcar (lambda (b h) (/ (* b h) 2)) '(10) '(5))

;Poligono Regular (2 parametros: perimetro = 30, apotema = 4) -> A = (p * ap) / 2
(mapcar (lambda (p ap) (/ (* p ap) 2)) '(30) '(4))

;Trapecio (3 parametros: Base mayor = 10, base menor = 6, altura = 5) -> A = ((B + b) * h) / 2
(mapcar (lambda (b1 b2 h) (/ (* (+ b1 b2) h) 2)) '(10) '(6) '(5))