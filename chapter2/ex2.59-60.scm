#! /usr/bin/csi -s

; book stuff

(define (element-of-set? x set)
  (cond ((null? set) #f)
        ((equal? x (car set)) #t)
        (else (element-of-set? x (cdr set)))))

(define (adjoin-set x set)
  (if (element-of-set? x set) set (cons x set)))

;2.59
(define (union-set s1 s2)
  (define (union-iter set result)
    (if (null? set) result
      (union-set (cdr set) (adjoin-set (car set) result))))
  (union-iter s1 s2))

;2.60

; for allowing duplicates
;element-of-set? remains the exact same

;don't need to check for existence, drops to O(1) time
(define (adj-set x set)
  (cons x set))

;union of set can stay the same but since it's using adjoin-set,
;O(1)*n = O(n)

;intersection-of-set needs element-of-set so time complexity stays O(n^2)


