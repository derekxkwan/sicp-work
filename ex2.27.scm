#! /usr/bin/guile-2.0 --no-auto-compile
!#

(define (deep-reverse x)
  (define (list-reverse y)
    (if (not (pair? y)) y
      (append (list-reverse (cdr y)) (list (car y))))
    )
  (if (not (pair? x)) x
    (append (deep-reverse (list-reverse (cdr x)))
            (list (list-reverse (car x))))
  ))
