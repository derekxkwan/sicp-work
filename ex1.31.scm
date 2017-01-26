#! /usr/bin/guile-2.0 --no-auto-compile
!#

;linear recursive
(define (product-lin term a next b)
  (if (> a b) 1
    (* (term a) (product-lin term (next a) next b))))

;iterative
(define (product-iter term a next b)
  (define (iter a result)
    (if (> a b)
      result
      (iter (next a) (* result (term a)))))
  (iter a 1))

(define (factorial n)
  (define (fact-iden x) x)
  (define (fact-next x) (+ x 1))
  (product-lin fact-iden 1 fact-next n))
