#! /usr/bin/guile-2.0 --no-auto-compile
!#

(define (square-list items)
  (define (iter things answer)
    (if (null? things)
      answer
      (iter (cdr things)
            (cons (square (car things))
                  answer))))
  (iter items #nil))

;this goes reverse order since the thing you are consing each time goes at the beginning

(define (square-list items)
  (define (iter things answer)
    (if (null? things)
      answer
      (iter (cdr things)
            (cons answer (square (car things))))))
  (iter items #nil))

; this doesn't work either since you're not consing pairs at the end (which is how lists are implemented)
