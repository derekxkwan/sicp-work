#! /usr/bin/guile-2.0 --no-auto-compile
!#

(define (inc x) (+ x 1))

(define (double f)
  (lambda (x) (f (f x))))

(display (((double (double double)) inc) 5))
; double doubles a function -> doubling that = (double (double f)) = 4x
; (ie 2 calls for every 2 calls)
; let's call that (quad f), doubling that = (quad (quad f)) = 16x
; (ie 4 calls for every 4 calls)
;16x = adding 16, (+ 5 16) = 21
