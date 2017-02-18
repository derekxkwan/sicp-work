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

;EXERCISE 2.58

; A: prefix -> infix form
;sounds reasonable enough, just have to reorder some things and 
;change some cars and cdrs

;car -> cadr since second elt of list
(define (sum-infix? x) (and (pair? x) (eq? (cadr x) '+)))
(define (addend-infix s) (car s))

;augend stays the same as the original
(define (augend-infix s) (caddr s))

(define (make-sum-infix a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2))
         (+ a1 a2))
        ;this changes
        (else (list a1 '+ a2))))

(define (product-infix? x) (and (pair? x) (eq? (cadr x) '*)))

(define (multiplier-infix p) (car p))
;multiplicand stays the same as the original
(define (multiplicand-infix p) (caddr p))

(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2)) (* m1 m2))
        ;this changes
        (else (list  m1 '* m2))))


(define (exptn-infix? x) (and (pair? x) (eq? (cadr x) '**)))
;make-exponentiation also way too long
(define (make-exptn-infix x y)
  (cond ((=number? y 0) 1)
        ((=number? y 1) x)
        ((and (number? x) (number? y))
         (expt x y))
        ;this changes
        (else (list x '** y))))


(define (exptn-base-infix s) (car s))
;exptn-expt stays the same as the original
(define (exptn-expt-infix s) (caddr s))

;B: standard algebraic notation with out parens and also w op precedence
; book example (x + 3 * (x + y + 2))

;borrowed structure from zelphir's schemewiki answer but abstracted out
; procedures so less typing

;find op of lowest precedence
;everything on both sides of the lowest precedence operator has to evalute
;before the operator is applied. (or else we wouldn't be following
; order of precedence)

;get stuff before the operator
(define (before-op sym expr)
  (define (bo-iter parse result)
    (cond ((not (pair? parse)) '())
          ((eq? sym (car parse)) result)
          (else bo-iter (cadr parse) (append result (list (car parse))))
          ))
  (bo-iter expr '()))

;get stuff after the operator
(define (after-op sym expr)
  (let ((result (memq sym expr)))
    (if (not (pair? result)) '()
      (cdr result))))

(define (op-lowest expr)
  (cond ((memq '+ expr) '+)
        ((memq '* expr) '*)
        (else  '**)))

(define (op-infix? sym expr)
  (and (pair? expr) (eq? sym (op-lowest expr))))

(define (sum-infix? expr)
  (op-infix? '+ expr))

(define (product-infix? expr)
  (op-infix? '* expr))

(define (expt-infix? expr)
  (op-infix? '** expr))

(define (choose-part-infix side sym expr)
  (let ((chosen (side sym expr)))
    (if (= (length chosen) 1) (car chosen)
      (chosen))))


(define (addend-infix expr)
  (choose-part-infix before-op '+ expr))

(define (augend-infix expr)
  (choose-part-infix after-op '+ expr))

(define (multiplier-infix expr)
  (choose-part-infix before-op '* expr))

(define (multiplicand-infix expr)
  (choose-part-infix after-op '* expr))

(define (expt-base-infix expr)
  (choose-part-infix before-op '** expr))

(define (expt-expt-infix expr)
  (choose-part-infix after-op '** expr))
