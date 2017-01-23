#! /usr/bin/guile-2.0  --no-auto-compile -s 
!#

#| a <- bq + aq + ap , b <- bp+aq twice is 
    a <- (bp + aq)q + (bq + aq + ap)q + (bq + aq + ap)p , b<- (bp + aq)p + (bq + aq + ap)q
    a <- bpq+aq^2 + bq^2 + aq^2+ apq + bpq + apq + ap^2 , b <- bp^2+apq + bq^2 + aq^2 + apq
    a <- bpq + bq^2 + bpq + aq^2 + aq^2 + apq + apq + ap^2 , b <- bp^2 + bq^2 + 2apq + aq^2
    a <- b(2pq+q^2) + a(2pq+q^2) + a(p^2 + q^2) , b <- b(p^2+q^2) + a(2pq+q^2)
    THUS: p' = p^2 + q^2 , q' = 2pq + q^2
|#

;now for the algo, mostly in SICP and plug in p' q'

(define (fast-fib n)
     (define (square x) (* x x))
     (define (even? x)
       (= (remainder x 2) 0))
     (define (fib-iter a b p q count)
       (cond ((= count 0) b)
             ((even? count)
              (fib-iter a b (+ (square p) (square q)) (+ (* 2 p q) (square q)) (/ count 2)))
             (else (fib-iter (+ (* b q) (* a q) (* a p))
                             (+ (* b p) (* a q))
                             p 
                             q
                             (- count 1))))))
