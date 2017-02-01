#! /usr/bin/guile-2.0 --no-auto-compile
!#

(define (square x) (* x x))

(define (make-point x y) (cons x y))
(define (x-point p) (car p))
(define (y-point p) (cdr p))

(define (make-segment p1 p2) (cons p1 p2))
(define (start-segment s) (car s))
(define (end-segment s) (cdr s))

(define (points-equal? x y)
  (and (= (x-point x) (x-point y)) (= (y-point x) (y-point y))))


;if a segment is vertical
(define (segment-vert? s1)
    (let ((x1 (x-point (start-segment s1)))
          (x2 (x-point (end-segment s1))))
      (= x1 x2)))


;if a segment is horizontal
(define (segment-horz? s1)
    (let ((y1 (y-point (start-segment s1)))
          (y2 (y-point (end-segment s1))))
      (= y1 y2)))

(define (segment-length s1)
  (let ((x1 (x-point (start-segment s1)))
        (y1 (y-point (start-segment s1)))
        (x2 (x-point (end-segment s1)))
        (y2 (y-point (end-segment s1))))
    (sqrt (+ (square (- x1 x2)) (square (- y1 y2)) ))
    ))

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

;make rectangle by defining opposite corners of rect
(define (make-rect top-left bottom-right) 
  (let ((test-seg (make-segment top-left bottom-right)))
    (if (and (not (points-equal? top-left bottom-right))
           (not (segment-vert? test-seg))
           (not (segment-horz? test-seg)))
      (cons top-left bottom-right))
    ))

(define (rect-top-left rect) (car rect)) 
(define (rect-bottom-right rect) (cdr rect)) 

(define (rect-perimeter myrect)
  (define top-left (rect-top-left myrect))
  (define bottom-right (rect-bottom-right myrect))
  (let ((side-side (make-segment top-left
                    (make-point (x-point top-left) (y-point bottom-right))))
        (top-side (make-segment top-left
                    (make-point (x-point bottom-right) (y-point top-left)))))
    (* (+ (segment-length top-side) (segment-length side-side)) 2.0)
    ))

(define (rect-area myrect)
  (define top-left (rect-top-left myrect))
  (define bottom-right (rect-bottom-right myrect))
  (let ((side-side (make-segment top-left
                    (make-point (x-point top-left) (y-point bottom-right))))
        (top-side (make-segment top-left
                    (make-point (x-point bottom-right) (y-point top-left)))))
    (* (segment-length top-side) (segment-length side-side))
    ))
        
