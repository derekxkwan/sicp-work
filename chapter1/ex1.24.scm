#! /usr/bin/guile-2.0 --no-auto-compile
!#

(define (even? x) (= (remainder x 2) 0))
(define (square x) (* x x))

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

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

(define (start-prime-test n start-time)
  (if (fast-prime? n 100)
    (report-prime (- (get-internal-real-time) start-time))))

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (get-internal-real-time)))


(define (search-for-primes low high)
  (if (even? low) (search-for-primes (+ low 1) high)
    (cond ((>= low high) (newline))
      (else
       (timed-prime-test low)
       (search-for-primes (+ low 2) high)
       ))
    ))

