#! /usr/bin/guile-2.0 --no-auto-compile
!#

(define (repeated f n) 
  (define (compose f g)
    (lambda (x) ( f (g x))))
  (define (rpt-iter f count)
    (if (= count 1) f
      (compose f (rpt-iter f (- count 1)))))
    (if (< n 1) (lambda (x) (f x))
      (rpt-iter f n))
  )

(define (smooth f)
  (define dx 0.0001)
  (lambda (x) (/ (+ (f (- x dx)) (f x) (f (+ x dx))) 3.0))
  )

; ((repeated (smooth f)) n) composes the smoothed function with itself, which we don't want
(define (smooth-rpt f n)
  ((repeated smooth n) f))
