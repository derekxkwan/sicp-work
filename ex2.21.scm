#! /usr/bin/guile-2.0 --no-auto-compile
!#

(define (square-list items)
  (if (null? items) #nil
    (cons (* (car items) (car items)) (square-list (cdr items)))
    ))

(define (square-list items)
  (map (lambda (x) (* x x)) items))
