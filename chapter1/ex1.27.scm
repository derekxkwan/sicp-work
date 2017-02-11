#! /usr/bin/guile-2.0 --no-auto-compile
!#

(define (square x) (* x x))
(define (even? x) (= (remainder x 2) 0))

(define (expmod base exponent m)
  (cond ((= exponent 0) 1)
        ((even? exponent)
         (remainder (square (expmod base (/ exponent 2) m)) m))
        (else
          (remainder (* base (expmod base (- exponent 1) m)) m))
        ))

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) #t)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else #f)))

;taken from A002997 on the oeis website
  (define carm '(561 1105 1729 2465 2821 6601 8911 10585 15841 29341 41041 46657 52633 62745 63973 75361 101101 115921 126217 162401 172081 188461 252601 278545 294409 314821 334153 340561 399001 410041 449065 488881 512461 ))
