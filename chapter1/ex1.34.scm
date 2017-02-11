#! /usr/bin/guile-2.0 --no-auto-compile
!#

(define (f g) (g 2))
;(f f) ----> f passed as arg g ---> ( f 2), so now 2 is the argt of f so replacing g with 2 -> (2 2)
;which is a big error!
