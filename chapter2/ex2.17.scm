#! /usr/bin/guile-2.0 --no-auto-compile
!#

(define (last-pair l1)
  (let ((next (cdr l1)))
    (if (null? next) l1 (last-pair next))
    ))
