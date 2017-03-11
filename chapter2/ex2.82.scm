#! /usr/bin/csi -s

;2.82

(require-extension srfi-1)

(define (apply-generic op . args)
  (define (can-coerce? type arg-list)
    (let ((type-list (map type-tags arg-list)))
      (every (lambda (curtype) (or (equal? curtype type) (get-coercion curtype type))) type-list)))
  (define (coerce-list type arg-list)
    (map (lambda (curarg) 
           (if (equal? type (type-tag curarg)) curarg
             ((get-coercion (type-tag curarg) type) curarg))) arg-list))
  ; if there's a proc for given type tags, return it, else return false
  (define (get-proc arg-list)
    (let ((type-tags (map type-tags arg-list)))
      (get op type-tags)))
  (define (ag-iter parse-list)
    (if (null? parse-list) (error "no method for this combination" (list op args))
      (let ((curtype (type-tag (car parse-list)))
            (rest (cdr parse-list)))
        (if (can-coerce? curtype args) (apply (get-proc args) (map contents args))
          (ag-iter (cdr parse-list))))))
  (let ((proc (get-proc args)))
    (if proc (apply proc args)
      (ag-iter args))))

;haven't tested this code out since don't have get or get-coercion, but the idea is to try
; out the args as is, then coercing to each elt iteratively testing with can-coerce?
; to see if we can actually coerce to a given type in the first place...

; this strategy of attempting coercion iteratively to each elt of the list doesn't consider
; the case if there doesn't exist a proc for while trying to coerce iteratively but there 
; does exist a proc for common supertypes of the given types.

