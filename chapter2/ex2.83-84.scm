#! /usr/bin/csi -s

; 2.83

; tower = integer -> rational -> real -> complex

(define (raise x) (apply-generic 'raise x))

(put 'raise 'integer (lambda (x) (make-rational x 1)))

(put 'raise 'rational (lambda (x) (/ (numer x) (denom x))))

(put 'raise 'real (lambda (x) (make-from-real-imag x 0)))

; 2.84
(define (apply-generic op . args)
  (define type-tower '(integer rational real complex))
  (define (higher-type type1 type2)
    (let ((l1 (memq type1 type-tower))
          (l2 (memq type2 type-lower)))
      ;both types should be in the type-tower, or else we have problems...
      (if (not (and (pair? l1) (pair? l2))) #f
        (let ((len1 (length l1))
              (len2 (length l2)))
          (if (< len1 len2) type1 type2)))))
  ;do successive raises
  (define (raise2 curarg goal-type)
    (let ((curtype (type-tag curarg)))
      ; if already the higher type, do nothing
      (if (eq? curtype (higher-type goal-type curtype)) curarg
        (raise2 (raise curarg) goal-type))))
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
            (let ((htype (higher-type type1 type2)))
              (cond ((eq? htype type1) (apply-generic op a1 (raise2 a2 type1)))
                    ((eq? htype type2) (apply-generic op (raise2 a1 type2) a2))
                    (else (error-out type-tags))))))))))
