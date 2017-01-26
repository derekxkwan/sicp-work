#! /usr/bin/guile-2.0 --no-auto-compile
!#

;linear recursive
(define (sum-lin term a next b)
  (if (> a b) 0 (+ (term a) (sum-lin term (next a) next b))))

;iterative
(define (sum-iter term a next b)
  (define (iter a result)
    (if (> a b)
      result
      (iter next (+ result (term a)))))
  (iter a 0))
