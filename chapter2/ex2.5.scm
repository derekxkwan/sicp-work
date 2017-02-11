#! /usr/bin/guile-2.0 --no-auto-compile
!#

(define (cons a b)
  (* (expt 2 a) (expt 3 b)))

; even * even = even, odd * odd = odd so 2^a is even and 3^b is odd
; but odd *even = even

(define (odd? x) (= (remainder x 2) 1))

; keep dividing by 2 to get an odd number 3^b
(define (get-odd x) 
  (define (go-iter y)
    (if (or (odd? y) (= y 1)) y
      (go-iter (/ y 2))))
  (go-iter x))

; keep dividing by 3 to get even number 2^a
(define (get-even x)
  (define (ge-iter y)
    (if (or (not (= (remainder y 3) 0)) (= y 1)) y
      (ge-iter (/ y 3))))
  (ge-iter x))

; ln (x^d) = d ln (x) so take ln of result and div by ln x
; in car case, want a so get 2^a and divide by ln by ln 2
(define (car c)
  (if (= c 1) 0 
    (round (/ (log (get-even c)) (log 2)))
    ))

;opposite for cdr
(define (cdr c)
  (if (= c 1) 0 
    (round (/ (log (get-odd c)) (log 3)))
    ))
