#! /usr/bin/guile-2.0 --no-auto-compile
!#

(define x (list 1 2 3))
(define y (list 4 5 6))

;(append x y)
; just appendss x to y so it would be a (list 1 2 3 4 5 6) 
; output as (1 2 3 4 5 6)

;(cons x y)
; (cons (list 1 2 3) (list 4 5 6))
; (cons (cons 1 (cons 2 (cons 3 #nil))) (cons 4 (cons 5 (cons 6 #nil))))
; the last half is definitely a list, so is the first half
; with the cons, the list continues on in the second of the pair 
; so that will be a list, and the first list will be a first element of
; this list ((1 2 3) 4 5 6)

;(list x y)
; (list (list 1 2 3) (list 4 5 6))
; (cons (cons 1 (cons 2 (cons 3 #nil))) (cons y #nil))
; (cons (cons 1 (cons 2 (cons 3 #nil))) (cons 
; (cons 4 (cons 5 (cons 6 #nil))) #nil)
; ((1 2 3) (4 5 6))
