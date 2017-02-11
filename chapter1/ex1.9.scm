#! /usr/bin/guile-2.0 -s
!#

; since there's no inc or dec
(define (inc a)
  (+ a 1))

(define (dec a)
  (- a 1))

;--recursive
(+ 2 5)
(inc (+ (dec 2) 5))
(inc (+ 1 5))
(inc (inc (+ (dec 1) 5)))
(inc (inc (+ 0 5)))
(inc (inc 5))
(inc 6)
7
;--iterative-

(+ 2 5)
(+ (dec 2) (inc 5))
(+ 1 6)
(+ (dec 1) (inc 6))
(+ 0 7)
7


