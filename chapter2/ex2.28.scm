#! /usr/bin/guile-2.0 --no-auto-compile
!#

(define (fringe y)
  (define (listify x)
    (if (not (pair? x)) (list x) x))
  (if (null? y) y
    (append (listify (car y)) (fringe (cdr y))))
  )
