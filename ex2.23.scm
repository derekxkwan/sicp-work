#! /usr/bin/guile-2.0 --no-auto-compile
!#

(define (for-each proc inlist)
  (if (null? inlist) #t 
    ((proc (car inlist))
     (for-each proc (cdr inlist)))))
