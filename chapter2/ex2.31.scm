#! /usr/bin/guile-2.0 --no-auto-compile
!#

(define (tree-map-direct proc tree)
  (cond ((null? tree) #nil)
        ((not (pair? tree)) (proc tree))
        (else (cons (tree-map-direct proc (car tree))
                    (tree-map-direct proc (cdr tree))))))

(define (tree-map-recursive proc tree)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
           (tree-map-recursive proc sub-tree)
           (proc sub-tree))) tree))
