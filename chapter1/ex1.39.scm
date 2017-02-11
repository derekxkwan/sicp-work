#! /usr/bin/guile-2.0 --no-auto-compile
!#

; n d are functions with argt i, k is depth of term
(define (cont-frac-iter n d k)
  (define (cfi-iter i result)
    (if (= i 0) result
      (cfi-iter (- i 1) (/ (n i) (+ (d i) result)))
      ))
  (cfi-iter k 0.0))

; nk/(dk+result) = (passed as result)-> nk-1/(dk-1+(nk/(dk+result) -> .... n1/(d1+(n2/(d2+result))...
;since there is no i=0 term (n0,d0 = 0), returning result should be sufficient (calculation with i=1 term)

(define (cont-frac-recurse n d k)
  (define (cfr-recurse i)
    (if (> i k) 0
      (/ (n i) (+ (d i) (cfr-recurse (+ i 1))))
      ))
  (cfr-recurse 1))

;n1/(d1 + recurse) -> n1/(d1 + n2/(d2 + recurse)) ->.... -> n1/d1+(n2/... + nk-1/(dk-1+(nk/dk)))

(define (tan-cf x k)
  (define (tcf-n i) 
    (if (= i 1) x (- (* x x)))
    )
  (define (tcf-d i)
    (+ 1.0 (* 2.0 (- i 1))))
  (cont-frac-iter tcf-n tcf-d k))

;testing for x = 0.5
(display (tan-cf 0.5 11)) (newline)
