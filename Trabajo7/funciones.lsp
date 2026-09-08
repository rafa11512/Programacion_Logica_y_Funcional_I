; =============== Areas

(defun area-cuadrado (lado)
    (* lado lado))

(defun area-rectangulo (base altura)
    (* base altura))

(defun area-circulo (radio)
    (* pi (* radio radio)))

(defun area-triangulo (base altura)
    (/ (* base altura) 2))

(defun area-pentagono (perimetro apotema)
    (/ (* perimetro apotema) 2))

(defun area-romboide (base altura)
    (* base altura))

(defun area-trapecio (b-mayor b-menor altura)
    (/ (* (+ b-mayor b-menor) altura) 2))

(defun area-rombo (d-mayor d-menor)
    (/ (* d-mayor d-menor) 2))

; (funciona para hexagono, heptagono, etc)
(defun area-poligono-regular (perimetro apotema)
    (/ (* perimetro apotema) 2))

(defun area-elipse (semieje-a semieje-b)
    (* pi semieje-a semieje-b))




; =============== Volumenes
(defun volumen-cubo (lado)
    (* (* lado lado) lado)
)

(defun volumen-cilindro (radio altura)
    (* pi (* radio radio) altura)
)

(defun volumen-cono (radio altura)
    (/ (* pi (* radio radio) altura) 3)
)

(defun volumen-esfera (radio)
    (/ (* 4/3 pi (* radio radio radio)) 1)
)

(defun volumen-piramide (base altura)
    (/ (* base altura) 3)
)

(defun volumen-paralelepipedo (largo ancho alto)
    (* (* largo ancho)alto)
)

(defun volumen-tetraedro (base altura)
    (/ (* base altura) 3)
)

(defun volumen-prisma (base altura)
    (* base altura)
)

(defun volumen-prisma-triangular (base altura)
    (* base altura)
)

(defun volumen-toroide-normal (radio-mayor radio-menor)
    (* 2 (* pi pi)radio-mayor (* radio-menor radio-menor))
)

; errores con mayusculas (R r -> r-mayor r-menor)
