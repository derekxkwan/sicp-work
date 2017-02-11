#! /usr/bin/guile-2.0 --no-auto-compile
!#

;linear recursive with filter
(define (accum-lin-filt combiner null-value term a next b filter?)
  (if (> a b) null-value
    (if (filter? a)
    (combiner (term a)
              (accum-lin-filt
                combiner null-value term (next a) next b filter?))
    (combiner null-value
              (accum-lin-filt
                combiner null-value term (next a) next b filter?))
    )))

;iterative with filter
(define (accum-iter-filt combiner null-value term a next b filter?)
  (define (a-iter a result)
    (if (> a b)
      result
      (if (filter? a)
      (a-iter (next a) (combiner result (term a)))
      (a-iter (next a) result)
      )))
  (a-iter a null-value))

(define (product-lin-filt term a next b filter?)
  (accum-lin-filt * 1 term a next b filter?))

(define (product-iter-filt term a next b filter?)
  (accum-iter-filt * 1 term a next b filter?))

(define (sum-lin-filt term a next b filter?)
  (accum-lin-filt + 0 term a next b filter?))

(define (sum-iter-filt term a next b filter?)
  (accum-iter-filt + 0 term a next b filter?))

;work from previous exercises to test

;miller-rabin
(define (square x) (* x x))
(define (even? x) (= (remainder x 2) 0))

(define (mr-expmod base exponent m)
  ;checking for nontrivial square root of 1 mod n
  (define (mr-squarecheck x m)
    (if (and (not (or (= x 1) (= x (- m 1))))
             (= (remainder (square x) m) 1))
      0 (remainder (square x) m)))
  (cond ((= exponent 0) 1)
        ((even? exponent)
         (mr-squarecheck (mr-expmod base (/ exponent 2) m) m))
        (else
          (remainder (* base (mr-expmod base (- exponent 1) m)) m))
        ))

(define (mr-test n)
  (define (try-it a)
    (= (mr-expmod a (- n 1) n) 1))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) #t)
        ( (<= n 1) #f)
        ((mr-test n) (fast-prime? n (- times 1)))
        (else #f)))

(define (gcd a b)
  (if (= b 0) a (gcd b (remainder a b))))

;now for some more new stuff

(define (square x) (* x x))

(define (square-prime-sum-lin a b)
  (define (spsl-next x) (+ x 1))
  (define (spsl-prime? x) (fast-prime? x 50))
  (sum-lin-filt square a spsl-next b spsl-prime?))

(define (square-prime-sum-iter a b)
  (define (spsi-next x) (+ x 1))
  (define (spsi-prime? x) (fast-prime? x 50))
  (sum-iter-filt square a spsi-next b spsi-prime?))

(define (rel-prime-product-lin n)
  (define (rpp-next x) (+ x 1))
  (define (rpp-relprime? x) (= (gcd x n) 1))
  (define (rpp-identity x) x)
  (cond ((<= n 0) 0)
        ((= n 1) 1)
        (else (product-lin-filt rpp-identity 1 rpp-next (- n 1) rpp-relprime?)))
  )

(define (rel-prime-product-iter n)
  (define (rpp-next x) (+ x 1))
  (define (rpp-relprime? x) (= (gcd x n) 1))
  (define (rpp-identity x) x)
  (cond ((<= n 0) 0)
        ((= n 1) 1)
        (else (product-iter-filt rpp-identity 1 rpp-next (- n 1) rpp-relprime?)))
  )



