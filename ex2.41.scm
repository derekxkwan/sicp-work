#! /usr/bin/guile-2.0 --no-auto-compile
!#

;previous and book work

(define (fold-right op initial sequence)
  (if (null? sequence)
    initial
    (op (car sequence)
        (fold-right op initial (cdr sequence)))))

(define (flatmap proc seq)
  (fold-right append #nil (map proc seq)))

(define (enumerate-interval low high)
  (if (> low high)
    #nil
    (cons low (enumerate-interval (+ low 1) high))))

(define (unique-pairs n)
  (flatmap (lambda (i)
             (map (lambda (j) (list i j))
                  (enumerate-interval 1 (- i 1))))
           (enumerate-interval 1 n)))

; andddd new work

;flatmap essentially flattens the lists. we don't want a flat
; list at the very last step though..

;with map, we end up with empty lists (for where there isn't a second elt
; less than the first, and each elt returns its own sequence in a list

;since there's only one real proc in unique-triples (list i j k), map seems
; to work fine (besides not being flat) but perhaps won't work in other cases
(define (unique-triples n)
  (flatmap (lambda (i)
             (flatmap (lambda (j) 
                    (map (lambda (k) (list i j k))
                         (enumerate-interval 1 (- j 1))))
                    (enumerate-interval 1 (- i 1)))
                  ) (enumerate-interval 1 n)))

(define (ordered-triples n s)
  (define (sum-to-s? triple)
    (= (+ (car triple) (cadr triple) (caddr triple)) s))
  (filter sum-to-s? (unique-triples n)))
                     
