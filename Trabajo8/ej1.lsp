; car y cdr

; car, funcion que maneja listas, devuelve el primer elemento de la lista
(car '(1 2 3 4 5)) ; 1
(car '(ia (ib (ic a b v(1 2 3 4))))) ; IA

; cdr, funcion que maneja listas, devuelve la lista sin el primer elemento
(cdr '(1 2 3 4)) ; (2 3 4)

; cadr, devuelve el segundo elemento de la lista
(cadr '(1 2 3 4)) ; 2
(cddr '(1 2 3 4)) ; (3 4)
(cdddr '(1 2 3 4)) ; (4)
(car (cddddr '(1 2 3 4 (a b c)))) ; (A B C)
(caar (cddddr '(1 2 3 4 (a b c)))) ; A
(cddddr '(1 2 3 4 (a b c))) ; ((A B C))
(car (cddddr '(1 2 3 4 (a b c)))) ; (A B C)
(cadr (cddddr '(1 2 3 4 (a b c)))) ; NIL
(cdar (cddddr '(1 2 3 4 (a b c)))) ; (B C)
(cadar (cddddr '(1 2 3 4(a b c)))) ; B
(cddar (cddddr '(1 2 3 4 (a b c)))) ; (C)







; Ejercicio:
; ======================== a) (1 2 3 4 5 6 7 8 9 10)     -> 6, 8, 10

; cadr (5 6 7 8 9 10)
(cadr (cddddr '(1 2 3 4 5 6 7 8 9 10))) ; 6

; cadddr (5 6 7 8 9 10)
(cadddr (cddddr '(1 2 3 4 5 6 7 8 9 10))) ; 8

; cddddr (5 6 7 8 9 10)
(caddr (cdddr (cddddr '(1 2 3 4 5 6 7 8 9 10)))) ; 10



; ======================== b) (1 2 (3 4)(A B C D))       -> D, C, 4, 2, A

;(cdddr '(1 2 (3 4)(A B C D))) -> ((A B C D))
;(car (cdddr '(1 2 (3 4)(A B C D)))) -> (A B C D)
(caar (cdr (cddr '(1 2 (3 4)(A B C D))))) ; A

;(cddr (car (cdr (cddr '(1 2 (3 4)(A B C D)))))) -> (C D)
(car (cddr (car (cdr (cddr '(1 2 (3 4)(A B C D))))))) ; C

; (cddr (car (cdr (cddr '(1 2 (3 4)(A B C D)))))) -> (C D)
(car (cdddr (car (cdddr '(1 2 (3 4)(A B C D)))))) ; D

; (cddr '(1 2 (3 4)(A B C D))) -> ((3 4)(A B C D))
; (car (cddr '(1 2 (3 4)(A B C D)))) -> (3 4)
(cadr (car (cddr '(1 2 (3 4)(A B C D))))) ; 4

; (cdr '(1 2 (3 4)(A B C D))) -> (2 (3 4)(A B C D))
(cadr '(1 2 (3 4)(A B C D))) ; 2


; ======================== c) ((A B C)(R (T X)(Z W)))      -> A, R, T, X, Z, W

(caar '((A B C)(R(TX)(Z W)))) ; A

(caadr '((A B C)(R (T X)(Z W)))) ; R

; (cadr (cadr '((A B C)(R (T X)(Z W)))))   -> (T X)

(caadr (cadr '((A B C)(R (T X)(Z W))))); T

(cadr (cadr (cadr '((A B C)(R (T X)(Z W)))))) ; X

(car (cadr (cdr (cadr '((A B C)(R (T X)(Z W))))))) ; Z

(cadr (cadr (cdr (cadr '((A B C)(R (T X)(Z W))))))) ; W


; ======================== d) ((((a b)(c d)(f g))))      -> a, b, c, d, f, g

(caaaar '((((a b)(c d)(f g))))) ; A

(cadr (caaar '((((a b)(c d)(f g)))))) ; B

(caadr (caar '((((a b)(c d)(f g)))))) ; C

(cadr (cadr (caar '((((a b)(c d)(f g))))))) ; D

(caar (cddr (caar '((((a b)(c d)(f g))))))) ; F

(cadar (cddr (caar '((((a b)(c d)(f g))))))) ; G
