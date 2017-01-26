#! /usr/bin/guile-2.0 --no-auto-compile
!#

;linear recursive
(define (accum-lin combiner null-value term a next b)
  (if (> a b) null-value
    (combiner (term a)
              (accum-lin combiner null-value term (next a) next b))))

;iterative
(define (accum-iter combiner null-value term a next b)
  (define (a-iter a result)
    (if (> a b)
      result
      (a-iter (next a) (combiner result (term a)))))
  (a-iter a null-value))

(define (product-lin term a next b)
  (accum-lin * 1 term a next b))

(define (product-iter term a next b)
  (accum-iter * 1 term a next b))

(define (sum-lin term a next b)
  (accum-lin + 0 term a next b))

(define (sum-iter term a next b)
  (accum-iter + 0 term a next b))

;work from previous exercises to test

(define (factorial-lin n)
  (define (fact-iden x) x)
  (define (fact-next x) (+ x 1))
  (product-lin fact-iden 1 fact-next n))

(define (factorial-iter n)
  (define (fact-iden x) x)
  (define (fact-next x) (+ x 1))
  (product-iter fact-iden 1 fact-next n))
