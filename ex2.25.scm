#! /usr/bin/guile-2.0 --no-auto-compile
!#

(define l1 (list 1 3 (list 5 7) 9))
(display (car (cdr (car (cdr (cdr l1)))))) (newline)
;cdr 1 to get to (3 (5 7) 9), a second cdr to get to ((5 7) 9)
; car to get the (5 7), cdr to get the( 7)
; because (5 7) is (cons 5 (cons 7 #nil)) so one more car 

(define l2 (list (list 7)))
(display (car (car l2))) (newline)
; first element of the list is (list 7) so one car
; this (list 7) is (cons 7 #nil) so one more car for 7

(define l3 (list 1 (list 2 (list 3 (list 4 (list 5 (list 6 7)))))))
(display  (car (cdr (car (cdr (car (cdr (car (cdr (car (cdr (car (cdr l3)))))))))))))
(newline)
;(cons 1 (cons (cons 2 (cons (cons 3 (cons (cons 4 ...
; since a 2 item list is (cons a (cons b #nil), replace b with another
; two item list..(cons a (cons (cons b (cons c #nil)))) 
; UGLY, so cdr into the first cons, then car, so each layer is cdr/car
; once we reach 5 we have (list 5 (list 6 7)) which is 
; (cons 5 (cons (cons 6 (cons 7 #nil))))
; cdr/car once more to get to 6, then we have (cons 6 (cons 7 #nil))
; cdr/car to get to 7!
