#! /usr/bin/guile-2.0 --no-auto-compile
!#

;previous and book work

(define (fold-right op initial sequence)
  (if (null? sequence)
    initial
    (op (car sequence)
        (fold-right op initial (cdr sequence)))))

(define (flatmap proc seq)
  (fold-right append #nil (map proc seq)))

(define (enumerate-interval low high)
  (if (> low high)
    #nil
    (cons low (enumerate-interval (+ low 1) high))))

(define (square x) (* x x))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m)) m))
        (else
          (remainder (* base (expmod base (- exp 1) m)) m))))

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) #t)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else #f)))

; a simple wrapper aruond fast-prime
(define (prime? n)
  (fast-prime? n 25))


(define (make-pair-sum pair)
  (list (car pair) (cadr pair) (+ (car pair) (cadr pair))))

(define (prime-sum? pair)
  (prime? (+ (car pair) (cadr pair))))

;now the new work 

(define (unique-pairs n)
  (flatmap (lambda (i)
             (map (lambda (j) (list i j))
                  (enumerate-interval 1 (- i 1))))
           (enumerate-interval 1 n)))


(define (prime-sum-pairs n)
  (map make-pair-sum (filter prime-sum? (unique-pairs n))))
