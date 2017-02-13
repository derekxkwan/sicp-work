#lang sicp
(#%require sicp-pict)

#| old up-split
(define (up-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (up-split painter (- n 1))))
        (below painter (beside smaller smaller)))))
|#

(define (split orig recurse)
  (lambda (painter n)
    (if (= n 0) painter
        (let ((smaller ((split orig recurse) painter (- n 1))))
          (orig painter (recurse smaller smaller))))
    ))


(define up-split (split below beside))
(define right-split (split beside below))
(paint (up-split einstein 3))
(paint (right-split einstein 3))
