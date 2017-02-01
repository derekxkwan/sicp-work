#! /usr/bin/guile-2.0 --no-auto-compile
!#

(define (make-point x y) (cons x y))
(define (x-point p) (car p))
(define (y-point p) (cdr p))

(define (make-segment p1 p2) (cons p1 p2))
(define (start-segment s) (car s))
(define (end-segment s) (cdr s))

(define (print-point p)
  (newline) 
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")")
  (newline)
  )

(define (midpoint-segment s)
  (define (mid-avg x y)
    (/ (+ x y) 2.0))
  (let ((p1 (start-segment s))
        (p2 (end-segment s)))
    (make-point (mid-avg (x-point p1) (x-point p2))
                (mid-avg (y-point p1) (y-point p2)))
    ))
