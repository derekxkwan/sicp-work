#! /usr/bin/guile-2.0 --no-auto-compile
!#

(define (square x) (* x x))

(define (repeated f n) 
  (define (compose f g)
    (lambda (x) ( f (g x))))
  (define (rpt-iter f count)
    (if (= count 1) f
      (compose f (rpt-iter f (- count 1)))))
  (lambda (x) 
    (if (< n 1) (f x)
      ((rpt-iter f n) x)))
  )
