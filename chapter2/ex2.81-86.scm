#! /usr/bin/csi -s

;2.81

; a
; using that put-coercion method to put coercions to the exact same types
; for each, will lead to an infinite loop. why? because if it can't find
; the procedure for the two types in the table, it recurses on the coerced
; types. if the coerced types are the same, it'll keep doing this over
; and over and over...

; b
; something didn't have to be done, it works as is, and fails when it should; fail

; c
(define (apply-generic op . args)
  (define (error-out type-tags)
    (error "No method for these types" (list op type-tags)))
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc (apply proc (map contents args))
        (if (= (length args) 2)
          (let ((type1 (car type-tags))
                (type2 (cadr type-tags))
                (a1 (car args))
                (a2 (cadr args)))
            (if (eq? type1 type2) (error-out type-tags)
              (let ((t1->t2 (get-coercion type1 type2))
                    (t2->t1 (get-coercion type2 type1)))
                (cond (t1->t2 (apply-generic op (t1->t2 a1) a2))
                      (t2->t1 (apply-generic op a1 (t2->t1 a2)))
                      (else (error-out type-tags))))))
          (error-out type-tags))))))
