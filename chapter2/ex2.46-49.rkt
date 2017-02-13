#lang sicp
(#%require sicp-pict)

;2.46
(define (make-vect xcor ycor)
  (cons xcor ycor))

(define (xcor-vect vect)
  (car vect))

(define (ycor-vect vect)
  (cdr vect))

(define (add-vect v1 v2)
  (cons (+ (xcor-vect v1) (xcor-vect v2)) (+ (ycor-vect v1) (ycor-vect v2))))

(define (scale-vect s v1)
  (cons (* s (xcor-vect v1)) (* s (ycor-vect v1))))

(define (sub-vect v1 v2)
  (add-vect v1 (scale-vect -1. v2)))

;2.47

;version 1
(define (make-frame origin edge1 edge2)
  (list origin edge1 edge2))

(define (frame-origin frame)
  (car frame))

(define (frame-edge1 frame)
  (cadr frame))

(define (frame-edge2 frame)
  (caddr frame))

;version 2
#|
;apparently racket doesn't like redefining things so i've commented it out
(define (make-frame origin edge1 edge2)
  (cons origin (cons edge1 edge2)))

(define (frame-origin frame)
  (car frame))

(define (frame-edge1 frame)
  (cadr frame))

(define (frame-edge2 frame)
  (cddr frame))

;2.48

(define (make-segment v1 v2)
  (cons v1 v2))

(define (start-segment seg)
  (car v1))

(define (end-segment seg)
  (cdr v1))
|#
;2.49

;2.49a:outline

;note that this doesn't seem to draw the 2nd and third vectors, i'm assuming they
;got clipped off
(define outline-list
  (list (make-segment (make-vect 0 0) (make-vect 0 1))
        (make-segment (make-vect 0 1) (make-vect 1 1))
        (make-segment (make-vect 1 1) (make-vect 1 0))
        (make-segment (make-vect 1 0) (make-vect 0 0))))

(paint (segments->painter outline-list))

;b
(define x-list
  (list (make-segment (make-vect 0 0) (make-vect 1 1))
        (make-segment (make-vect 1 0) (make-vect 0 1))))

(paint (segments->painter x-list))

;c
(define diamond-list
  (list (make-segment (make-vect 0 0.5) (make-vect 0.5 1))
        (make-segment (make-vect 0.5 1) (make-vect 1 0.5))
        (make-segment (make-vect 1 0.5) (make-vect 0.5 0))
        (make-segment (make-vect 0.5 0) (make-vect 0 0.5))))

(paint (segments->painter diamond-list))

;d well, i get the point of the exercise, the wave painter looks a little too involved

