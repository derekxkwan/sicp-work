#! /usr/bin/guile-2.0 --no-auto-compile
!#

; note that accumulate is iterative 
(define (accumulate op initial sequence)
  (if (null? sequence)
    initial
    (op (car sequence)
        (accumulate op initial (cdr sequence)))))

; old count-leaves
(define (count-leaves-old x)
  (cond ((null? x) 0)
        ((not (pair? x)) 1)
        (else (+ (count-leaves-old (car x))
                 (count-leaves-old (cdr x))))))

; note that sequence wants a list from the tree
; singleton values should be 1 since we're trying to count leaves
; the recursive call in the map will keep drilling down until
; we hit bottom and return the number of leaves 
(define (count-leaves tree)
  (accumulate + 0 (map (lambda (x) (if (not (pair? x)) 1 (count-leaves x))) tree ) 
                       ))
; (1 ( 2 3) 4 5 (6 ( 7 8)) 9) -> we hit 1 on the first step, fine
; next step we hit (2 3), according to the map, we recurse onto (2 3), which gives (+ 1 1)
; (1 2 4 5 (6 (7 8)) 9) ....
