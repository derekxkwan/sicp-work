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

(define (average x y) (/ (+ x y) 2.0))

(define (average-damp f)
  (lambda (x) (average x (f x)))
  )


; (average-damp (average-damp f)) = (average-damp (average x (f x))) = 
; (average x ((average x (f x)) 
(define (fixed-point-of-transform g transform guess)
  (fixed-point (transform g) guess))

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

;n - deg of root, x is num we want root of

; seems to require int( log2 n) repeats of average-damp.
(define (n-root n x)
  (fixed-point  ((repeated average-damp (floor (/ (log n) (log 2))))
                 (lambda (y) (/ x (expt y (- n 1)))) ) 1.0 
               ))
