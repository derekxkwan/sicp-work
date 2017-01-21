#! /usr/bin/guile-2.0 -s
!#
(define (cube x) (* x x x ))

(define (square x) (* x x))

(define (improve guess x)
  (/ (+ (/ x (square guess)) (* 2.0 guess)) 3.0))

(define (good-enuf? guess x)
  (< (abs (- x (cube guess))) (* x 0.0001)))


(define (cbrt-iter guess x)
  (if (good-enuf? guess x)
    guess
    (cbrt-iter (improve guess x) x)))

(define (cbrt x)
  (cbrt-iter 1.0 x))

(display (cbrt 
           (string->number (cadr (command-line)))))
(newline)
