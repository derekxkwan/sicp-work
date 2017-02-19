#! /usr/bin/csi -s

;2.61
(define (adjoin-set-ordered x set)
  (if (null? set) (list x)
    (let ((cur (car set)))
      (cond ((< x cur) (cons x set)) ; can't be in set
            ((= x cur) set) ; already in set
            (else (cons cur (adjoin-set-ordered x (cdr set))))
            ;try again against next elt of set
                        ))))
;2.62
(define (union-set-ordered s1 s2)
  (define (union-ord-iter set result)
    (cond ((null? set) result)
          ((null? result) set)
          (else 
            (let ((ins (car set)) ;what we're trying to insert
                  (cmp (car result))) ;what we're comparing to
              (cond ((< ins cmp) (cons ins (union-ord-iter (cdr set) result)))
                    ; ins is guaranteed to be in
                    ((= ins cmp) (union-ord-iter (cdr set) result))
                    ; ins can't be in
                    (else (cons cmp (union-ord-iter set (cdr result))))
                    ;cmp guaranteed to be in 
                    )))))
    (union-ord-iter s1 s2))

