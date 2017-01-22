#! /usr/bin/guile-2.0 -s --no-auto-compile
!#

;--- b = base, n = exponent
(define (fast-expt b n)
  (define (even? x)
    (= (remainder x 2) 0))
  ;-- a s.t. a*b^n unchanged from state to state
  ;-- at beg, a = 1, answer is a at the end of process
  (define (fast-expt-iter b n a)
    (cond ((= n 0) a)
          ((even? n) (fast-expt-iter (* b b) (/ n 2) a))
          (else (fast-expt-iter b (- n 1) (* a b)))
    ))
  (fast-expt-iter b n 1)
  )
