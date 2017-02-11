#! /usr/bin/guile-2.0 --no-auto-compile
!#

(define (compose f g)
  (lambda (x) ( f (g x))))
