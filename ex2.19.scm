#! /usr/bin/guile-2.0 --no-auto-compile
!#

(define us-coins (list 50 25 10 5 1))
(define uk-coins (list 100 50 20 10 5 2 1 0.5))

(define (first-denomination denoms) (car denoms))
(define (except-first-denomination denoms) (cdr denoms))
(define (no-more? denoms) (null? denoms))

(define (cc amount coin-values)
  ;sol
  (cond ((= amount 0) 1)
        ;no sol
        ((or (< amount 0) (no-more? coin-values)) 0)
        (else
          (+ (cc amount
                 (except-first-denomination
                   coin-values))
             (cc (- amount
                    (first-denomination
                      coin-values))
                 coin-values)))))

;order doesn't change soln because we iterate through all possibilities
;just with a specific order. 
