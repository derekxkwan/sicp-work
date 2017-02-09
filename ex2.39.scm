#! /usr/bin/guile-2.0 --no-auto-compile
!#

; note that accumulate is iterative 
(define (fold-right op initial sequence)
  (if (null? sequence)
    initial
    (op (car sequence)
        (fold-right op initial (cdr sequence)))))

(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
      result
      (iter (op result (car rest))
            (cdr rest))))
  (iter initial sequence))

;unfolds to the right so reverse args
(define (reverse-right sequence)
  (fold-right (lambda (first rev) (append rev (list first))) #nil sequence))
;(1 2 3 4) -> (append proc (list 1)) -> (append 

;unfolds to the left 
(define (reverse-left sequence)
  (fold-left (lambda (res first) (cons first res)) #nil sequence))
