#! /usr/bin/guile-2.0 --no-auto-compile
!#

(define (accumulate op initial sequence)
  (if (null? sequence)
    initial
    (op (car sequence)
        (accumulate op initial (cdr sequence)))))

(define (horner-eval x coeff-seq)
  (accumulate (lambda (this-coeff higher-terms) (+ (* x higher-terms) this-coeff)) 0 coeff-seq))
