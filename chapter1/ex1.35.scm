#! /usr/bin/guile-2.0 --no-auto-compile
!#

(define (fixed-point f first-guess)
  (define tolerance 0.00001)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next) next (try next ))))
  (try first-guess))

; golden ratio: phi^2 = phi + 1 -> phi = 1 + 1/phi

(display (fixed-point (lambda (phi) (+ 1.0 (/ 1.0 phi))) 1.0)) (newline)
