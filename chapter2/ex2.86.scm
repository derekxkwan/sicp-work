#! /usr/bin/csi -s

; operators needed: sin, cos, square, sqrt, atan
(define (sine x) (apply-generic 'sine x))
(define (cosine x) (apply-generic 'cosine x))
(define (square x) (apply-generic 'square x))
(define (square-rt x) (apply-generic 'square-rt x))
(define (arctan x) (apply-generic 'arctan x))
(put 'sine 'scheme-number
     (lambda (x) (make-real (sin x))))

(put 'cosine 'scheme-number
     (lambda (x) (tag (cos x))))

(put 'square 'scheme-number
     (lambda (x) (tag (* x x))))

(put 'square-rt 'scheme-number
     (lambda (x) (tag (sqrt x))))

(put 'arctan '(scheme-number scheme-number)
     (lambda (x y) (tag (atan x y))))

(put 'sine 'rational
     (lambda (x) (tag (sin (/ (numer x) (denom x))))))

(put 'cosine 'rational
     (lambda (x) (tag (cos (/ (numer x) (denom x))))))

(put 'square 'rational
     (lambda (x) (tag (/ (* (numer x) (numer x)) (* (denom x) (denom x))))))

(put 'square-rt 'rational
     (lambda (x) (tag (/ (sqrt (numer x)) (sqrt (denom x))))))

(put 'arctan 'rational
     (lambda (x y) (tag (atan (/ (numer x) (denom x)) (/ (numer y) (denom y))))))

; as well, operators in the complex package for both rectangular and polar change to their generic versions. + becomes add, - becomes sub, etc, 


