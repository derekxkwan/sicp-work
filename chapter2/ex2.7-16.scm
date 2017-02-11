#! /usr/bin/guile-2.0 --no-auto-compile
!#



(define (make-interval a b) (cons a b))

(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))
                 ))
;old mul-interval
(define (mul-interval x y)
  (let ((p1 (*  (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4) (max p1 p2 p3 p4))))

;old div-interval
(define (div-interval x y)
  (mul-interval x 
                (make-interval (/ 1.0 (upper-bound y))
                               (/ 1.0 (lower-bound y)))
                ))

(define (make-center-width c w)
  (make-interval (- c w) (+ c w)))

(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2))


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

;ex2.10

(define (div-interval x y)
  (let ((lY (lower-bound y)) (uY (upper-bound y)))
  (if(<= (* lY uY) 0) (error "DIV0!" y) 
    (mul-interval x (make-interval (/ 1.0 uY) (/ 1.0 lY)))
                       )))

;ex2.11

;nine cases:
; 1 (+,+) * (+,+)
; 2 (-, +) * (+, +)
; 3 (-,-) * (+,+)
; 4 (+,+) * (-,+)
; 5 (-,+) * (-,+)
; 6 (-,-) * (-, +)
; 7 (+,+) * (-,-)
; 8 (-,+) * (-,-)
; 9 (-,-) * (-, -)
(define (mul-interval x y)
  (define (posi? z) (>= z 0))
  (define (negi? z) (< z 0))
    (let ((lX (lower-bound x))
          (uX (upper-bound x))
          (lY (lower-bound y))
          (uY (upper-bound y)))
      (cond (;1
             (and (posi? lX) (posi? uX)
                 (posi? lY) (posi? uY))
             (make-interval (* lX lY) (* uX uY)))
            (;2
             (and (negi? lX) (posi? uX)
                  (posi? lY) (posi? uY))
             ;(-1 5) (1 5)
             (make-interval (* lX uY) (* uX uY)))
            (;3
             (and (negi? lX) (negi? uX)
                  (posi? lY) (posi? uY))
             ; (-5 -1) (1 5)
             (make-interval (* lX uY) (* uX lY)))
            (;4
             (and (posi? lX) (posi? uX)
                  (negi? lY) (posi? uY))
             ; (1 5) (-1 5)
             (make-interval (* uX lY) (* uX uY)))
            (;5 
             (and (negi? lX) (posi? uX)
                  (negi? lY) (posi? uY))
             ; (-1 5) (-10 5)
             (make-interval (min (* uX lY) (* lX uY))
                            (max (* lX lY) (* uX uY))))
            (;6
             (and (negi? lX) (negi? uX)
                  (negi? lY) (posi? uY))
             ; (-5 -1) (-10 5)
             (make-interval (* lX uY) (* lX lY)))
            (;7
             (and (posi? lX) (posi? uX)
                  (negi? lY) (negi? uY))
             ; (1, 5) (-5 -1)
             (make-interval (* uX lY) (* lX uY)))
            (;8
             (and (negi? lX) (posi? uX)
                  (negi? lY) (negi? uY))
             ; (-1, 5) (-5 -1)
             (make-interval (* uX lY) (* lX uY)))
            (else
              ;9: (-5, -1) (-10, -7)
              (make-interval (* uX uY) (* lX lY)))
            )))


; ex 2.12

(define (make-center-percent c p-tol)
  (let ((w (* c (/ p-tol 100.0))))
    (make-interval (- c w) (+ c w))))

(define (percent i)
  (let ((c (/ (+ (upper-bound i) (lower-bound i)) 2))
        (w (/ (- (upper-bound i) (lower-bound i)) 2)))
    (* (/ w c) 100.0)))

; ex 2.13

;let i1 = (a,b), i2 = (c,d) and a,b,c,d>0. Then i1*i2 = (a*c,b*d)
;as in case 1 of our multiplying algo. in terms of widths.
;i1 = (a,b)= (c1-w1,c1+w1), likewise for i2
;i1*i2=((c1-w1)*(c2-w2), (c1+w1)*(c2+w2))
;a*c=c1*c2-(c1*w2)-(c2*w1)+(w1*w2)
;b*d=c1*c2+(c1*w2)+(c2*w1)+(w1*w2)
;given that w1 and w2 are small, w1*w2 is even smaller -> drops out
;i1*i2=(c1*c2-((c1*w2)+(c2*w1)),c1*c2+((c1*w2)+(c2*w1)))
;c12 = c1*c2, w12 = (c1*w2)+(c2*w1)
;since w = c*t/100, where t is percent tolerance
;w12 = (c1*(c2*t2)/100)+(c2*(c1*t1)/100)
;w12 = (c1*c2)((t1+t2)/100)
;so for i12, since c12 = c1*c2, then t12 = t1+t2

; ex 2.14

(define a (make-center-percent 100 10))
(define b (make-center-percent 200 25))
(define c (make-center-percent 400 50))
(define aa (div-interval a a))
(define ab (div-interval a b))
(define bb (div-interval b b))
(define bc (div-interval b c))
(define cc (div-interval c c))
(define ac (div-interval a c))
(define caa (center aa))
(define cbb (center bb))
(define ccc (center cc))
(display "ex 2.14\n")

(display "a,b,c: ")(display a)(display ", ")
(display b)(display ", ")(display c)(newline)

(display "aa,bb,cc: ")(display aa)(display ", ")
(display bb)(display ", ")(display cc)(newline)

(display "ab,bc,ac: ")(display ab)(display ", ")
(display bc)(display ", ")(display ac)(newline)

(display "caa,cbb,ccc: ")(display caa)(display ", ")
(display cbb)(display ", ")(display ccc)(newline)

;centers aren't 1, yikes!

;ex 2.15

;since we can't reduce entropy (read as uncertain numbers) from a system, using an uncertain number multiple times is worse than using it just once, (like how we just saw multiplying tolerances are cumulative...), the one in par2 doesn't have an tolerances, it is what it is.

;ex 2.16
;since A/A != 1, there's no identity in our interval arithmetic, anyways tolerances add when multiplication is done so if we keep doing that we end up further and further away from 1. a*b+a*c != a*(b+c) for the same reason, so our interval arithmetic def doesn't define a field. basically, the more times you use an uncertain quantity, uncertainty gets worse.
