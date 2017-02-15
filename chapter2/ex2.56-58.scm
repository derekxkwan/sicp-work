#! /usr/bin/csi -s

;some needed book code
(define (variable? x) (symbol? x))

(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (addend s) (cadr s))
;(define (augend s) (caddr s))

(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2))
         (+ a1 a2))
        (else (list '+ a1 a2))))

(define (multiplier p) (cadr p))
;(define (multiplicand p) (caddr p))

(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2)) (* m1 m2))
        (else (list '* m1 m2))))

(define (sum? x) (and (pair? x) (eq? (car x) '+)))
(define (product? x) (and (pair? x) (eq? (car x) '*)))

; EXERCISE 2.56
(define (=number? exp num) (and (number? exp) (= exp num)))

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp) (if (same-variable? exp var) 1 0))
        ((sum? exp) (make-sum (deriv (addend exp) var)
                              (deriv (augend exp) var)))
        ((product? exp)
         (make-sum
           (make-product (multiplier exp)
                         (deriv (multiplicand exp) var))
           (make-product (deriv (multiplier exp) var)
                         (multiplicand exp))))
        ((exptn? exp)
         (make-product (exptn-expt exp)
                       (make-product 
                         (make-exptn (exptn-base exp) (make-sum (exptn-expt exp) -1))
                         (deriv (exptn-base exp) var))))
        (else
          (error "unknown expression type: DERIV" exp))))


; exponentiation? was way too long...
(define (exptn? x) (and (pair? x) (eq? (car x) '**)))
;make-exponentiation also way too long
(define (make-exptn x y)
  (cond ((=number? y 0) 1)
        ((=number? y 1) x)
        ((and (number? x) (number? y))
         (expt x y))
        (else (list '** x y))))


(define (exptn-base s) (cadr s))
;expt = exponent
(define (exptn-expt s) (caddr s))

;EXERCISE 2.57


; want to be able m2 and a2 to be rest of args
; just redefine augend and multiplicand

(define (augend s) (foldl make-sum 0 (cddr s)))
(define (multiplicand p) (foldl make-product 1 (cddr p)))
