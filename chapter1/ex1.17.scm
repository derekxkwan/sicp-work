#! /usr/bin/guile-2.0  --no-auto-compile 
!#


(define (log-mult a b)
  (define (even? x)
    (= (remainder x 2) 0))
  (define (double x)
    (* x 2))
  (define (halve x)
    (/ x 2))
  (define (l-mult a b)
    (cond ((= b 0) 0)
      ((even? b) (double (l-mult a (halve b))))
      (else (+ a (l-mult a (- b 1))))
      )
    )
  (l-mult a b)
  )

