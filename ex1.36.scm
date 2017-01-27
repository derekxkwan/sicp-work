#! /usr/bin/guile-2.0 --no-auto-compile
!#

(define (fixed-point-disp f first-guess)
  (define tolerance 0.00001)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (display guess) (newline)
    (let ((next (f guess)))
      (if (close-enough? guess next) next (try next ))))
  (try first-guess))

(define (average x y) (/ (+ x y) 2.0))


(display "no avg damping \n")
(fixed-point-disp (lambda (x) (/ (log 1000.0) (log x))) 1.5)
(display "avg damping \n")
(fixed-point-disp (lambda (x) ( average x (/ (log 1000.0) (log x))) ) 1.5)

