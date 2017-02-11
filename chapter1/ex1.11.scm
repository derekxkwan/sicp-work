#! /usr/bin/guile-2.0 -s
!#
;recursive
(define (fn-recurse n)
  (if (< n 3) n
    (+ (fn-recurse (- n 1)) (* 2 (fn-recurse (- n 2)))
       (* 3 (fn-recurse (- n 3))))
    ))

;iterative
(define (fn n)
  ;n1 = n-1, n2 = n-2, n3 = n-3
  (define (fn-iter n1 n2 n3 count)
    (cond ((< count 0) count)
          ((= count 0) n1)
        (else (fn-iter n2 n3 (+ n3 (* 2 n2) (* 3 n1)) (- count 1)))
      )
    )
  (fn-iter 0 1 2 n)
  )

