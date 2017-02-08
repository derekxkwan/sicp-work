#! /usr/bin/guile-2.0 --no-auto-compile
!#

(define (subsets s)
  (if (null? s)
    (list #nil)
    (let ((rest (subsets (cdr s))))
      (append rest (map (lambda (x) (cons (car s) x)) rest)))))

; why does this work? it's like the coin counting problem:
; count all subsets of a set excluding the first elt, let this be x
; forcefully tack the first elt to all of x so everything in the second half
; of the rest HAS to have the first elt and everything on the left doesn't
; why doesn't this double count? on the recursive call then everything on the right
; HAS to have the second elt (not the first since it's outside the call
; and everything on the left HAS to not have the second elt and also not the first
; (since that wasn't included in the recursive call either)
; so now we have the power set!
