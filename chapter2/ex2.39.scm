#! /usr/bin/guile-2.0 --no-auto-compile
!#

; some notes:
; fold-right is recursive applying the op in reverse order, but keeping the first
; elt in the list as the first arg of the operation (at the very end)
(define (fold-right op initial sequence)
  (if (null? sequence)
    initial
    (op (car sequence)
        (fold-right op initial (cdr sequence)))))

;fold-left is the same as foldl following but the args are reversed
;(and since it uses a helper function, it needs to return result at the end
(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
      result
      (iter (op result (car rest))
            (cdr rest))))
  (iter initial sequence))

;for kix
;foldl (fold in srfi-1), applies the operator iteratively
;meaning the list is processed in the right order but since first arg
; becomes second arg the next iteration, if you're consing the list
; is returned in reverse
(define (foldl op init seq)
  (if (null? seq)
    init
    (foldl op (op (car seq) init) (cdr seq))))

(define (reverse-right sequence)
  (fold-right (lambda (first rev) (append rev (list first))) #nil sequence))
;if lambda was (cons i j), and input (list 1 2 3 4), then it would be
; (cons 4 #nil) -> (cons 3 (cons 4 #nil)) -> (cons 2 (cons 3 (cons 4 #nil)))
; -> (cons 1 (cons 2 (cons 3 (cons 4 #nil))))


(define (reverse-left sequence)
  (fold-left (lambda (res first) (cons first res)) #nil sequence))

(define (reversel seq)
  (foldl (lambda (i j) (cons i j)) #nil seq))
; (list 1 2 3 4) -> (cons 1 #nil) -> (cons 2 (cons 1 #nil)) .... 
