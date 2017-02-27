#! /usr/bin/csi -s

; 2.73

#| this becomes
(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (deriv (addend exp) var)
                   (deriv (augend exp) var)))
        ((product? exp)
         (make-sum (make-product
                     (multiplier exp)
                     (deriv (multiplicand exp) var))
                   (make-product
                     (deriv (multiplier exp) var)
                     (multiplicand exp))))
        ;more rules to be added here
        (else (error "unknown expression type: DERIV" exp))))
|#

;this
(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp) (if (same-variable? exp var) 1 0))
        (else ((get 'deriv (operator exp))
               (operands exp) var))))
(define (operator exp) (car exp))
(define (operands exp) (cdr exp))

;a. essentially we're letting "get" deal with the possible types of expressions
; we have to derive, much like how the book used "get" to deal with rectangular
; or polar coords. number? and variable? aren't included because they don't deal
; with the operands sum and product like the others do. 

;b-c: need procedures for derivatives of sums and products

(define (=number? exp num) (and (number? exp) (= exp num)))

(define (install-deriv-package)
  ;sum stuff (lol)
  (define (addend exp) (car exp))
  ;(define (augend p) (caddr p))
  (define (augend s) (foldl make-sum 0 (cddr s)))
  (define (sum? x) (and (pair? x) (eq? (car x) '+)))
  (define (make-sum a1 a2)
    (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2))
         (+ a1 a2))
        (else (list '+ a1 a2))))
  (define (sum? x) (and (pair? x) (eq? (car x) '+)))
  (define (deriv-sum exp var)
    (make-sum (deriv (addend exp) var)
              (deriv (augend exp) var)))
  ;product stuff
  (define (multiplier p) (cadr p))
  ;(define (multiplicand p) (caddr p))
  (define (multiplicand p) (foldl make-product 1 (cddr p)))
  (define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2)) (* m1 m2))
        (else (list '* m1 m2))))
  (define (deriv-product exp var)
    (make-sum (make-product (multiplier exp)
                            (deriv (multiplicand exp) var))
              (make-product (deriv (multiplier exp) var)
                            (multiplicand exp))))
  (define (exptn? x) (and (pair? x) (eq? (car x) '**)))
  (define (make-exptn x y)
    (cond ((=number? y 0) 1)
          ((=number? y 1) x)
          ((and (number? x) (number? y))
           (expt x y))
          (else (list '** x y))))
  (define (exptn-base s) (cadr s))
  (define (exptn-expt s) (caddr s))
  (define (deriv-exptn exp var)
    (make-product (exptn-expt exp)
                  (make-product 
                    (make-exptn (exptn-base exp) (make-sum (exptn-expt exp) -1))
                    (deriv (exptn-base exp) var))))


  (put 'deriv '+  deriv-sum)
  (put 'deriv '* deriv-product)
  (put 'deriv '** deriv-exptn))

;d basically switch the order of the put args so it's like so:
; (put '+ 'deriv deriv-sum)

