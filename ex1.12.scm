#! /usr/bin/guile-2.0 -s
!#

#| go by row col, pascal 0 0 = 1, 1 0 = 0 -1 + 0 0 = 0 + 1 = 1
    1 1 = 0 0 + 0 1 = 1
    2 0 = 1 -1 + 1 0 = 0 + 1 = 1, 2 1 = 1 0 + 1 1 = 1 + 1 = 2
|#

(define (pascal row col)
  (cond ((and (= row 0) (= col 0)) 1)
    ((or (< row 0) (< col 0)) (< row col) 0)
        (else (+ (pascal (- row 1) (- col 1))
                 (pascal (- row 1) col)
                 ))
        ))



