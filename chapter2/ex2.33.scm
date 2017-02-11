#! /usr/bin/guile-2.0 --no-auto-compile
!#

(define (accumulate op initial sequence)
  (if (null? sequence)
    initial
    (op (car sequence)
        (accumulate op initial (cdr sequence)))))

; so y is the recusive call that accumulates
(define (my-map p sequence)
  (accumulate (lambda (x y) (cons (p x) y)) #nil sequence))
;let x1 be the x of the first call, x2 the one of the second etc...
; then the recursive calls have (cons (p x1) y) -> (cons (p x1) (cons (p x2) y)) .... 

(define (my-append seq1 seq2)
  (accumulate cons seq2 seq1))
; then seq1 is the initial and seq2 is the sequence
; so you get (cons (car seq 2) (accum cons seq1 (cdr seq2))) ->
; (cons (car seq 2) (cons seq21 (accum cons seq1 (cdr seq21))))... 
; ending with seq1 as the init state at the end.. so you want to reverse the order of 
; args to make it not be backwards

(define (my-length sequence)
  (accumulate (lambda (x y) (+ 1 y) 0 sequence)))
; (+ 1 (accum lproc 0 (cdr sequence))) -> (+ 1 (+ 1 ......... 0))
