#! /usr/bin/guile-2.0 --no-auto-compile
!#

(define (iterate-improve good? f)
  (define (try guess)
    (let ((next (f guess)))
      (if (good? guess) next (try next))))
  (lambda (x) (try x)))

(define (fixed-point f first-guess)
  (define (close-enough? x)
    (let ((tolerance 0.0001)) 
      (< (abs (- x (f x))) tolerance)))
  ((iterate-improve close-enough? f) first-guess))

(define (sqrt x)
  (define (close-enough? v1)
    (let ((tolerance 0.0001)) 
      (< (abs (- (* v1 v1) x)) tolerance)))
  ((iterate-improve close-enough? (lambda (y) (/ (+ y (/ x y)) 2))) 1.0
    ))
