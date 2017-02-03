#! /usr/bin/guile-2.0 --no-auto-compile
!#



(define (make-interval a b) (cons a b))

(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))
                 ))

(define (mul-interval x y)
  (let ((p1 (*  (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4) (max p1 p2 p3 p4))))

(define (div-interval x y)
  (mul-interval x 
                (make-interval (/ 1.0 (upper-bound y))
                               (/ 1.0 (lower-bound y)))
                ))
;ex 2.7
(define (lower-bound intv) (car intv))
(define (upper-bound intv) (cdr intv))

;ex 2.8
; note that for the lower bound, the smaller number substracted by the bigger number 
; would be the smallest
(define (sub-interval x y)
    (make-interval (- (lower-bound x) (upper-bound y))
                   (- (upper-bound x) (lower-bound y))
                   ))

;ex 2.9
;width = half the diff between upper and lower bounds

(define (width-interval x)
  (/ (- (upper-bound x) (lower-bound x)) 2))

(display "\nEx 2.9\n")

(define e29i1 (make-interval -5 5))
(define e29i2 (make-interval 1 5))
(define e29a (add-interval e29i1 e29i2))
(define e29s (sub-interval e29i1 e29i2))
(define e29m (mul-interval e29i1 e29i2))
(define e29d (div-interval e29i1 e29i2))
(define e29aw (width-interval e29a))
(define e29sw (width-interval e29s))
(define e29mw (width-interval e29m))
(define e29dw (width-interval e29d))
(define e29w1 (width-interval e29i1))
(define e29w2 (width-interval e29i2))

;width = 0.5*(uX-lX) -> width * 2 + lX = uX
;add = (lX+lY),(uX+uY) -> width: 0.5*(uX+uY-lX-lY)= 0.5(uX-lX)+0.5(uY-lY)
;sub = (lX-uY), (uX-lY) -> width: 0.5(uX-lY-lX+uY) = 0.5(uX-lX)+0.5(uY-lY)
;note w/ add and sub of intervals, the widths add
;obv mult and div aren't going to have those simple relations. why?
; because there's convoluted relations for the lower and upper bounds 
; involving min and max. rather than respective bounds being summed or 
; opposite bounds being subtracted
(display "i1: ") (display (lower-bound e29i1)) (display ", ") (display (upper-bound e29i1))
(newline)
(display "i2: ") (display (lower-bound e29i2)) (display ", ") (display (upper-bound e29i2))
(newline)
(display "add, sub: ") (display e29a) (display ", ") (display e29s) (newline)
(display "mul, div: ") (display e29m) (display ", ") (display e29d) (newline)
(display "w1: ") (display e29w1) (display ", w2: ") (display e29w2)
(display ", wa: ")(display e29aw)(display ", ws: ")(display e29sw)
(newline)
(display "wm: ") (display e29mw)(display ", wd: ")(display e29dw)(newline)
(display "sums: ")
(display (width-interval (add-interval e29i1 e29i2))) (display ", ") (display (+ e29w1 e29w2)) (newline)
(display "diffs: ")
(display (width-interval (sub-interval e29i1 e29i2))) (display ", ") (display (+ e29w1 e29w2)) (newline)