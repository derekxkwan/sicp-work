#! /usr/bin/csi -s

;2.77
;well, we haven't put magnitude and such in the interface table for complex. so we need to add it. so we first request the magnitude for complex, which gets passed off to regtangular or polar depending on the type of z. thus, two applications of apply-generic, one for each layer.

;2.78

#| originals for reference

(define (attach-tag type-tag contents)
  (cons type-tag contents))
(define (type-tag datum)
  (if (pair? datum)
      (car datum)
      (error "Bad tagged datum -- TYPE-TAG" datum)))
(define (contents datum)
  (if (pair? datum)
      (cdr datum)
      (error "Bad tagged datum -- CONTENTS" datum)))

|#

;now the new ones: want for it to work the same but scheme numbers to be repped
; as just ordinary numbers and not cons car
(define (attach-tag type-tag contents)
  (if (eq? type-tag 'scheme-number) contents
    (cons type-tag contents)))


(define (contents datum)
  (cond ((pair? datum) (cdr datum))
        ((number? datum) datum)
        (else (error "Bad tagged datum -- CONTENTS" datum))))

(define (type-tag datum)
  (cond ((pair? datum) (car datum))
        ((number? datum) 'scheme-number)
        (else (error "Bad tagged datum -- TYPE-TAG" datum))))

;2.79

(define (equ? x y) (apply-generic 'equ? x y))

(define (install-scheme-number-package)
  (put 'equ? '(scheme-number scheme-number) =))

(define (install-complex-package)
  (put 'equ? '(complex complex)
       (lambda (x y) (and (= (real-part x) (real-part y)) (= (imag-part x) (imag-part y))))
       ))

(define (install-rational-package)
  (put 'equ? '(rational rational) 
       (lambda (x y) (= (* (numer x) (denom y)) (* (numer y) (denom x))))))

;2.80

(define (=zero? x) (apply-generic '=zero? x))

(define (install-scheme-number-package)
  (put '=zero? 'scheme-number (lambda (x) (= x 0))))

(define (install-complex-package)
  (put 'equ? 'complex (lambda (x) (and (= (real-part x) 0) (= (imag-part x) 0)))))

(define (install-rational-package)
  (put 'equ? 'rational (lambda (x) (= (numer x) 0))))
