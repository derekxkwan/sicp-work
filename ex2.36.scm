#! /usr/bin/guile-2.0 --no-auto-compile
!#

; note that accumulate is iterative 
(define (accumulate op initial sequence)
  (if (null? sequence)
    initial
    (op (car sequence)
        (accumulate op initial (cdr sequence)))))


(define (accumulate-n op init seqs)
  (if (null? (car seqs)) #nil
    (cons (accumulate op init (map car seqs))
          (accumulate-n op init (map cdr seqs)))
    ))
; ((a1 a2 a3) (b1 b2 b3))
; (map car seqs) -> (a1 b2)
; (map cdr seqs) -> ((a2 a3) (b2 b3))
