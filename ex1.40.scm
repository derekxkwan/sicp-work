#! /usr/bin/guile-2.0 --no-auto-compile
!#
(define (fixed-point f first-guess)
  (define tolerance 0.00001)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    ;(display guess) (newline)
    (let ((next (f guess)))
      (if (close-enough? guess next) next (try next ))))
  (try first-guess))

(define (deriv g)
  (lambda (x)/ (/ (- (g (+ x dx)) (g x)) dx)))
(define (newton-transform g)
  (lambda (x) (- x (/ g x) ((deriv g) x))))
(define (newtons-method g guess)
  (fixed-point (newton-transform g) guess))

(define (cubic a b c)
  (lambda (x)
    (+ (* x x x) (* a x x) (* b x) c)))

(newtons-method (cubic a b c) 1)
