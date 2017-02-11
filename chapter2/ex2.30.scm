#! /usr/bin/guile-2.0 --no-auto-compile
!#

(define (square x) (* x x))

(define (square-tree-direct tree)
  (cond ((null? tree) #nil)
        ((not (pair? tree)) (square tree))
        (else (cons (square-tree-direct (car tree))
                    (square-tree-direct (cdr tree))))))

(define (square-tree-recursive tree)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
           (square-tree-recursive sub-tree)
           (square sub-tree))) tree))
