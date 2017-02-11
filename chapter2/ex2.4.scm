#! /usr/bin/guile-2.0 --no-auto-compile
!#

;returns a func that takes one procedure  m and applies it to x and y
(define (cons x y)
  (lambda (m) (m x y)))
; so here our procedure is lambda it is passed x and y
(define (car z)
  (z (lambda (p q) p)))
(define (cdr z)
  (z (lambda (p q) q)))
