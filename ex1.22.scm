#! /usr/bin/guile-2.0 --no-auto-compile
!#

(define (square x) (* x x))
(define (divides? a b) (= (remainder b a) 0 ))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n ) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

(define (smallest-divisor n) (find-divisor n 2))

(define (prime? n)
  (= n (smallest-divisor n)))

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

(define (start-prime-test n start-time)
  (if (prime? n)
    (report-prime (- (get-internal-real-time) start-time))))

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (get-internal-real-time)))

(define (even? x) (= (remainder x 2) 0))
(define (odd? x) (= (remainder x 2) 1))

(define (search-for-primes low high)
  (if (even? low) (search-for-primes (+ low 1) high)
    (cond ((>= low high) (newline))
      (else
       (timed-prime-test low)
       (search-for-primes (+ low 2) high)
       ))
    ))

