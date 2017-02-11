#! /usr/bin/guile-2.0  --no-auto-compile 
!#
;want: iterative for mult using adding/doubling/halving

(define (iter-mult x y)
  (define (even? z)
    (= (remainder z 2) 0))
  (define (double z)
    (* z 2))
  (define (halve z)
    (/ z 2))
  ; a same as 1.16, 
  (define (iter-mult-help a x y)
    (cond ((= y 0) a)
          ((even? y) (iter-mult-help a (double x) (halve y)))
          (else (iter-mult-help (+ a x) x (- y 1)))
          ))
  (iter-mult-help 0 x y)
  )
