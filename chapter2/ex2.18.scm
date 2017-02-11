#! /usr/bin/guile-2.0 --no-auto-compile
!#

(define (list-reverse l1)
    (if (null? l1) l1
      (append (list-reverse (cdr l1)) (list (car l1))))
    )
