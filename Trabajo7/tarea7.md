# Funciones de Area y Volumen para Figuras Geometricas 

Realizar un archivo de lisp que tenga 10 funciones de areas y 10 funciones de volumenes para figuras geometricas
prueba.



### Cargar Archivo de lisp a la Terminal de Cygwin
Desde la terminal de Cygwin:

1. **Navega a la carpeta:**
```lisp
cd "/cygdrive/c/Users/Rafa115/Downloads/carpeta de pruebas/Programacion Logica y Funcional/Programacion_Logica_y_Funcional_I/Trabajo7"
```

2. **Inicia CLISP cargando el archivo:**
```lisp
clisp -i funciones.lsp
```

3. **Al hacer cambios dentro del archivo, es necesario vovler a cargar el archivo (dentro de la misma terminal de clisp):**
```lisp
(load "funciones.lsp")
```

- Comandos Basicos dentro de Cygwin:
  - `clisp`: inicia clisp
  - `(quit)` o `(exit)`: Salir del interprete interactivo y volver a la terminal
  - `abort`: Salir del depurador si cometes un error de sintaxis y la terminal entra en modo Break 1 [X]>




## Funciones de Areas y Volumenes
El script implementa un conjunto de funciones matematicas para el calculo geometrico de areas y volumenes.

- **Estructura y Sintaxis**
  - Declaracion de una funcion con `defun`: Cada funcion se define mediante la macro (defun nombre (parametros) cuerpo).

- **Notacion prefija (preorden)**
  - Las operaciones aritmeticas se escriben con el operador al inicio seguido de sus operandos (operador arguemento1 argumento2 ...)
  - por ejemplo: `(* base altura)` o `(/ (* base altura) 2)`.
- se hace uso de constantes matematicas como `pi`

### Funciones de Areas

```lisp
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


```

### Funciones de Volumenes

```lisp
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
```