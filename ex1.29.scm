#! /usr/bin/guile-2.0 --no-auto-compile
!#

(define (sum term a next b)
  (if (> a b) 0 (+ (term a) (sum term (next a) next b))))

(define (integral f a b dx)
  (define (add-dx x) (+ x dx))
  (* (sum f (+ a (/ dx 2.0)) add-dx b) dx))

(define (even? x) (= (remainder x 2) 0))

(define (cube x) (* x x x))
;simpson's rule

(define (simpsons f a b n)
  (define simp-h (/ (- b a) n))
  (define (simp-next2 x) (+ x (* 2.0 simp-h)))
  (if (even? n)
    (* (/ simp-h 3.0)
       (+ (* 2.0 (sum f (+ a (* 2.0 simp-h)) simp-next2 (- b (* 2.0 simp-h))))
          (* 4.0 (sum f (+ a simp-h) simp-next2 (- b simp-h)))
          (f a) (f b)))
    #f ))
