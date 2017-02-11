#! /usr/bin/guile-2.0 --no-auto-compile
!#

(define (same-parity x . y)
  ;if current elt has same parity as x
  (define sp-same?
    (if (= (remainder x 2) 0) even? odd?))
  (define (par-list z)
    (if (null? z) z
      (let ((cur (car z))
            (parse-rest (par-list (cdr z))))
        (if (sp-same? cur) (cons cur parse-rest)
          parse-rest
        ))))
  (cons x (par-list y)))

